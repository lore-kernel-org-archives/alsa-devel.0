From: Robert Krakora <rob.krakora@messagenetsystems.com>
Subject: Re: 2.6.30: xruns caused by "ALSA: pcm - Safer
	boundary checks"
Date: Wed, 27 May 2009 08:13:21 -0400
Message-ID: <b24e53350905270513p6e646a1n3f5b4d1124585c47@mail.gmail.com>
References: <20090522162709.2e04b688@dhcp-100-2-144.bos.redhat.com>
	<s5hocthd9kb.wl%tiwai@suse.de> <4A1A4128.9050305@cygnusx-1.org>
	<s5hmy905m01.wl%tiwai@suse.de>
	<b24e53350905260728k1022137av2389e334a5c73d7d@mail.gmail.com>
	<s5hvdnn7ty3.wl%tiwai@suse.de>
	<b24e53350905261016ud14094vbb166e7145b66c6f@mail.gmail.com>
	<s5hzlcz9g3e.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0905270912240.4067@eeebox2.perex-int.cz>
	<s5hfxeq7rq9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 53B6924365
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 14:13:23 +0200 (CEST)
Received: by gxk2 with SMTP id 2so8600398gxk.8
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2009 05:13:22 -0700 (PDT)
In-Reply-To: <s5hfxeq7rq9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, alsa-devel@cygnusx-1.org, Chuck Ebbert <cebbert@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 27, 2009 at 6:41 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 27 May 2009 09:25:57 +0200 (CEST),
> Jaroslav Kysela wrote:
>>
>> On Wed, 27 May 2009, Takashi Iwai wrote:
>>
>> > Thanks for testing!
>> >
>> > I have an impression that the jiffies check can behave pretty buggy in
>> > cases the hardware doesn't give a smooth pointer update. =A0It's
>> > supposed to filter out spontaneous invalid pointer values. =A0That'll
>> > work indeed (although I don't think the check in
>> > snd_pcm_period_elapsed() is worth). =A0But what if a hardware returns
>> > the pointer value that is not always updated smoothly?
>> >
>> > Assume a hardware returning only spontaneously updated values, 0 at
>> > t=3D0, 1000 at t=3D100, 2000 at t=3D200, and so on. =A0If
>> > snd_pcm_update_hw_ptr() is called at t=3D99, it gets still position 0.
>> > Then when it's called at t=3D100, it suddenly increases to position 10=
00
>> > while jiffies delta is only 1. =A0The current code would filter out th=
is
>> > update because it appears as if too much.
>>
>> That's good point. The hw_ptr_jiffies should be updated only when positi=
on
>> in the ring buffer moves:
>>
>> =A0 =A0 =A0 if (runtime->status->hw_ptr !=3D new_hw_ptr)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 runtime->hw_ptr_jiffies =3D jiffies;
>>
>> Similar condition might be also used for runtime->status->tstamp variabl=
e.
>
> Yep, that'll be needed.
>
>
>> > The problem continues, if snd_pcm_update_hw_ptr() is constantly called
>> > at each t=3D100, 101, ... =A0At each call, jiffies delta is 1, but the
>> > position delta is still 1000 because it wasn't updated. =A0That is, as
>> > long as the app keeps calling snd_pcm_update_hw_ptr(), the position
>> > won't be updated. =A0This is pretty possible especially with an app li=
ke
>> > pulseaudio.
>> >
>> >
>> > I have a feeling that we should disable the jiffies check in that
>> > part, at least for 2.6.30, until a better solution is found. =A0The
>> > jiffies check is already done and works pretty well in the driver
>> > side (hda-intel and intel8x0). =A0But this check in the PCM core can be
>> > (not always, though) buggy, and actually gives problems sometimes.
>>
>> As I already wrote, I have nothing against to make jiffies check
>> conditional on xrun_debug() for 2.6.30 for debugging purposes, but I'd
>> like to leave this code enabled in our development trees. It reveals some
>> buggy drivers which should be checked (a new one is Vortex - au88x0).
>
> OK, I created a patch below and will included in the next pull
> request today or tomorrow.
>
>
> thanks,
>
> Takashi
>
> =3D=3D=3D
> >From c87d9732004b3f8fd82d729f12ccfb96c0df279e Mon Sep 17 00:00:00 2001
> From: Takashi Iwai <tiwai@suse.de>
> Date: Wed, 27 May 2009 10:53:33 +0200
> Subject: [PATCH] ALSA: Enable PCM hw_ptr_jiffies check only in xrun_debug=
 mode
>
> The PCM hw_ptr jiffies check results sometimes in problems when a
> hardware doesn't give smooth hw_ptr updates. =A0So far, au88x0 and some
> other drivers appear not working due to this strict check.
> However, this check is a nice debug tool, and the capability should be
> still kept.
>
> Hence, we disable this check now as default unless the user enables it
> by setting the xrun_debug mode to the specific stream via a proc file.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> =A0Documentation/sound/alsa/Procfile.txt | =A0 =A05 +++++
> =A0sound/core/pcm_lib.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A09 +++=
+++++-
> =A02 files changed, 13 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/sound/alsa/Procfile.txt b/Documentation/sound/=
alsa/Procfile.txt
> index bba2dbb..cfac20c 100644
> --- a/Documentation/sound/alsa/Procfile.txt
> +++ b/Documentation/sound/alsa/Procfile.txt
> @@ -104,6 +104,11 @@ card*/pcm*/xrun_debug
> =A0 =A0 =A0 =A0When this value is greater than 1, the driver will show the
> =A0 =A0 =A0 =A0stack trace additionally. =A0This may help the debugging.
>
> + =A0 =A0 =A0 Since 2.6.30, this option also enables the hwptr check using
> + =A0 =A0 =A0 jiffies. =A0This detects spontaneous invalid pointer callba=
ck
> + =A0 =A0 =A0 values, but can be lead to too much corrections for a (most=
ly
> + =A0 =A0 =A0 buggy) hardware that doesn't give smooth pointer updates.
> +
> =A0card*/pcm*/sub*/info
> =A0 =A0 =A0 =A0The general information of this PCM sub-stream.
>
> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index 3eea98a..d659995 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -249,6 +249,11 @@ static int snd_pcm_update_hw_ptr_interrupt(struct sn=
d_pcm_substream *substream)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_hw_ptr =3D hw_base + p=
os;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 /* Do jiffies check only in xrun_debug mode */
> + =A0 =A0 =A0 if (!xrun_debug(substream))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto no_jiffies_check;
> +
> =A0 =A0 =A0 =A0/* Skip the jiffies check for hardwares with BATCH flag.
> =A0 =A0 =A0 =A0 * Such hardware usually just increases the position at ea=
ch IRQ,
> =A0 =A0 =A0 =A0 * thus it can't give any strange position.
> @@ -336,7 +341,9 @@ int snd_pcm_update_hw_ptr(struct snd_pcm_substream *s=
ubstream)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hw_base =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_hw_ptr =3D hw_base + pos;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 if (((delta * HZ) / runtime->rate) > jdelta + HZ/100) {
> + =A0 =A0 =A0 /* Do jiffies check only in xrun_debug mode */
> + =A0 =A0 =A0 if (xrun_debug(substream) &&
> + =A0 =A0 =A0 =A0 =A0 ((delta * HZ) / runtime->rate) > jdelta + HZ/100) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hw_ptr_error(substream,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "hw_ptr skipping!=
 "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(pos=3D%ld, delt=
a=3D%ld, period=3D%ld, jdelta=3D%lu/%lu)\n",
> --
> 1.6.3
>
>
>

Takashi:

I will test this patch.  Also, I have some results from the test with
arecord that Jaroslav wanted.

Best Regards,

-- =

Rob Krakora
Senior Software Engineer
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677 Ext. 206
(317)663-0808 Fax
