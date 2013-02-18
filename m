From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Remove speaker clicks on
	CX20549
Date: Mon, 18 Feb 2013 10:40:55 +0100
Message-ID: <5121F727.7000108@canonical.com>
References: <1360838199-3906-1-git-send-email-david.henningsson@canonical.com>
 <s5hd2w3upmk.wl%tiwai@suse.de> <5121F2CB.7000504@canonical.com>
 <s5h4nhahsxi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 371E1264F07
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 10:40:58 +0100 (CET)
In-Reply-To: <s5h4nhahsxi.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/18/2013 10:28 AM, Takashi Iwai wrote:
> At Mon, 18 Feb 2013 10:22:19 +0100,
> David Henningsson wrote:
>>
>> On 02/14/2013 12:00 PM, Takashi Iwai wrote:
>>> At Thu, 14 Feb 2013 11:36:39 +0100,
>>> David Henningsson wrote:
>>>>
>>>> This chip needs the speaker pin to go to D3 to avoid clicks,
>>>> so default_power_filter does not work here.
>>>>
>>>> This was found on Thinkpad R61i/T61i but I guess it applies to
>>>> the entire chip. If not, quirks should be set for at least
>>>> PCI SSID 17aa:20ac.
>>>>
>>>> Thanks to c4pp4 for testing.
>>>>
>>>> BugLink: https://bugs.launchpad.net/bugs/886975
>>>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>>>
>>> Thanks, applied now.
>>>
>>> Just wonder, though, whether rather setting
>>> spec->gen.power_down_unused = 1 works.  When it's set, the generic
>>> parser applies the own power filter, and it doesn't have the EAPD
>>> check either (plus it does more aggressive power-down of unused
>>> widgets).
>>>
>>> Or, maybe we just drop the EAPD check, and move it to specific fixup.
>>> AFAIK, it was required only for old Gateway laptops.
>>
>> If gen.power_down_unused is what is believed to get the best power
>> savings (by powering down more sub-areas of the chip), maybe a
>> reasonable strategy to be to carefully move towards making
>> gen.power_down_unused the default, first for the stuff that we have hw
>> for and can test, or the new chips that we add, and if that works out
>> fine we could try activate it for older chips too.
>
> Yes, power_down_unused is pretty aggressive, and should be enabled
> selectively.  (And this can be enabled even now with a hint string.)
>
> OTOH, EAPD check we had was really a workaround for some old machines,
> AFAIK, only for Gateway machines.  This can be disabled as default
> like the patch below.  But it's the thing for post-3.9, just to be
> safer.
>
>
> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index 04b5738..c2fe09d 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -1296,8 +1296,6 @@ static bool snd_hda_codec_get_supported_ps(struct hda_codec *codec,
>
>   static unsigned int hda_set_power_state(struct hda_codec *codec,
>   				unsigned int power_state);
> -static unsigned int default_power_filter(struct hda_codec *codec, hda_nid_t nid,
> -					 unsigned int power_state);
>
>   /**
>    * snd_hda_codec_new - create a HDA codec
> @@ -1418,7 +1416,6 @@ int snd_hda_codec_new(struct hda_bus *bus,
>   #endif
>   	codec->epss = snd_hda_codec_get_supported_ps(codec, fg,
>   					AC_PWRST_EPSS);
> -	codec->power_filter = default_power_filter;
>
>   	/* power-up all before initialization */
>   	hda_set_power_state(codec, AC_PWRST_D0);
> @@ -3759,8 +3756,9 @@ static unsigned int hda_sync_power_state(struct hda_codec *codec,
>   }
>
>   /* don't power down the widget if it controls eapd and EAPD_BTLENABLE is set */
> -static unsigned int default_power_filter(struct hda_codec *codec, hda_nid_t nid,
> -					 unsigned int power_state)
> +unsigned int snd_hda_codec_eapd_power_filter(struct hda_codec *codec,
> +					     hda_nid_t nid,
> +					     unsigned int power_state)
>   {
>   	if (power_state == AC_PWRST_D3 &&
>   	    get_wcaps_type(get_wcaps(codec, nid)) == AC_WID_PIN &&
> @@ -3772,6 +3770,7 @@ static unsigned int default_power_filter(struct hda_codec *codec, hda_nid_t nid,
>   	}
>   	return power_state;
>   }
> +EXPORT_SYMBOL_HDA(snd_hda_codec_eapd_power_filter);
>
>   /*
>    * set power state of the codec, and return the power state
> @@ -3817,7 +3816,8 @@ static void sync_power_up_states(struct hda_codec *codec)
>   	int i;
>
>   	/* don't care if no or standard filter is used */

I don't mind moving it into patch_stac9200 if you think it's the right 
thing to do, but if we do, perhaps the default_power_filter / 
snd_hda_codec_eapd_power_filter function should move there too, and 
become local to patch_sigmatel.c?

If so the below check has to be changed into yet another flag.

> -	if (!codec->power_filter || codec->power_filter == default_power_filter)
> +	if (!codec->power_filter ||
> +	    codec->power_filter == snd_hda_codec_eapd_power_filter)
>   		return;
>
>   	for (i = 0; i < codec->num_nodes; i++, nid++) {
> diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
> index 05f1d59..ef798bd 100644
> --- a/sound/pci/hda/hda_local.h
> +++ b/sound/pci/hda/hda_local.h
> @@ -670,6 +670,10 @@ snd_hda_check_power_state(struct hda_codec *codec, hda_nid_t nid,
>   	return (state != target_state);
>   }
>
> +unsigned int snd_hda_codec_eapd_power_filter(struct hda_codec *codec,
> +					     hda_nid_t nid,
> +					     unsigned int power_state);
> +
>   /*
>    * AMP control callbacks
>    */
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index 941bf6c..7d941ef 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -3350,7 +3350,6 @@ static int patch_conexant_auto(struct hda_codec *codec)
>   	switch (codec->vendor_id) {
>   	case 0x14f15045:
>   		codec->single_adc_amp = 1;
> -		codec->power_filter = NULL; /* Needs speaker amp to D3 to avoid click */
>   		break;
>   	case 0x14f15047:
>   		codec->pin_amp_workaround = 1;
> diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
> index 83d5335..d57c81e 100644
> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -3774,6 +3774,7 @@ static int patch_stac9200(struct hda_codec *codec)
>   	spec->gen.own_eapd_ctl = 1;
>
>   	codec->patch_ops = stac_patch_ops;
> +	codec->power_filter = snd_hda_codec_eapd_power_filter;
>
>   	snd_hda_add_verbs(codec, stac9200_eapd_init);
>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
