From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda: Conexant: Allow different
 output types to share DAC
Date: Thu, 25 Aug 2011 15:01:32 +0200
Message-ID: <4E5647AC.807@canonical.com>
References: <4E563162.3080609@canonical.com> <s5hr5497l6b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030805020208050803070801"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 48AF7245B5
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 15:01:36 +0200 (CEST)
In-Reply-To: <s5hr5497l6b.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030805020208050803070801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2011-08-25 14:03, Takashi Iwai wrote:
> At Thu, 25 Aug 2011 13:26:26 +0200,
> David Henningsson wrote:
>>
>> > From 95ca8a0cd32ad781c54a349c5ce84a9119668f9c Mon Sep 17 00:00:00 2001
>> From: David Henningsson<david.henningsson@canonical.com>
>> Date: Thu, 25 Aug 2011 13:16:02 +0200
>> Subject: [PATCH] ALSA: hda: Conexant: Allow different output types to share DAC
>>
>> Headphones has stopped working for the original reported (a regression
>> compared to 2.6.38). This is because Speaker and Headphones share the
>> same DAC, in which case no Headphones volume control was created.
>> This patch fixes so that both Speaker and Headphones volume
>> controls are created in such scenario.
>>
>> Buglink: http://bugs.launchpad.net/bugs/817943
>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>> ---
>>   sound/pci/hda/patch_conexant.c |   40 ++++++++++++++++++++++------------------
>>   1 files changed, 22 insertions(+), 18 deletions(-)
>>
>> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
>> index 197ad93..a29b88d 100644
>> --- a/sound/pci/hda/patch_conexant.c
>> +++ b/sound/pci/hda/patch_conexant.c
>> @@ -3327,22 +3327,23 @@ static int fill_cx_auto_dacs(struct hda_codec *codec, hda_nid_t *dacs)
>>   }
>>
>>   /* fill pin_dac_pair list from the pin and dac list */
>> -static int fill_dacs_for_pins(struct hda_codec *codec, hda_nid_t *pins,
>> +static void fill_dacs_for_pins(struct hda_codec *codec, hda_nid_t *pins,
>>   			      int num_pins, hda_nid_t *dacs, int *rest,
>> -			      struct pin_dac_pair *filled, int type)
>> +			      struct pin_dac_pair *filled, int *saved_nums,
>> +			      int type)
>>   {
>>   	int i, nums;
>>
>> -	nums = 0;
>> +	nums = *saved_nums;
>>   	for (i = 0; i<  num_pins; i++) {
>>   		filled[nums].pin = pins[i];
>>   		filled[nums].type = type;
>>   		filled[nums].dac = get_unassigned_dac(codec, pins[i], dacs, rest);
>> -		if (!filled[nums].dac&&  i>  0&&  filled[0].dac)
>> +		if (!filled[nums].dac&&  filled[0].dac)
>>   			filled[nums].dac = filled[0].dac | DAC_SLAVE_FLAG;
>
> It should try the first DAC of the same type at first, not always
> to filled[0].

Ok, fair point. I'm attaching a revised patch that also checks that the 
DAC is actually reachable, which should be even better.

>> @@ -4155,7 +4159,7 @@ static int cx_auto_build_output_controls(struct hda_codec *codec)
>>   		const char *label;
>>   		int idx, type;
>>   		hda_nid_t dac = spec->dac_info[i].dac;
>> -		if (!dac || (dac&  DAC_SLAVE_FLAG))
>> +		if (!dac)
>>   			continue;
>
> With the fix like the above, the whole NULL-dac check should be
> skipped, too.

Since NULL-dac is essentially an error, this is more a matter of taste IMO.

> How about the revised patch below?

Took some of it into the attached version of the patch.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------030805020208050803070801
Content-Type: text/x-patch;
 name="0001-ALSA-hda-Conexant-Allow-different-output-types-to-sh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-Conexant-Allow-different-output-types-to-sh.pa";
 filename*1="tch"

>From 1947cd5075a43edb1901c3fc9e97ba77d4c7cca9 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 25 Aug 2011 13:16:02 +0200
Subject: [PATCH] ALSA: hda: Conexant: Allow different output types to share DAC

Headphones has stopped working for the original reported (a regression
compared to 2.6.38). This is because Speaker and Headphones share the
same DAC, in which case no Headphones volume control was created.
This patch fixes so that both Speaker and Headphones volume
controls are created in such scenario.

BugLink: http://bugs.launchpad.net/bugs/817943
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |   46 +++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 197ad93..aa0e4b9 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3329,18 +3329,26 @@ static int fill_cx_auto_dacs(struct hda_codec *codec, hda_nid_t *dacs)
 /* fill pin_dac_pair list from the pin and dac list */
 static int fill_dacs_for_pins(struct hda_codec *codec, hda_nid_t *pins,
 			      int num_pins, hda_nid_t *dacs, int *rest,
-			      struct pin_dac_pair *filled, int type)
+			      struct pin_dac_pair *filled, int nums, 
+			      int type)
 {
-	int i, nums;
+	int i, start = nums;
 
-	nums = 0;
-	for (i = 0; i < num_pins; i++) {
+	for (i = 0; i < num_pins; i++, nums++) {
 		filled[nums].pin = pins[i];
 		filled[nums].type = type;
 		filled[nums].dac = get_unassigned_dac(codec, pins[i], dacs, rest);
-		if (!filled[nums].dac && i > 0 && filled[0].dac)
+		if (filled[nums].dac) 
+			continue;
+		if (filled[start].dac && get_connection_index(codec, pins[i], filled[start].dac) >= 0) {
+			filled[nums].dac = filled[start].dac | DAC_SLAVE_FLAG;
+			continue;
+		}
+		if (filled[0].dac && get_connection_index(codec, pins[i], filled[0].dac) >= 0) {
 			filled[nums].dac = filled[0].dac | DAC_SLAVE_FLAG;
-		nums++;
+			continue;
+		}
+		snd_printdd("Failed to find a DAC for pin 0x%x", pins[i]);
 	}
 	return nums;
 }
@@ -3356,14 +3364,14 @@ static void cx_auto_parse_output(struct hda_codec *codec)
 	rest = fill_cx_auto_dacs(codec, dacs);
 	/* parse all analog output pins */
 	nums = fill_dacs_for_pins(codec, cfg->line_out_pins, cfg->line_outs,
-				  dacs, &rest, spec->dac_info,
-				  AUTO_PIN_LINE_OUT);
-	nums += fill_dacs_for_pins(codec, cfg->hp_pins, cfg->hp_outs,
-				  dacs, &rest, spec->dac_info + nums,
-				  AUTO_PIN_HP_OUT);
-	nums += fill_dacs_for_pins(codec, cfg->speaker_pins, cfg->speaker_outs,
-				  dacs, &rest, spec->dac_info + nums,
-				  AUTO_PIN_SPEAKER_OUT);
+			  dacs, &rest, spec->dac_info, 0,
+			  AUTO_PIN_LINE_OUT);
+	nums = fill_dacs_for_pins(codec, cfg->hp_pins, cfg->hp_outs,
+			  dacs, &rest, spec->dac_info, nums,
+			  AUTO_PIN_HP_OUT);
+	nums = fill_dacs_for_pins(codec, cfg->speaker_pins, cfg->speaker_outs,
+			  dacs, &rest, spec->dac_info, nums,
+			  AUTO_PIN_SPEAKER_OUT);
 	spec->dac_info_filled = nums;
 	/* fill multiout struct */
 	for (i = 0; i < nums; i++) {
@@ -4130,9 +4138,11 @@ static int try_add_pb_volume(struct hda_codec *codec, hda_nid_t dac,
 			     hda_nid_t pin, const char *name, int idx)
 {
 	unsigned int caps;
-	caps = query_amp_caps(codec, dac, HDA_OUTPUT);
-	if (caps & AC_AMPCAP_NUM_STEPS)
-		return cx_auto_add_pb_volume(codec, dac, name, idx);
+	if (dac && !(dac & DAC_SLAVE_FLAG)) {
+		caps = query_amp_caps(codec, dac, HDA_OUTPUT);
+		if (caps & AC_AMPCAP_NUM_STEPS)
+			return cx_auto_add_pb_volume(codec, dac, name, idx);
+	}
 	caps = query_amp_caps(codec, pin, HDA_OUTPUT);
 	if (caps & AC_AMPCAP_NUM_STEPS)
 		return cx_auto_add_pb_volume(codec, pin, name, idx);
@@ -4155,8 +4165,6 @@ static int cx_auto_build_output_controls(struct hda_codec *codec)
 		const char *label;
 		int idx, type;
 		hda_nid_t dac = spec->dac_info[i].dac;
-		if (!dac || (dac & DAC_SLAVE_FLAG))
-			continue;
 		type = spec->dac_info[i].type;
 		if (type == AUTO_PIN_LINE_OUT)
 			type = spec->autocfg.line_out_type;
-- 
1.7.4.1


--------------030805020208050803070801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030805020208050803070801--
