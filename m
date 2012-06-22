From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ALSA: hda - Don't power up when not
	powered down.
Date: Thu, 21 Jun 2012 23:57:43 -0700
Message-ID: <CAEUnVG4ONrP=0ApZWZWwUC5ejcipjqvGQH_eycgU8sJYhBsZyQ@mail.gmail.com>
References: <1340340682-29695-1-git-send-email-dgreid@chromium.org>
	<s5hk3yz51l2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 64D3E243AA
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 07:36:55 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so1038824wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2012 23:58:08 -0700 (PDT)
In-Reply-To: <s5hk3yz51l2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 21, 2012 at 10:59 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 21 Jun 2012 21:51:22 -0700,
> Dylan Reid wrote:
>>
>> After cancel_delayed_work_sync returns, the power down work either never
>> started (power_on =3D=3D 1) or finished (power_on =3D=3D 0). =A0In the f=
ormer case
>> there is no need to power up again.
>>
>> Signed-off-by: Dylan Reid <dgreid@chromium.org>
>
> There is still a small window between cancel_delayed_work_sync() and
> the spinlock, so the power down might happen between them, in theory.
> (And due to the obvious reason, cancel_delayed_work_sync() can't be in
> =A0spinlock :)

I'm probably missing something here, but I think three scenarios could
happen during that window:

1) snd_hda_suspend or snd_hda_codec_reset, which will leave power_on =3D
0, and when power_up gets the spin lock it will turn back on.  I don't
think that's a problem, power_count is still > 0 so it should be on.

2) snd_hda_power_down is called and power_count goes to zero while
power_on =3D=3D 0.  Might be a problem, this would not schedule new power
down work.
  Is this expected?  One thread calling power_up moving the count from
0 to 1 and another thread (that must not have called power_up) calling
power_down?
  This hole could be plugged by checking if power_count is still >0
after getting the spin lock. does that sound right?

3)  snd_hda_power_down is called and schedules new work, I think this
is OK because when hda_power_work runs it will check power_count and
do the right thing.


Thanks for the quick response,

Dylan
>
>
> thanks,
>
> Takashi
>
>> ---
>> =A0sound/pci/hda/hda_codec.c | =A0 =A07 +++++++
>> =A01 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
>> index 604699c..045b5e7 100644
>> --- a/sound/pci/hda/hda_codec.c
>> +++ b/sound/pci/hda/hda_codec.c
>> @@ -4444,6 +4444,13 @@ static void __snd_hda_power_up(struct hda_codec *=
codec, bool wait_power_down)
>> =A0 =A0 =A0 cancel_delayed_work_sync(&codec->power_work);
>>
>> =A0 =A0 =A0 spin_lock(&codec->power_lock);
>> + =A0 =A0 /* If the power down delayed work was cancelled above before s=
tarting,
>> + =A0 =A0 =A0* then there is no need to go through power up here.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (codec->power_on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&codec->power_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> =A0 =A0 =A0 trace_hda_power_up(codec);
>> =A0 =A0 =A0 snd_hda_update_power_acct(codec);
>> =A0 =A0 =A0 codec->power_on =3D 1;
>> --
>> 1.7.9.rc0
>>
