From: Thomas Schneider <nailstudio@gmx.net>
Subject: Re: S/PDIF-Out on Asus M3A-H/HDMI with ALC1200]
Date: Sat, 03 Jan 2009 23:44:09 +0100
Message-ID: <495FEA39.1000404@gmx.net>
References: <49538A00.3070009@gmx.net>
	<20081226024838.GA13302@localhost>	<4954CE2A.2040309@gmx.net>
	<20081230095414.GA1206@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 995F52436B
	for <alsa-devel@alsa-project.org>; Sat,  3 Jan 2009 23:44:10 +0100 (CET)
In-Reply-To: <20081230095414.GA1206@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

yes the new patch fix the oops. And now i have sound on both
connections at the same time !!!

Many Thanks



Am 30.12.2008 10:54, schrieb Wu Fengguang:
> On Fri, Dec 26, 2008 at 01:29:30PM +0100, Thomas Schneider wrote:
>    
>> Hi,
>>
>> sorry, i get a kernel oops with this changes when i activate iec958 in
>> the mixer !
>>
>>
>> [ 1435.041914] BUG: unable to handle kernel NULL pointer dereference at
>> 0000000000000006
>> [ 1435.041914] IP: [<ffffffff880d0223>] :snd_hda_codec:set_dig_out+0x47/0x57
>> [ 1435.041914] PGD 6b5c3067 PUD 781ba067 PMD 0
>> [ 1435.041914] Oops: 0000 [1] SMP
>>      
>
> Sorry, does this new patch fixed the oops?
>
> Thanks,
> Fengguang
> ---
>   sound/pci/hda/hda_local.h     |    1 +
>   sound/pci/hda/patch_realtek.c |    9 ++++++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> --- sound-2.6.orig/sound/pci/hda/hda_local.h
> +++ sound-2.6/sound/pci/hda/hda_local.h
> @@ -227,6 +227,7 @@ struct hda_multi_out {
>   	hda_nid_t hp_nid;	/* optional DAC for HP, 0 when not exists */
>   	hda_nid_t extra_out_nid[3];	/* optional DACs, 0 when not exists */
>   	hda_nid_t dig_out_nid;	/* digital out audio widget */
> +	hda_nid_t *slave_dig_outs;
>   	int max_channels;	/* currently supported analog channels */
>   	int dig_out_used;	/* current usage of digital out (HDA_DIG_XXX) */
>   	int no_share_stream;	/* don't share a stream with multiple pins */
> --- sound-2.6.orig/sound/pci/hda/patch_realtek.c
> +++ sound-2.6/sound/pci/hda/patch_realtek.c
> @@ -336,6 +336,7 @@ struct alc_config_preset {
>   	hda_nid_t *dac_nids;
>   	hda_nid_t dig_out_nid;		/* optional */
>   	hda_nid_t hp_nid;		/* optional */
> +	hda_nid_t *slave_dig_outs;
>   	unsigned int num_adc_nids;
>   	hda_nid_t *adc_nids;
>   	hda_nid_t *capsrc_nids;
> @@ -810,6 +811,7 @@ static void setup_preset(struct alc_spec
>   	spec->multiout.num_dacs = preset->num_dacs;
>   	spec->multiout.dac_nids = preset->dac_nids;
>   	spec->multiout.dig_out_nid = preset->dig_out_nid;
> +	spec->multiout.slave_dig_outs = preset->slave_dig_outs;
>   	spec->multiout.hp_nid = preset->hp_nid;
>
>   	spec->num_mux_defs = preset->num_mux_defs;
> @@ -3085,6 +3087,7 @@ static int alc_build_pcms(struct hda_cod
>   	/* SPDIF for stream index #1 */
>   	if (spec->multiout.dig_out_nid || spec->dig_in_nid) {
>   		codec->num_pcms = 2;
> +	        codec->slave_dig_outs = spec->multiout.slave_dig_outs;
>   		info = spec->pcm_rec + 1;
>   		info->name = spec->stream_name_digital;
>   		info->pcm_type = HDA_PCM_TYPE_SPDIF;
> @@ -8525,6 +8528,10 @@ static struct snd_pci_quirk alc883_cfg_t
>   	{}
>   };
>
> +static hda_nid_t alc1200_slave_dig_outs[] = {
> +	ALC883_DIGOUT_NID, 0,
> +};
> +
>   static struct alc_config_preset alc883_presets[] = {
>   	[ALC883_3ST_2ch_DIG] = {
>   		.mixers = { alc883_3ST_2ch_mixer },
> @@ -8865,13 +8872,13 @@ static struct alc_config_preset alc883_p
>   		.dac_nids = alc883_dac_nids,
>   		.dig_out_nid = ALC1200_DIGOUT_NID,
>   		.dig_in_nid = ALC883_DIGIN_NID,
> +		.slave_dig_outs = alc1200_slave_dig_outs,
>   		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
>   		.channel_mode = alc883_sixstack_modes,
>   		.input_mux =&alc883_capture_source,
>   	},
>   };
>
> -
>   /*
>    * BIOS auto configuration
>    */
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>    
