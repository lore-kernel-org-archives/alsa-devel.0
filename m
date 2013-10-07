From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] ALSA: hda - hdmi: Fix channel map switch
	not taking effect
Date: Mon, 07 Oct 2013 13:31:17 +0300
Message-ID: <73e325dd7c696e2d16946890a66dc838@mail.onse.fi>
References: <1380737612-16512-1-git-send-email-anssi.hannula@iki.fi>
 <s5hzjqlseqt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id F309026509A
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 12:31:21 +0200 (CEST)
In-Reply-To: <s5hzjqlseqt.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai kirjoitti 2013-10-07 10:48:
> At Wed,  2 Oct 2013 21:13:32 +0300,
> Anssi Hannula wrote:
> 
> Currently hdmi_setup_audio_infoframe() reprograms the HDA channel
> mapping only when the infoframe is not up-to-date or the non-PCM flag
> has changed.
> 
> However, when just the channel map has been changed, the infoframe may
> still be up-to-date and non-PCM flag may not have changed, so the new
> channel map is not actually programmed into the HDA codec.
> 
> Notably, this failing case is also always triggered when the device is
> already in a prepared state and a new channel map is configured while
> changing only the channel positions (for example, plain
> "speaker-test -c2 -m FR,FL").
> 
> Fix that by keeping track of the last programmed channel map and making
> hdmi_setup_audio_infoframe() always update the hardware mapping if the
> channel map has changed.
> 
> Hmm, maybe it's easier (and safer) to remove the check and always call
> hdmi_setup_channel_mapping()?  Of course, the drawback is the
> unnecessary verbs, but it's not too much.

Easier, yes. I don't really have that good of an idea how big of a delay
do 8 write verbs cause, so I'll rely on your judgment :)

I guess I could replace the writes with read-and-write-if-differs cycles
when I add the set_slot ops for ATI/AMD, since it seems to be used for
other similar cases (like channel count)?

> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> Cc: <stable@vger.kernel.org>
> ---
> 
> BTW, is there some mechanism preventing hdmi_chmap_ctl_put() to be 
> called
> at the same time with generic_hdmi_playback_pcm_prepare() that I didn't
> see with a quick look?
> Both of them call hdmi_setup_audio_infoframe() which is not 
> thread-safe.
> 
> Yeah, we need to introduce a mutex there.

I guess hdmi_present_sense() is the same, as it can also call
hdmi_setup_audio_infoframe()?

BTW, shouldn't hdmi_present_sense() call hdmi_setup_audio_infoframe() 
always
when eld_changed is true? hdmi_setup_audio_infoframe() does not do its
stuff if !monitor_present, so if one starts playback before plugging in,
the channel mappings etc will never be set even when plug-in happens
(from what I can see, that is -  did not test yet).


> thanks,
> 
> Takashi
> 
> sound/pci/hda/patch_hdmi.c | 14 +++++++++++---
> 1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 7ea0245..09f38a1 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -74,6 +74,8 @@ struct hdmi_spec_per_pin {
> 	bool non_pcm;
> 	bool chmap_set;		/* channel-map override by ALSA API? */
> 	unsigned char chmap[8]; /* ALSA API channel-map */
> +	bool last_chmap_set;	/* channel-map override programmed? */
> +	unsigned char last_chmap[8]; /* last programmed channel-map */
> 	char pcm_name[8];	/* filled in build_pcm callbacks */
> };
> 
> @@ -955,15 +957,21 @@ static void hdmi_setup_audio_infoframe(struct 
> hda_codec *codec,
> 					    ai.bytes, sizeof(ai));
> 		hdmi_start_infoframe_trans(codec, pin_nid);
> 	} else {
> -		/* For non-pcm audio switch, setup new channel mapping
> -		 * accordingly */
> -		if (per_pin->non_pcm != non_pcm)
> +		/* For non-pcm audio switch or channel-map switch,
> +		 * setup new channel mapping accordingly */
> +		if (per_pin->non_pcm != non_pcm
> +		    || per_pin->chmap_set != per_pin->last_chmap_set
> +		    || (per_pin->chmap_set && memcmp(per_pin->chmap, 
> per_pin->last_chmap,
> +						     ARRAY_SIZE(per_pin->chmap)) != 0))
> 			hdmi_setup_channel_mapping(codec, pin_nid, non_pcm, ca,
> 						   channels, per_pin->chmap,
> 						   per_pin->chmap_set);
> 	}
> 
> 	per_pin->non_pcm = non_pcm;
> +	per_pin->last_chmap_set = per_pin->chmap_set;
> +	if (per_pin->chmap_set)
> +		memcpy(per_pin->last_chmap, per_pin->chmap, 
> ARRAY_SIZE(per_pin->chmap));
> }
> 
> 
> --
> 1.8.1.5
> 
