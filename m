From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: Add logic to force HP mixer creation
Date: Mon, 16 Feb 2009 18:34:35 -0500
Message-ID: <4999F80B.9020808@embeddedalley.com>
References: <49983C3D.2000309@embeddedalley.com> <s5hiqnaiwa1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id B4DB524141
	for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2009 00:34:51 +0100 (CET)
In-Reply-To: <s5hiqnaiwa1.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Sun, 15 Feb 2009 11:01:01 -0500,
> Matthew Ranostay wrote:
>> In some instances like a laptop PCI_QUIRK you may want to force a
>> headphone mixer otherwise a "Front" mixer would be in its place, this
>> is to aid user friendlyness.
>>
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
> 
> Well, the change looks a bit too ad hoc.
> Could you give alsa-info.sh output for this?
> 

http://www.alsa-project.org/db/?f=1cd2363ec823c8c2db005acf996608da67ff7a3e

> 
> thanks,
> 
> Takashi
> 
>> ---
>>  sound/pci/hda/patch_sigmatel.c |   25 ++++++++++++++++++-------
>>  1 files changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
>> index aeb5d21..e02a187 100644
>> --- a/sound/pci/hda/patch_sigmatel.c
>> +++ b/sound/pci/hda/patch_sigmatel.c
>> @@ -168,6 +168,7 @@ struct sigmatel_spec {
>>  	unsigned int surr_switch: 1;
>>  	unsigned int alt_switch: 1;
>>  	unsigned int hp_detect: 1;
>> +	unsigned int hp_mixer: 1;
>>  	unsigned int spdif_mute: 1;
>>  	unsigned int check_volume_offset:1;
>>  
>> @@ -857,9 +858,9 @@ static struct hda_verb stac92hd73xx_10ch_core_init[] = {
>>  };
>>  
>>  static struct hda_verb stac92hd83xxx_core_init[] = {
>> -	{ 0xa, AC_VERB_SET_CONNECT_SEL, 0x1},
>> -	{ 0xb, AC_VERB_SET_CONNECT_SEL, 0x1},
>> -	{ 0xd, AC_VERB_SET_CONNECT_SEL, 0x0},
>> +	{ 0xa, AC_VERB_SET_CONNECT_SEL, 0x0},
>> +	{ 0xb, AC_VERB_SET_CONNECT_SEL, 0x0},
>> +	{ 0xd, AC_VERB_SET_CONNECT_SEL, 0x1},
>>  
>>  	/* power state controls amps */
>>  	{ 0x01, AC_VERB_SET_EAPD, 1 << 2},
>> @@ -3115,12 +3116,12 @@ static int stac92xx_auto_create_multi_out_ctls(struct hda_codec *codec,
>>  		"Front", "Surround", NULL /*CLFE*/, "Side"
>>  	};
>>  	hda_nid_t nid = 0;
>> -	int i, err;
>> +	int i, idx = 0, err;
>>  	unsigned int wid_caps;
>>  
>>  	for (i = 0; i < cfg->line_outs && spec->multiout.dac_nids[i]; i++) {
>>  		nid = spec->multiout.dac_nids[i];
>> -		if (i == 2) {
>> +		if (idx == 2) {
>>  			/* Center/LFE */
>>  			err = create_controls(codec, "Center", nid, 1);
>>  			if (err < 0)
>> @@ -3139,9 +3140,9 @@ static int stac92xx_auto_create_multi_out_ctls(struct hda_codec *codec,
>>  				if (err < 0)
>>  					return err;
>>  			}
>> -
>> +			idx++;
>>  		} else {
>> -			const char *name = chname[i];
>> +			const char *name = chname[idx];
>>  			/* if it's a single DAC, assign a better name */
>>  			if (!i && is_unique_dac(spec, nid)) {
>>  				switch (cfg->line_out_type) {
>> @@ -3153,6 +3154,10 @@ static int stac92xx_auto_create_multi_out_ctls(struct hda_codec *codec,
>>  					break;
>>  				}
>>  			}
>> +			if (!i && spec->hp_mixer)
>> +				name = "Headphone";
>> +			else
>> +				idx++;
>>  			err = create_controls(codec, name, nid, 3);
>>  			if (err < 0)
>>  				return err;
>> @@ -4894,6 +4899,12 @@ again:
>>  		break;
>>  	}
>>  
>> +	switch (spec->board_config) {
>> +	case STAC_DELL_S14:
>> +		spec->hp_mixer = 1;
>> +		break;
>> +	}
>> +
>>  	err = stac92xx_parse_auto_config(codec, 0x1d, 0);
>>  	if (!err) {
>>  		if (spec->board_config < 0) {
>> -- 
>> 1.5.6.3
>>
> 
