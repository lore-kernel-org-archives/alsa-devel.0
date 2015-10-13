From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 5/5] ALSA: firewire-tascam: change device
 probing processing
Date: Tue, 13 Oct 2015 23:12:55 +0900
Message-ID: <561D1167.3030305@sakamocchi.jp>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <1444644625-30189-6-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144255.2c10e939@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 059CD261AA3
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 16:12:57 +0200 (CEST)
In-Reply-To: <20151012144255.2c10e939@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Oct 12 2015 21:42, Stefan Richter wrote:
>> -static int check_name(struct snd_tscm *tscm)
>> +static int identify_model(struct snd_tscm *tscm)
>>  {
>>  	struct fw_device *fw_dev = fw_parent_device(tscm->unit);
>> -	char vendor[8];
>> +	const u32 *config_rom = fw_dev->config_rom;
>>  	char model[8];
>> -	__u32 data;
>> -
>> -	/* Retrieve model name. */
>> -	data = be32_to_cpu(fw_dev->config_rom[28]);
>> -	memcpy(model, &data, 4);
>> -	data = be32_to_cpu(fw_dev->config_rom[29]);
>> -	memcpy(model + 4, &data, 4);
>> -	model[7] = '\0';
>> -
>> -	/* Retrieve vendor name. */
>> -	data = be32_to_cpu(fw_dev->config_rom[23]);
>> -	memcpy(vendor, &data, 4);
>> -	data = be32_to_cpu(fw_dev->config_rom[24]);
>> -	memcpy(vendor + 4, &data, 4);
>> -	vendor[7] = '\0';
>> +	unsigned int i;
>> +	u8 c;
>> +
>> +	if (fw_dev->config_rom_length < 30) {
>> +		dev_err(&tscm->unit->device,
>> +			"Configuration ROM is too short.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Pick up model name from certain addresses. */
>> +	for (i = 0; i < 8; i++) {
>> +		c = config_rom[28 + i / 4] >> (24 - 8 * (i % 4));
>> +		if (c == '\0')
>> +			break;
>> +		model[i] = c;
>> +	}
>> +	model[i] = '\0';
> 
> You could get a buffer overrun here.  Perhaps only go to i < 7:

Indeed, thanks.

> 	for (i = 0; i < 7; i++) {
> 		[...]
> 	}
> 	model[i] = '\0';
> 
>> +	for (i = 0; i < ARRAY_SIZE(model_specs); i++) {
>> +		if (strcmp(model, model_specs[i].name) == 0) {
>> +			tscm->spec = &model_specs[i];
>> +			break;
>> +		}
>> +	}
>> +	if (tscm->spec == NULL)
>> +		return -ENODEV;
>>  
>>  	strcpy(tscm->card->driver, "FW-TASCAM");
>>  	strcpy(tscm->card->shortname, model);
>>  	strcpy(tscm->card->mixername, model);
>>  	snprintf(tscm->card->longname, sizeof(tscm->card->longname),
>> -		 "%s %s, GUID %08x%08x at %s, S%d", vendor, model,
>> +		 "TASCAM %s, GUID %08x%08x at %s, S%d", model,
>>  		 cpu_to_be32(fw_dev->config_rom[3]),
>>  		 cpu_to_be32(fw_dev->config_rom[4]),
>>  		 dev_name(&tscm->unit->device), 100 << fw_dev->max_speed);
> 
> Should be
> 		fw_dev->config_rom[3],
> 		fw_dev->config_rom[4],
> 
> since snprintf wants CPU-endian values.

Firewire-digi00x also includes the same bug.

I found some endianness bug in the other modules. I'll fixed these bugs
in the same series of patches later.


Thanks

Takashi Sakamoto
