From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Don't overwrite the pin
	default configs
Date: Thu, 22 Nov 2012 18:02:34 +0100
Message-ID: <50AE5AAA.20007@canonical.com>
References: <s5hehjlr37b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 05D3D260325
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 18:02:35 +0100 (CET)
In-Reply-To: <s5hehjlr37b.wl%tiwai@suse.de>
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

On 11/22/2012 05:51 PM, Takashi Iwai wrote:
> Since we keep the pin default config values anyway internally, we
> don't have to set the values in the codec.  This patch removes the
> code writing the pincfg values.
>
> As a gratis bonus, we can remove also the code restoring the original
> pincfg values at PM resume or module free.  This will give us more
> benefit, as it can reduce the unnecessary power-up of codecs.
>
> This won't change the driver functionality.  The only difference would
> be that the codec proc file will show the original pincfg values
> instead of the actually referred values.  The actually referred values
> can be determined from sysfs *_pin_configs files.
> (Also hda-emu was updated to follow this change.)
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>
> David, this change may hit your QA test.  As mentioned, the only
> difference is the default pincfg outputs in proc files.

Thanks. I don't think it'll hit my testing as hda-emu and 
hda-jack-retask both read from the sysfs where available.

Not powering up the codecs might need some careful testing though? I 
remember the ivybridge-hdmi error (which I sent a patch for recently) 
was less likely to occur if codec was powered up after resume.



>
>   sound/pci/hda/hda_codec.c | 45 +++------------------------------------------
>   1 file changed, 3 insertions(+), 42 deletions(-)
>
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index d9fd439..c8f6c3b 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -991,19 +991,6 @@ static struct hda_pincfg *look_up_pincfg(struct hda_codec *codec,
>   	return NULL;
>   }
>
> -/* write a config value for the given NID */
> -static void set_pincfg(struct hda_codec *codec, hda_nid_t nid,
> -		       unsigned int cfg)
> -{
> -	int i;
> -	for (i = 0; i < 4; i++) {
> -		snd_hda_codec_write(codec, nid, 0,
> -				    AC_VERB_SET_CONFIG_DEFAULT_BYTES_0 + i,
> -				    cfg & 0xff);
> -		cfg >>= 8;
> -	}
> -}
> -
>   /* set the current pin config value for the given NID.
>    * the value is cached, and read via snd_hda_codec_get_pincfg()
>    */
> @@ -1011,12 +998,10 @@ int snd_hda_add_pincfg(struct hda_codec *codec, struct snd_array *list,
>   		       hda_nid_t nid, unsigned int cfg)
>   {
>   	struct hda_pincfg *pin;
> -	unsigned int oldcfg;
>
>   	if (get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_PIN)
>   		return -EINVAL;
>
> -	oldcfg = snd_hda_codec_get_pincfg(codec, nid);
>   	pin = look_up_pincfg(codec, list, nid);
>   	if (!pin) {
>   		pin = snd_array_new(list);
> @@ -1025,13 +1010,6 @@ int snd_hda_add_pincfg(struct hda_codec *codec, struct snd_array *list,
>   		pin->nid = nid;
>   	}
>   	pin->cfg = cfg;
> -
> -	/* change only when needed; e.g. if the pincfg is already present
> -	 * in user_pins[], don't write it
> -	 */
> -	cfg = snd_hda_codec_get_pincfg(codec, nid);
> -	if (oldcfg != cfg)
> -		set_pincfg(codec, nid, cfg);
>   	return 0;
>   }
>
> @@ -1080,17 +1058,6 @@ unsigned int snd_hda_codec_get_pincfg(struct hda_codec *codec, hda_nid_t nid)
>   }
>   EXPORT_SYMBOL_HDA(snd_hda_codec_get_pincfg);
>
> -/* restore all current pin configs */
> -static void restore_pincfgs(struct hda_codec *codec)
> -{
> -	int i;
> -	for (i = 0; i < codec->init_pins.used; i++) {
> -		struct hda_pincfg *pin = snd_array_elem(&codec->init_pins, i);
> -		set_pincfg(codec, pin->nid,
> -			   snd_hda_codec_get_pincfg(codec, pin->nid));
> -	}
> -}
> -
>   /**
>    * snd_hda_shutup_pins - Shut up all pins
>    * @codec: the HDA codec
> @@ -1152,17 +1119,13 @@ static void init_hda_cache(struct hda_cache_rec *cache,
>   			   unsigned int record_size);
>   static void free_hda_cache(struct hda_cache_rec *cache);
>
> -/* restore the initial pin cfgs and release all pincfg lists */
> -static void restore_init_pincfgs(struct hda_codec *codec)
> +/* release all pincfg lists */
> +static void free_init_pincfgs(struct hda_codec *codec)
>   {
> -	/* first free driver_pins and user_pins, then call restore_pincfg
> -	 * so that only the values in init_pins are restored
> -	 */
>   	snd_array_free(&codec->driver_pins);
>   #ifdef CONFIG_SND_HDA_HWDEP
>   	snd_array_free(&codec->user_pins);
>   #endif
> -	restore_pincfgs(codec);
>   	snd_array_free(&codec->init_pins);
>   }
>
> @@ -1205,7 +1168,7 @@ static void snd_hda_codec_free(struct hda_codec *codec)
>   		return;
>   	cancel_delayed_work_sync(&codec->jackpoll_work);
>   	snd_hda_jack_tbl_clear(codec);
> -	restore_init_pincfgs(codec);
> +	free_init_pincfgs(codec);
>   #ifdef CONFIG_PM
>   	cancel_delayed_work(&codec->power_work);
>   	flush_workqueue(codec->bus->workq);
> @@ -2394,7 +2357,6 @@ int snd_hda_codec_reset(struct hda_codec *codec)
>   	init_hda_cache(&codec->cmd_cache, sizeof(struct hda_cache_head));
>   	/* free only driver_pins so that init_pins + user_pins are restored */
>   	snd_array_free(&codec->driver_pins);
> -	restore_pincfgs(codec);
>   	snd_array_free(&codec->cvt_setups);
>   	snd_array_free(&codec->spdif_out);
>   	codec->num_pcms = 0;
> @@ -3687,7 +3649,6 @@ static void hda_call_codec_resume(struct hda_codec *codec)
>   	 */
>   	hda_keep_power_on(codec);
>   	hda_set_power_state(codec, AC_PWRST_D0);
> -	restore_pincfgs(codec); /* restore all current pin configs */
>   	restore_shutup_pins(codec);
>   	hda_exec_init_verbs(codec);
>   	if (codec->patch_ops.resume)
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
