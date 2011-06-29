From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] Acer aspire 3830TG and Conexant 506c/20588
Date: Wed, 29 Jun 2011 10:16:51 +0100
Message-ID: <4E0AED83.6020005@canonical.com>
References: <4E09BE93.8060503@canonical.com>	<s5hzkl2ywwj.wl%tiwai@suse.de>
	<s5htyb9rv7k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id E863D1038B6
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 11:16:53 +0200 (CEST)
In-Reply-To: <s5htyb9rv7k.wl%tiwai@suse.de>
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

On 2011-06-29 07:46, Takashi Iwai wrote:
> At Tue, 28 Jun 2011 14:15:40 +0200,
> Takashi Iwai wrote:
>>
>> At Tue, 28 Jun 2011 12:44:19 +0100,
>> David Henningsson wrote:
>>>
>>> The new Conexant 5066 auto-parser is barely finished and already we
>>> might need a quirk system for it...
>>>
>>> Anyway, in this bug, the internal speaker is not working (and was not
>>> working before the auto-parser either). I'm attaching two patches that
>>> are quite simple, and at least the first one (add ID 506c) I think
>>> should be applied right away.
>>
>> Thanks, applied to fix/hda for 3.0-rc.  Meanwhile, I'll change the
>> branch for 3.1 to enable model=auto as default for Conexant (Thanks
>> for remind :)
>>
>>> The problem: The internal speaker is at node 0x1f and you need to turn
>>> on EAPD on node 0x1b for the speaker to sound. Now I'm not sure how to
>>> fix this in the best way. An "init verb" quirk, or a "use EAPD from this
>>> pin" quirk? Try to copy-paste realtek's quirk system, and if so,
>>> refactor it into hda_codec.c, or write something new?
>>>
>>> What are your ideas?
>>
>> We can simply turn on all EAPDs for 5066 and older chips.
>> These codecs have just one or two EAPD pins, and we have no tightly
>> coupled EAPD control (yet), so it'd be safe to turn all on.
>
> Or, maybe something like below would be cleverer...
> (Totally untested, of course.)

Yes, very nice, I was thinking of something like that. That will be best 
from a power consumption perspective. My only worry is that if turning 
EAPD on and off causes pops (I don't know if they do), it will be better 
to leave it on all the time.

> From: Takashi Iwai<tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Handle extra EAPD in Conexant auto-parser
>
> There seem some machines referring to EAPD bit of the unassigned pin
> for the speaker EAPD of a different pin, thus we need to control the
> EAPD of unused pins as well.
>
> Signed-off-by: Takashi Iwai<tiwai@suse.de>
> ---
>   sound/pci/hda/patch_conexant.c |   42 +++++++++++++++++++++++++++++++++++++++-
>   1 files changed, 41 insertions(+), 1 deletions(-)
>
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index 4ca880b..dbea3d0 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -155,6 +155,10 @@ struct conexant_spec {
>   	unsigned int mic_boost; /* offset into cxt5066_analog_mic_boost */
>
>   	unsigned int beep_amp;
> +
> +	/* extra EAPD pins */
> +	unsigned int num_eapds;
> +	hda_nid_t eapds[4];
>   };
>
>   static int conexant_playback_pcm_open(struct hda_pcm_stream *hinfo,
> @@ -3485,7 +3489,7 @@ static void cx_auto_update_speakers(struct hda_codec *codec)
>   	/* if LO is a copy of either HP or Speaker, don't need to handle it */
>   	if (cfg->line_out_pins[0] == cfg->hp_pins[0] ||
>   	    cfg->line_out_pins[0] == cfg->speaker_pins[0])
> -		return;
> +		goto turn_extra_eapd;
>   	if (spec->auto_mute) {
>   		/* mute LO in auto-mode when HP jack is present */
>   		if (cfg->line_out_type == AUTO_PIN_SPEAKER_OUT ||
> @@ -3495,6 +3499,9 @@ static void cx_auto_update_speakers(struct hda_codec *codec)
>   			on = 1;
>   	}
>   	do_automute(codec, cfg->line_outs, cfg->line_out_pins, on);
> + turn_extra_eapd:
> +	/* turn on/off extra EAPDs, too */
> +	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, on);
>   }
>
>   static void cx_auto_hp_automute(struct hda_codec *codec)
> @@ -3901,6 +3908,38 @@ static void cx_auto_parse_beep(struct hda_codec *codec)
>   #define cx_auto_parse_beep(codec)
>   #endif
>
> +static bool found_in_nid_list(hda_nid_t nid, const hda_nid_t *list, int nums)
> +{

Hmm, I've seen variations of this function at more than one place 
already. Maybe a function like this would be good to have in hda_codec.c?

int snd_hda_find_nid(hda_nid_t nid, const hda_nid_t *list, int list_length)
{
	int i;
	for (i = 0; i < list_length; i++)
		if (list[i] == nid)
			return i;
	return -1;
}

#define bool snd_hda_nid_exists(nid, list, list_length) 
(snd_hda_find_nid(nid, list, list_length) != -1)

> +	int i;
> +	for (i = 0; i<  nums; i++)
> +		if (list[i] == nid)
> +			return true;
> +	return false;
> +}
> +
> +/* parse extra-EAPD that aren't assigned to any pins */
> +static void cx_auto_parse_eapd(struct hda_codec *codec)
> +{
> +	struct conexant_spec *spec = codec->spec;
> +	struct auto_pin_cfg *cfg =&spec->autocfg;
> +	hda_nid_t nid, end_nid;
> +
> +	end_nid = codec->start_nid + codec->num_nodes;
> +	for (nid = codec->start_nid; nid<  end_nid; nid++) {
> +		if (get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_PIN)
> +			continue;
> +		if (!(snd_hda_query_pin_caps(codec, nid)&  AC_PINCAP_EAPD))
> +			continue;
> +		if (found_in_nid_list(nid, cfg->line_out_pins, cfg->line_outs) ||
> +		    found_in_nid_list(nid, cfg->hp_pins, cfg->hp_outs) ||
> +		    found_in_nid_list(nid, cfg->speaker_pins, cfg->speaker_outs))
> +			continue;
> +		spec->eapds[spec->num_eapds++] = nid;
> +		if (spec->num_eapds>= ARRAY_SIZE(spec->eapds))
> +			break;
> +	}
> +}
> +
>   static int cx_auto_parse_auto_config(struct hda_codec *codec)
>   {
>   	struct conexant_spec *spec = codec->spec;
> @@ -3914,6 +3953,7 @@ static int cx_auto_parse_auto_config(struct hda_codec *codec)
>   	cx_auto_parse_input(codec);
>   	cx_auto_parse_digital(codec);
>   	cx_auto_parse_beep(codec);
> +	cx_auto_parse_eapd(codec);
>   	return 0;
>   }
>


-- 
David Henningsson
http://launchpad.net/~diwic
