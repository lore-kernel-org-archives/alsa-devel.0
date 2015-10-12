From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 5/5] ALSA: firewire-tascam: change device
 probing processing
Date: Mon, 12 Oct 2015 14:42:55 +0200
Message-ID: <20151012144255.2c10e939@kant>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <1444644625-30189-6-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DF652651C7
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 14:42:56 +0200 (CEST)
In-Reply-To: <1444644625-30189-6-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Oct 12 Takashi Sakamoto wrote:
[...]
> Fixes: c0949b278515('ALSA: firewire-tascam: add skeleton for TASCAM FireWire series')

I have some trivial comments, and one off-by-one index error in case
of unexpected Config ROM contents.

[...]
> --- a/sound/firewire/tascam/tascam.c
> +++ b/sound/firewire/tascam/tascam.c
> @@ -24,16 +24,6 @@ static struct snd_tscm_spec model_specs[] = {
>  		.is_controller = true,
>  	},
>  	{
> -		.name = "FW-1804",
> -		.has_adat = true,
> -		.has_spdif = true,
> -		.pcm_capture_analog_channels = 8,
> -		.pcm_playback_analog_channels = 2,
> -		.midi_capture_ports = 2,
> -		.midi_playback_ports = 4,
> -		.is_controller = false,
> -	},
> -	{
>  		.name = "FW-1082",
>  		.has_adat = false,
>  		.has_spdif = true,
> @@ -43,34 +33,46 @@ static struct snd_tscm_spec model_specs[] = {
>  		.midi_playback_ports = 2,
>  		.is_controller = true,
>  	},
> +	/* FW-1804 mey be supported. */

mey -> may  (already fixed in tiwai/sound.git)

>  };
>  
> -static int check_name(struct snd_tscm *tscm)
> +static int identify_model(struct snd_tscm *tscm)
>  {
>  	struct fw_device *fw_dev = fw_parent_device(tscm->unit);
> -	char vendor[8];
> +	const u32 *config_rom = fw_dev->config_rom;
>  	char model[8];
> -	__u32 data;
> -
> -	/* Retrieve model name. */
> -	data = be32_to_cpu(fw_dev->config_rom[28]);
> -	memcpy(model, &data, 4);
> -	data = be32_to_cpu(fw_dev->config_rom[29]);
> -	memcpy(model + 4, &data, 4);
> -	model[7] = '\0';
> -
> -	/* Retrieve vendor name. */
> -	data = be32_to_cpu(fw_dev->config_rom[23]);
> -	memcpy(vendor, &data, 4);
> -	data = be32_to_cpu(fw_dev->config_rom[24]);
> -	memcpy(vendor + 4, &data, 4);
> -	vendor[7] = '\0';
> +	unsigned int i;
> +	u8 c;
> +
> +	if (fw_dev->config_rom_length < 30) {
> +		dev_err(&tscm->unit->device,
> +			"Configuration ROM is too short.\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Pick up model name from certain addresses. */
> +	for (i = 0; i < 8; i++) {
> +		c = config_rom[28 + i / 4] >> (24 - 8 * (i % 4));
> +		if (c == '\0')
> +			break;
> +		model[i] = c;
> +	}
> +	model[i] = '\0';

You could get a buffer overrun here.  Perhaps only go to i < 7:

	for (i = 0; i < 7; i++) {
		[...]
	}
	model[i] = '\0';

> +	for (i = 0; i < ARRAY_SIZE(model_specs); i++) {
> +		if (strcmp(model, model_specs[i].name) == 0) {
> +			tscm->spec = &model_specs[i];
> +			break;
> +		}
> +	}
> +	if (tscm->spec == NULL)
> +		return -ENODEV;
>  
>  	strcpy(tscm->card->driver, "FW-TASCAM");
>  	strcpy(tscm->card->shortname, model);
>  	strcpy(tscm->card->mixername, model);
>  	snprintf(tscm->card->longname, sizeof(tscm->card->longname),
> -		 "%s %s, GUID %08x%08x at %s, S%d", vendor, model,
> +		 "TASCAM %s, GUID %08x%08x at %s, S%d", model,
>  		 cpu_to_be32(fw_dev->config_rom[3]),
>  		 cpu_to_be32(fw_dev->config_rom[4]),
>  		 dev_name(&tscm->unit->device), 100 << fw_dev->max_speed);

Should be
		fw_dev->config_rom[3],
		fw_dev->config_rom[4],

since snprintf wants CPU-endian values.

> @@ -108,13 +110,12 @@ static int snd_tscm_probe(struct fw_unit *unit,
>  	tscm = card->private_data;
>  	tscm->card = card;
>  	tscm->unit = fw_unit_get(unit);
> -	tscm->spec = (const struct snd_tscm_spec *)entry->driver_data;
>  
>  	mutex_init(&tscm->mutex);
>  	spin_lock_init(&tscm->lock);
>  	init_waitqueue_head(&tscm->hwdep_wait);
>  
> -	err = check_name(tscm);
> +	err = identify_model(tscm);
>  	if (err < 0)
>  		goto error;
>  
> @@ -172,27 +173,12 @@ static void snd_tscm_remove(struct fw_unit *unit)
>  }
>  
>  static const struct ieee1394_device_id snd_tscm_id_table[] = {
> -	/* FW-1082 */
> -	{
> -		.match_flags = IEEE1394_MATCH_VENDOR_ID |
> -			       IEEE1394_MATCH_SPECIFIER_ID |
> -			       IEEE1394_MATCH_VERSION,
> -		.vendor_id = 0x00022e,
> -		.specifier_id = 0x00022e,
> -		.version = 0x800003,
> -		.driver_data = (kernel_ulong_t)&model_specs[2],
> -	},
> -	/* FW-1884 */
>  	{
>  		.match_flags = IEEE1394_MATCH_VENDOR_ID |
> -			       IEEE1394_MATCH_SPECIFIER_ID |
> -			       IEEE1394_MATCH_VERSION,
> +			       IEEE1394_MATCH_SPECIFIER_ID,
>  		.vendor_id = 0x00022e,
>  		.specifier_id = 0x00022e,
> -		.version = 0x800000,
> -		.driver_data = (kernel_ulong_t)&model_specs[0],
>  	},
> -	/* FW-1804 mey be supported if IDs are clear. */
>  	/* FE-08 requires reverse-engineering because it just has faders. */
>  	{}
>  };

-- 
Stefan Richter
-=====-===== =-=- -==--
http://arcgraph.de/sr/
