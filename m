From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: [PATCH] ALSA: hda - modem function group wake on
	ring support
Date: Thu, 7 Jun 2012 18:09:28 +0800
Message-ID: <CA+v+29ifDCMzkDimYD6kTsqSCT9LxaBwaKr7KXg2a=yX-Z3g=w@mail.gmail.com>
References: <1339059153-4166-1-git-send-email-xingchao.wang@intel.com>
	<s5haa0f79n4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f50.google.com (mail-qa0-f50.google.com
	[209.85.216.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 448E710B941
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 12:09:49 +0200 (CEST)
Received: by qafl39 with SMTP id l39so35136qaf.2
	for <alsa-devel@alsa-project.org>; Thu, 07 Jun 2012 03:09:48 -0700 (PDT)
In-Reply-To: <s5haa0f79n4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, fengguang.wu@intel.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

2012/6/7 Takashi Iwai <tiwai@suse.de>:
> At Thu, =A07 Jun 2012 16:52:33 +0800,
> Wang Xingchao wrote:
>>
>> =A0D2 allows for the lowest possible power consuming
>> =A0state from which it can return to "fully on" state D0 within 2ms.
>> =A0For modems, it's the "wake on ring" power state.
>>
>> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
>> ---
>> =A0sound/pci/hda/hda_codec.c | =A0 12 ++++++++++++
>> =A01 file changed, 12 insertions(+)
>>
>> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
>> index 2737fe7..d0ca370 100644
>> --- a/sound/pci/hda/hda_codec.c
>> +++ b/sound/pci/hda/hda_codec.c
>> @@ -3542,6 +3542,18 @@ static void hda_set_power_state(struct hda_codec =
*codec, hda_nid_t fg,
>> =A0 =A0 =A0 snd_hda_codec_set_power_to_all(codec, fg, power_state, true);
>> =A0}
>>
>> +/* modem wake on ring: transition from D2 to D0 in less than 2ms. For m=
odems,
>> + * this is the wake-on-ring power state =A0*/
>> +static void hda_modem_wake_on_ring(struct hda_codec *codec, bool enter)
>> +{
>> + =A0 =A0 if (codec->mfg) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (enter)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hda_set_power_state(codec, cod=
ec->mfg, AC_PWRST_D2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hda_set_power_state(codec, cod=
ec->mfg, AC_PWRST_D0);
>> + =A0 =A0 }
>> +}
>> +
>> =A0#ifdef CONFIG_SND_HDA_HWDEP
>> =A0/* execute additional init verbs */
>> =A0static void hda_exec_init_verbs(struct hda_codec *codec)
>
> No caller of the new function? =A0Otherwise it's useless...
>
Hi Takashi,

I have not see codec indicates "Modem function group" yet, do you know
which codec on HDA as Modem type and i could search whether it need
such "wake on ring" feature.

This patch should bring codec out of D2 states in less than 2ms. It
should help modem save power with "wake-on-ring" feature.

thanks
--xingchao
