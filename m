From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: Mic in as output changes
Date: Wed, 30 Jan 2008 08:50:05 -0500
Message-ID: <47A0808D.8020806@embeddedalley.com>
References: <479FAB8E.7090602@embeddedalley.com> <s5hodb3lr7h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp109.biz.mail.mud.yahoo.com (smtp109.biz.mail.mud.yahoo.com
	[68.142.201.178]) by alsa0.perex.cz (Postfix) with SMTP id F3F4824724
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 14:50:07 +0100 (CET)
In-Reply-To: <s5hodb3lr7h.wl%tiwai@suse.de>
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
> At Tue, 29 Jan 2008 17:41:18 -0500,
> Matthew Ranostay wrote:
>> Some laptop has an internal analog microphone that is 'fixed'. This patch prevents creating a 'Mic In as Output' switch for
>> ports that can't be outputs.
>>
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
> 
> This patch causes a compile warning:
> 
>   CC [M]  pci/hda/patch_sigmatel.o
> pci/hda/patch_sigmatel.c:293:
> warning: stac927x_dac_nids defined but not used
> 
> Could you fix this?
> 
> 
> thanks,
> 
> Takashi
> 
>> ---
>> diff -r ec0316a4d108 pci/hda/patch_sigmatel.c
>> --- a/pci/hda/patch_sigmatel.c	Tue Jan 29 15:28:44 2008 +0100
>> +++ b/pci/hda/patch_sigmatel.c	Tue Jan 29 17:33:58 2008 -0500
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
>> @@ -2283,15 +2287,23 @@ static int stac92xx_auto_create_multi_ou
>>  	}
>>  
>>  	if (spec->mic_switch) {
>> +		unsigned int def_conf;
>>  		nid = cfg->input_pins[AUTO_PIN_MIC];
>> -		pincap = snd_hda_param_read(codec, nid,
>> -						AC_PAR_PIN_CAP);
>> -		if (pincap & AC_PINCAP_OUT) {
>> -			err = stac92xx_add_control(spec,
>> -				STAC_CTL_WIDGET_IO_SWITCH,
>> -				"Mic as Output Switch", (nid << 8) | 1);
>> -			if (err < 0)
>> -				return err;
>> +		def_conf = snd_hda_codec_read(codec, nid, 0,
>> +						AC_VERB_GET_CONFIG_DEFAULT, 0);
>> +
>> +		/* some laptops have an internal analog microphone
>> + 		 * which can't be used as a output */
>> +		if (get_defcfg_connect(def_conf) != AC_JACK_PORT_FIXED) {
>> +			pincap = snd_hda_param_read(codec, nid,
>> +							AC_PAR_PIN_CAP);
>> +			if (pincap & AC_PINCAP_OUT) {
>> +				err = stac92xx_add_control(spec,
>> +					STAC_CTL_WIDGET_IO_SWITCH,
>> +					"Mic as Output Switch", (nid << 8) | 1);
>> +				if (err < 0)
>> +					return err;
>> +			}
>>  		}
>>  	}
>>  
>>
> 

Ooops patch of another patch got merged in this.
Here it is cleaned up.

---
diff -r 86c8c0a82bb9 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Jan 30 11:52:33 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Wed Jan 30 08:43:04 2008 -0500
@@ -2283,15 +2283,23 @@ static int stac92xx_auto_create_multi_ou
 	}
 
 	if (spec->mic_switch) {
+		unsigned int def_conf;
 		nid = cfg->input_pins[AUTO_PIN_MIC];
-		pincap = snd_hda_param_read(codec, nid,
-						AC_PAR_PIN_CAP);
-		if (pincap & AC_PINCAP_OUT) {
-			err = stac92xx_add_control(spec,
-				STAC_CTL_WIDGET_IO_SWITCH,
-				"Mic as Output Switch", (nid << 8) | 1);
-			if (err < 0)
-				return err;
+		def_conf = snd_hda_codec_read(codec, nid, 0,
+						AC_VERB_GET_CONFIG_DEFAULT, 0);
+
+		/* some laptops have an internal analog microphone
+ 		 * which can't be used as a output */
+		if (get_defcfg_connect(def_conf) != AC_JACK_PORT_FIXED) {
+			pincap = snd_hda_param_read(codec, nid,
+							AC_PAR_PIN_CAP);
+			if (pincap & AC_PINCAP_OUT) {
+				err = stac92xx_add_control(spec,
+					STAC_CTL_WIDGET_IO_SWITCH,
+					"Mic as Output Switch", (nid << 8) | 1);
+				if (err < 0)
+					return err;
+			}
 		}
 	}
