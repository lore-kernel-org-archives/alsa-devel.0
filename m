From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: STAC927x power down inactive DACs
Date: Wed, 30 Jan 2008 17:33:57 -0500
Message-ID: <47A0FB55.2050100@embeddedalley.com>
References: <47A0862A.2070000@embeddedalley.com> <s5htzkv2y61.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp101.biz.mail.mud.yahoo.com (smtp101.biz.mail.mud.yahoo.com
	[68.142.200.236]) by alsa0.perex.cz (Postfix) with SMTP id 06E2F247CB
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 23:34:00 +0100 (CET)
In-Reply-To: <s5htzkv2y61.wl%tiwai@suse.de>
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
> At Wed, 30 Jan 2008 09:14:02 -0500,
> Matthew Ranostay wrote:
>> On several laptops that have STAC9228 codecs have unused DACs, this powers them down to a D3 state.
>>
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
> 
> I think they will be eventually powered up again in
> hda_set_power_state() in hda_codec.c.  As a temporary solution, we can
> have a sort of blacklist in struct hda_codec for always turning the
> power off for such widgets.
> 
> As a long-term solution, the automatic detection of such widgets would
> be nice...
> 
> 
> Takashi
> 
> 
>> ---
>> diff -r 86c8c0a82bb9 pci/hda/patch_sigmatel.c
>> --- a/pci/hda/patch_sigmatel.c	Wed Jan 30 11:52:33 2008 +0100
>> +++ b/pci/hda/patch_sigmatel.c	Wed Jan 30 08:58:37 2008 -0500
>> @@ -288,6 +288,10 @@ static hda_nid_t stac927x_adc_nids[3] = 
>>  
>>  static hda_nid_t stac927x_mux_nids[3] = {
>>          0x15, 0x16, 0x17
>> +};
>> +
>> +static hda_nid_t stac927x_dac_nids[5] = {
>> +	0x02, 0x03, 0x04, 0x05, 0x06
>>  };
>>  
>>  static hda_nid_t stac927x_dmux_nids[1] = {
>> @@ -3537,7 +3541,7 @@ static int patch_stac927x(struct hda_cod
>>  static int patch_stac927x(struct hda_codec *codec)
>>  {
>>  	struct sigmatel_spec *spec;
>> -	int err;
>> +	int err, i;
>>  
>>  	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
>>  	if (spec == NULL)
>> @@ -3628,6 +3632,14 @@ static int patch_stac927x(struct hda_cod
>>  		stac92xx_free(codec);
>>  		return err;
>>  	}
>> +
>> +	/* on some 3-stack systems not all the DACs are used
>> + 	 * this powers down ones that aren't used
>> + 	 */
>> +	for (i = 0; i < ARRAY_SIZE(stac927x_dac_nids); i++)
>> +		if (!is_in_dac_nids(spec, stac927x_dac_nids[i]))
>> +			snd_hda_codec_write_cache(codec, stac927x_dac_nids[i],
>> +				0, AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
>>  
>>  	codec->patch_ops = stac92xx_patch_ops;
>>
> 

I think this what you had in mind.
Also is putting the function call in stac92xx_resume correct?


diff -r 86c8c0a82bb9 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Jan 30 11:52:33 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Wed Jan 30 16:52:00 2008 -0500
@@ -135,6 +135,7 @@ struct sigmatel_spec {
 	/* power management */
 	unsigned int num_pwrs;
 	hda_nid_t *pwr_nids;
+	hda_nid_t *dac_list;
 
 	/* playback */
 	struct hda_input_mux *mono_mux;
@@ -288,6 +289,10 @@ static hda_nid_t stac927x_adc_nids[3] = 
 
 static hda_nid_t stac927x_mux_nids[3] = {
         0x15, 0x16, 0x17
+};
+
+static hda_nid_t stac927x_dac_nids[6] = {
+	0x02, 0x03, 0x04, 0x05, 0x06, 0
 };
 
 static hda_nid_t stac927x_dmux_nids[1] = {
@@ -2858,6 +2863,18 @@ static int is_nid_hp_pin(struct auto_pin
 	return 0; /* nid is not a HP-Out */
 };
 
+static void stac92xx_power_down(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	/* power down inactive DACs */
+	hda_nid_t *dac;
+	for (dac = spec->dac_list; *dac; dac++)
+		if (!is_in_dac_nids(spec, *dac))
+			snd_hda_codec_write_cache(codec, *dac, 0,
+					AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+}
+
 static int stac92xx_init(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
@@ -2910,7 +2927,8 @@ static int stac92xx_init(struct hda_code
 		enable_pin_detect(codec, spec->pwr_nids[i], event | i);
 		codec->patch_ops.unsol_event(codec, (event | i) << 26);
 	}
-
+	if (spec->dac_list)
+		stac92xx_power_down(codec);
 	if (cfg->dig_out_pin)
 		stac92xx_auto_set_pinctl(codec, cfg->dig_out_pin,
 					 AC_PINCTL_OUT_EN);
@@ -3083,6 +3101,9 @@ static int stac92xx_resume(struct hda_co
 		spec->gpio_dir, spec->gpio_data);
 	snd_hda_codec_resume_amp(codec);
 	snd_hda_codec_resume_cache(codec);
+	/* power down inactive DACs */
+	if (spec->dac_list)
+		stac92xx_power_down(codec);
 	/* invoke unsolicited event to reset the HP state */
 	if (spec->hp_detect)
 		codec->patch_ops.unsol_event(codec, STAC_HP_EVENT << 26);
@@ -3569,6 +3590,7 @@ static int patch_stac927x(struct hda_cod
 	spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
 	spec->mux_nids = stac927x_mux_nids;
 	spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
+	spec->dac_list = stac927x_dac_nids;
 	spec->multiout.dac_nids = spec->dac_nids;
 
 	switch (spec->board_config) {
