From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v3 3/5] ALSA: hda - hdmi: Refactor hdmi_eld
	into parsed_hdmi_eld
Date: Tue, 19 Feb 2013 12:43:46 +0100
Message-ID: <51236572.6030905@canonical.com>
References: <1361271074-17555-1-git-send-email-david.henningsson@canonical.com>
 <1361271074-17555-4-git-send-email-david.henningsson@canonical.com>
 <s5hobfgef4s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030401030405080800050509"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D6E92651DC
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 12:43:41 +0100 (CET)
In-Reply-To: <s5hobfgef4s.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, fengguang.wu@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030401030405080800050509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/19/2013 12:07 PM, Takashi Iwai wrote:
> At Tue, 19 Feb 2013 11:51:12 +0100,
> David Henningsson wrote:
>>
>> For better readability, the information that is parsed out of the
>> ELD data is now put into a separate parsed_hdmi_eld struct.
>>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> You seem to have forgotten to change memset() call in
> hdmi_present_sense().

Ok, will fix.

> One thing I feel a bit uneasy is that the whole struct hdmi_eld is
> passed in the next patch as spec->temp_eld.  It contains uninitialized
> proc entry and mutex.
>
> If we split the data and the control objects, can we pass only the
> data struct to snd_hdmi_get_eld() instead of passing the whole struct
> hdmi_eld?  If so, the question is where should fields like
> monitor_present, etc, belong to.

What do you think of the attached version of patch 3/5? If you like it 
I'll continue with fixing up 4/5 and 5/5 to match.

>
>
> thanks,
>
> Takashi
>
>> ---
>>   sound/pci/hda/hda_eld.c    |   41 ++++++++++++++++++++++-------------------
>>   sound/pci/hda/hda_local.h  |   22 +++++++++++++---------
>>   sound/pci/hda/patch_hdmi.c |   12 ++++++------
>>   3 files changed, 41 insertions(+), 34 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
>> index 4c054f4..aecda72 100644
>> --- a/sound/pci/hda/hda_eld.c
>> +++ b/sound/pci/hda/hda_eld.c
>> @@ -246,8 +246,8 @@ static void hdmi_update_short_audio_desc(struct cea_sad *a,
>>   /*
>>    * Be careful, ELD buf could be totally rubbish!
>>    */
>> -static int hdmi_update_eld(struct hdmi_eld *e,
>> -			   const unsigned char *buf, int size)
>> +static int hdmi_parse_eld(struct parsed_hdmi_eld *e,
>> +			  const unsigned char *buf, int size)
>>   {
>>   	int mnl;
>>   	int i;
>> @@ -260,7 +260,6 @@ static int hdmi_update_eld(struct hdmi_eld *e,
>>   		goto out_fail;
>>   	}
>>
>> -	e->eld_size = size;
>>   	e->baseline_len = GRAB_BITS(buf, 2, 0, 8);
>>   	mnl		= GRAB_BITS(buf, 4, 0, 5);
>>   	e->cea_edid_ver	= GRAB_BITS(buf, 4, 5, 3);
>> @@ -305,7 +304,6 @@ static int hdmi_update_eld(struct hdmi_eld *e,
>>   	if (!e->spk_alloc)
>>   		e->spk_alloc = 0xffff;
>>
>> -	e->eld_valid = true;
>>   	return 0;
>>
>>   out_fail:
>> @@ -328,7 +326,7 @@ int snd_hdmi_get_eld(struct hdmi_eld *eld,
>>
>>   	/*
>>   	 * ELD size is initialized to zero in caller function. If no errors and
>> -	 * ELD is valid, actual eld_size is assigned in hdmi_update_eld()
>> +	 * ELD is valid, actual eld_size is assigned.
>>   	 */
>>
>>   	size = snd_hdmi_get_eld_size(codec, nid);
>> @@ -372,8 +370,11 @@ int snd_hdmi_get_eld(struct hdmi_eld *eld,
>>   		buf[i] = val;
>>   	}
>>
>> -	ret = hdmi_update_eld(eld, buf, size);
>> +	if ((ret = hdmi_parse_eld(&eld->info, buf, size)) < 0)
>> +		goto error;
>>
>> +	eld->eld_size = size;
>> +	eld->eld_valid = true;
>>   error:
>>   	return ret;
>>   }
>> @@ -438,7 +439,7 @@ void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen)
>>   	buf[j] = '\0';	/* necessary when j == 0 */
>>   }
>>
>> -void snd_hdmi_show_eld(struct hdmi_eld *e)
>> +void snd_hdmi_show_eld(struct parsed_hdmi_eld *e)
>>   {
>>   	int i;
>>
>> @@ -487,10 +488,11 @@ static void hdmi_print_sad_info(int i, struct cea_sad *a,
>>   static void hdmi_print_eld_info(struct snd_info_entry *entry,
>>   				struct snd_info_buffer *buffer)
>>   {
>> -	struct hdmi_eld *e = entry->private_data;
>> +	struct hdmi_eld *eld = entry->private_data;
>> +	struct parsed_hdmi_eld *e = &eld->info;
>>   	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
>>   	int i;
>> -	static char *eld_versoin_names[32] = {
>> +	static char *eld_version_names[32] = {
>>   		"reserved",
>>   		"reserved",
>>   		"CEA-861D or below",
>> @@ -505,15 +507,15 @@ static void hdmi_print_eld_info(struct snd_info_entry *entry,
>>   		[4 ... 7] = "reserved"
>>   	};
>>
>> -	snd_iprintf(buffer, "monitor_present\t\t%d\n", e->monitor_present);
>> -	snd_iprintf(buffer, "eld_valid\t\t%d\n", e->eld_valid);
>> -	if (!e->eld_valid)
>> +	snd_iprintf(buffer, "monitor_present\t\t%d\n", eld->monitor_present);
>> +	snd_iprintf(buffer, "eld_valid\t\t%d\n", eld->eld_valid);
>> +	if (!eld->eld_valid)
>>   		return;
>>   	snd_iprintf(buffer, "monitor_name\t\t%s\n", e->monitor_name);
>>   	snd_iprintf(buffer, "connection_type\t\t%s\n",
>>   				eld_connection_type_names[e->conn_type]);
>>   	snd_iprintf(buffer, "eld_version\t\t[0x%x] %s\n", e->eld_ver,
>> -					eld_versoin_names[e->eld_ver]);
>> +					eld_version_names[e->eld_ver]);
>>   	snd_iprintf(buffer, "edid_version\t\t[0x%x] %s\n", e->cea_edid_ver,
>>   				cea_edid_version_names[e->cea_edid_ver]);
>>   	snd_iprintf(buffer, "manufacture_id\t\t0x%x\n", e->manufacture_id);
>> @@ -535,7 +537,8 @@ static void hdmi_print_eld_info(struct snd_info_entry *entry,
>>   static void hdmi_write_eld_info(struct snd_info_entry *entry,
>>   				struct snd_info_buffer *buffer)
>>   {
>> -	struct hdmi_eld *e = entry->private_data;
>> +	struct hdmi_eld *eld = entry->private_data;
>> +	struct parsed_hdmi_eld *e = &eld->info;
>>   	char line[64];
>>   	char name[64];
>>   	char *sname;
>> @@ -551,9 +554,9 @@ static void hdmi_write_eld_info(struct snd_info_entry *entry,
>>   		 * 	eld_version edid_version
>>   		 */
>>   		if (!strcmp(name, "monitor_present"))
>> -			e->monitor_present = val;
>> +			eld->monitor_present = val;
>>   		else if (!strcmp(name, "eld_valid"))
>> -			e->eld_valid = val;
>> +			eld->eld_valid = val;
>>   		else if (!strcmp(name, "connection_type"))
>>   			e->conn_type = val;
>>   		else if (!strcmp(name, "port_id"))
>> @@ -627,7 +630,7 @@ void snd_hda_eld_proc_free(struct hda_codec *codec, struct hdmi_eld *eld)
>>   #endif /* CONFIG_PROC_FS */
>>
>>   /* update PCM info based on ELD */
>> -void snd_hdmi_eld_update_pcm_info(struct hdmi_eld *eld,
>> +void snd_hdmi_eld_update_pcm_info(struct parsed_hdmi_eld *e,
>>   			      struct hda_pcm_stream *hinfo)
>>   {
>>   	u32 rates;
>> @@ -644,8 +647,8 @@ void snd_hdmi_eld_update_pcm_info(struct hdmi_eld *eld,
>>   	formats = SNDRV_PCM_FMTBIT_S16_LE;
>>   	maxbps = 16;
>>   	channels_max = 2;
>> -	for (i = 0; i < eld->sad_count; i++) {
>> -		struct cea_sad *a = &eld->sad[i];
>> +	for (i = 0; i < e->sad_count; i++) {
>> +		struct cea_sad *a = &e->sad[i];
>>   		rates |= a->rates;
>>   		if (a->channels > channels_max)
>>   			channels_max = a->channels;
>> diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
>> index 05f1d59..11fd5f5 100644
>> --- a/sound/pci/hda/hda_local.h
>> +++ b/sound/pci/hda/hda_local.h
>> @@ -713,10 +713,10 @@ struct cea_sad {
>>   /*
>>    * ELD: EDID Like Data
>>    */
>> -struct hdmi_eld {
>> -	bool	monitor_present;
>> -	bool	eld_valid;
>> -	int	eld_size;
>> +struct parsed_hdmi_eld {
>> +	/*
>> +	 * all fields will be cleared before updating ELD
>> +	 */
>>   	int	baseline_len;
>>   	int	eld_ver;
>>   	int	cea_edid_ver;
>> @@ -731,10 +731,14 @@ struct hdmi_eld {
>>   	int	spk_alloc;
>>   	int	sad_count;
>>   	struct cea_sad sad[ELD_MAX_SAD];
>> -	/*
>> -	 * all fields above eld_buffer will be cleared before updating ELD
>> -	 */
>> +};
>> +
>> +struct hdmi_eld {
>> +	bool	monitor_present;
>> +	bool	eld_valid;
>> +	int	eld_size;
>>   	char    eld_buffer[ELD_MAX_SIZE];
>> +	struct parsed_hdmi_eld info;
>>   #ifdef CONFIG_PROC_FS
>>   	struct snd_info_entry *proc_entry;
>>   #endif
>> @@ -742,8 +746,8 @@ struct hdmi_eld {
>>
>>   int snd_hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid);
>>   int snd_hdmi_get_eld(struct hdmi_eld *, struct hda_codec *, hda_nid_t);
>> -void snd_hdmi_show_eld(struct hdmi_eld *eld);
>> -void snd_hdmi_eld_update_pcm_info(struct hdmi_eld *eld,
>> +void snd_hdmi_show_eld(struct parsed_hdmi_eld *e);
>> +void snd_hdmi_eld_update_pcm_info(struct parsed_hdmi_eld *e,
>>   			      struct hda_pcm_stream *hinfo);
>>
>>   #ifdef CONFIG_PROC_FS
>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>> index 7a73dfb..2ac6635 100644
>> --- a/sound/pci/hda/patch_hdmi.c
>> +++ b/sound/pci/hda/patch_hdmi.c
>> @@ -529,7 +529,7 @@ static int hdmi_channel_allocation(struct hdmi_eld *eld, int channels)
>>   	 * expand ELD's notions to match the ones used by Audio InfoFrame.
>>   	 */
>>   	for (i = 0; i < ARRAY_SIZE(eld_speaker_allocation_bits); i++) {
>> -		if (eld->spk_alloc & (1 << i))
>> +		if (eld->info.spk_alloc & (1 << i))
>>   			spk_mask |= eld_speaker_allocation_bits[i];
>>   	}
>>
>> @@ -543,7 +543,7 @@ static int hdmi_channel_allocation(struct hdmi_eld *eld, int channels)
>>   		}
>>   	}
>>
>> -	snd_print_channel_allocation(eld->spk_alloc, buf, sizeof(buf));
>> +	snd_print_channel_allocation(eld->info.spk_alloc, buf, sizeof(buf));
>>   	snd_printdd("HDMI: select CA 0x%x for %d-channel allocation: %s\n",
>>   		    ca, channels, buf);
>>
>> @@ -884,7 +884,7 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec, int pin_idx,
>>   		ca = 0;
>>
>>   	memset(&ai, 0, sizeof(ai));
>> -	if (eld->conn_type == 0) { /* HDMI */
>> +	if (eld->info.conn_type == 0) { /* HDMI */
>>   		struct hdmi_audio_infoframe *hdmi_ai = &ai.hdmi;
>>
>>   		hdmi_ai->type		= 0x84;
>> @@ -893,7 +893,7 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec, int pin_idx,
>>   		hdmi_ai->CC02_CT47	= channels - 1;
>>   		hdmi_ai->CA		= ca;
>>   		hdmi_checksum_audio_infoframe(hdmi_ai);
>> -	} else if (eld->conn_type == 1) { /* DisplayPort */
>> +	} else if (eld->info.conn_type == 1) { /* DisplayPort */
>>   		struct dp_audio_infoframe *dp_ai = &ai.dp;
>>
>>   		dp_ai->type		= 0x84;
>> @@ -1114,7 +1114,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
>>
>>   	/* Restrict capabilities by ELD if this isn't disabled */
>>   	if (!static_hdmi_pcm && eld->eld_valid) {
>> -		snd_hdmi_eld_update_pcm_info(eld, hinfo);
>> +		snd_hdmi_eld_update_pcm_info(&eld->info, hinfo);
>>   		if (hinfo->channels_min > hinfo->channels_max ||
>>   		    !hinfo->rates || !hinfo->formats) {
>>   			per_cvt->assigned = 0;
>> @@ -1188,7 +1188,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>>   	eld->eld_valid = false;
>>   	if (eld_valid) {
>>   		if (!snd_hdmi_get_eld(eld, codec, pin_nid))
>> -			snd_hdmi_show_eld(eld);
>> +			snd_hdmi_show_eld(&eld->info);
>>   		else if (repoll) {
>>   			queue_delayed_work(codec->bus->workq,
>>   					   &per_pin->work,
>> --
>> 1.7.9.5
>>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------030401030405080800050509
Content-Type: text/x-patch;
 name="0001-ALSA-hda-hdmi-Refactor-hdmi_eld-into-parsed_hdmi_eld.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-hdmi-Refactor-hdmi_eld-into-parsed_hdmi_eld.pa";
 filename*1="tch"

>From 80aca324ff81f630006aeb18f22b78f46428bad3 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 19 Feb 2013 10:59:34 +0100
Subject: [PATCH] ALSA: hda - hdmi: Refactor hdmi_eld into parsed_hdmi_eld

For better readability, the information that is parsed out of the
ELD data is now put into a separate parsed_hdmi_eld struct.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_eld.c    |   46 ++++++++++++++++++++------------------------
 sound/pci/hda/hda_local.h  |   27 ++++++++++++++++----------
 sound/pci/hda/patch_hdmi.c |   24 +++++++++++++++--------
 3 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 4c054f4..16066d7 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -246,8 +246,8 @@ static void hdmi_update_short_audio_desc(struct cea_sad *a,
 /*
  * Be careful, ELD buf could be totally rubbish!
  */
-static int hdmi_update_eld(struct hdmi_eld *e,
-			   const unsigned char *buf, int size)
+int snd_hdmi_parse_eld(struct parsed_hdmi_eld *e,
+			  const unsigned char *buf, int size)
 {
 	int mnl;
 	int i;
@@ -260,7 +260,6 @@ static int hdmi_update_eld(struct hdmi_eld *e,
 		goto out_fail;
 	}
 
-	e->eld_size = size;
 	e->baseline_len = GRAB_BITS(buf, 2, 0, 8);
 	mnl		= GRAB_BITS(buf, 4, 0, 5);
 	e->cea_edid_ver	= GRAB_BITS(buf, 4, 5, 3);
@@ -305,7 +304,6 @@ static int hdmi_update_eld(struct hdmi_eld *e,
 	if (!e->spk_alloc)
 		e->spk_alloc = 0xffff;
 
-	e->eld_valid = true;
 	return 0;
 
 out_fail:
@@ -318,17 +316,16 @@ int snd_hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid)
 						 AC_DIPSIZE_ELD_BUF);
 }
 
-int snd_hdmi_get_eld(struct hdmi_eld *eld,
-		     struct hda_codec *codec, hda_nid_t nid)
+int snd_hdmi_get_eld(struct hda_codec *codec, hda_nid_t nid,
+		     unsigned char *buf, int *eld_size)
 {
 	int i;
 	int ret;
 	int size;
-	unsigned char *buf;
 
 	/*
 	 * ELD size is initialized to zero in caller function. If no errors and
-	 * ELD is valid, actual eld_size is assigned in hdmi_update_eld()
+	 * ELD is valid, actual eld_size is assigned.
 	 */
 
 	size = snd_hdmi_get_eld_size(codec, nid);
@@ -343,8 +340,6 @@ int snd_hdmi_get_eld(struct hdmi_eld *eld,
 	}
 
 	/* set ELD buffer */
-	buf = eld->eld_buffer;
-
 	for (i = 0; i < size; i++) {
 		unsigned int val = hdmi_get_eld_data(codec, nid, i);
 		/*
@@ -372,8 +367,7 @@ int snd_hdmi_get_eld(struct hdmi_eld *eld,
 		buf[i] = val;
 	}
 
-	ret = hdmi_update_eld(eld, buf, size);
-
+	*eld_size = size;
 error:
 	return ret;
 }
@@ -438,7 +432,7 @@ void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen)
 	buf[j] = '\0';	/* necessary when j == 0 */
 }
 
-void snd_hdmi_show_eld(struct hdmi_eld *e)
+void snd_hdmi_show_eld(struct parsed_hdmi_eld *e)
 {
 	int i;
 
@@ -487,10 +481,11 @@ static void hdmi_print_sad_info(int i, struct cea_sad *a,
 static void hdmi_print_eld_info(struct snd_info_entry *entry,
 				struct snd_info_buffer *buffer)
 {
-	struct hdmi_eld *e = entry->private_data;
+	struct hdmi_eld *eld = entry->private_data;
+	struct parsed_hdmi_eld *e = &eld->info;
 	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
 	int i;
-	static char *eld_versoin_names[32] = {
+	static char *eld_version_names[32] = {
 		"reserved",
 		"reserved",
 		"CEA-861D or below",
@@ -505,15 +500,15 @@ static void hdmi_print_eld_info(struct snd_info_entry *entry,
 		[4 ... 7] = "reserved"
 	};
 
-	snd_iprintf(buffer, "monitor_present\t\t%d\n", e->monitor_present);
-	snd_iprintf(buffer, "eld_valid\t\t%d\n", e->eld_valid);
-	if (!e->eld_valid)
+	snd_iprintf(buffer, "monitor_present\t\t%d\n", eld->monitor_present);
+	snd_iprintf(buffer, "eld_valid\t\t%d\n", eld->eld_valid);
+	if (!eld->eld_valid)
 		return;
 	snd_iprintf(buffer, "monitor_name\t\t%s\n", e->monitor_name);
 	snd_iprintf(buffer, "connection_type\t\t%s\n",
 				eld_connection_type_names[e->conn_type]);
 	snd_iprintf(buffer, "eld_version\t\t[0x%x] %s\n", e->eld_ver,
-					eld_versoin_names[e->eld_ver]);
+					eld_version_names[e->eld_ver]);
 	snd_iprintf(buffer, "edid_version\t\t[0x%x] %s\n", e->cea_edid_ver,
 				cea_edid_version_names[e->cea_edid_ver]);
 	snd_iprintf(buffer, "manufacture_id\t\t0x%x\n", e->manufacture_id);
@@ -535,7 +530,8 @@ static void hdmi_print_eld_info(struct snd_info_entry *entry,
 static void hdmi_write_eld_info(struct snd_info_entry *entry,
 				struct snd_info_buffer *buffer)
 {
-	struct hdmi_eld *e = entry->private_data;
+	struct hdmi_eld *eld = entry->private_data;
+	struct parsed_hdmi_eld *e = &eld->info;
 	char line[64];
 	char name[64];
 	char *sname;
@@ -551,9 +547,9 @@ static void hdmi_write_eld_info(struct snd_info_entry *entry,
 		 * 	eld_version edid_version
 		 */
 		if (!strcmp(name, "monitor_present"))
-			e->monitor_present = val;
+			eld->monitor_present = val;
 		else if (!strcmp(name, "eld_valid"))
-			e->eld_valid = val;
+			eld->eld_valid = val;
 		else if (!strcmp(name, "connection_type"))
 			e->conn_type = val;
 		else if (!strcmp(name, "port_id"))
@@ -627,7 +623,7 @@ void snd_hda_eld_proc_free(struct hda_codec *codec, struct hdmi_eld *eld)
 #endif /* CONFIG_PROC_FS */
 
 /* update PCM info based on ELD */
-void snd_hdmi_eld_update_pcm_info(struct hdmi_eld *eld,
+void snd_hdmi_eld_update_pcm_info(struct parsed_hdmi_eld *e,
 			      struct hda_pcm_stream *hinfo)
 {
 	u32 rates;
@@ -644,8 +640,8 @@ void snd_hdmi_eld_update_pcm_info(struct hdmi_eld *eld,
 	formats = SNDRV_PCM_FMTBIT_S16_LE;
 	maxbps = 16;
 	channels_max = 2;
-	for (i = 0; i < eld->sad_count; i++) {
-		struct cea_sad *a = &eld->sad[i];
+	for (i = 0; i < e->sad_count; i++) {
+		struct cea_sad *a = &e->sad[i];
 		rates |= a->rates;
 		if (a->channels > channels_max)
 			channels_max = a->channels;
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 05f1d59..363cd48 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -713,10 +713,10 @@ struct cea_sad {
 /*
  * ELD: EDID Like Data
  */
-struct hdmi_eld {
-	bool	monitor_present;
-	bool	eld_valid;
-	int	eld_size;
+struct parsed_hdmi_eld {
+	/*
+	 * all fields will be cleared before updating ELD
+	 */
 	int	baseline_len;
 	int	eld_ver;
 	int	cea_edid_ver;
@@ -731,19 +731,26 @@ struct hdmi_eld {
 	int	spk_alloc;
 	int	sad_count;
 	struct cea_sad sad[ELD_MAX_SAD];
-	/*
-	 * all fields above eld_buffer will be cleared before updating ELD
-	 */
+};
+
+struct hdmi_eld {
+	bool	monitor_present;
+	bool	eld_valid;
+	int	eld_size;
 	char    eld_buffer[ELD_MAX_SIZE];
+	struct parsed_hdmi_eld info;
 #ifdef CONFIG_PROC_FS
 	struct snd_info_entry *proc_entry;
 #endif
 };
 
 int snd_hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid);
-int snd_hdmi_get_eld(struct hdmi_eld *, struct hda_codec *, hda_nid_t);
-void snd_hdmi_show_eld(struct hdmi_eld *eld);
-void snd_hdmi_eld_update_pcm_info(struct hdmi_eld *eld,
+int snd_hdmi_get_eld(struct hda_codec *codec, hda_nid_t nid,
+		     unsigned char *buf, int *eld_size);
+int snd_hdmi_parse_eld(struct parsed_hdmi_eld *e,
+		       const unsigned char *buf, int size);
+void snd_hdmi_show_eld(struct parsed_hdmi_eld *e);
+void snd_hdmi_eld_update_pcm_info(struct parsed_hdmi_eld *e,
 			      struct hda_pcm_stream *hinfo);
 
 #ifdef CONFIG_PROC_FS
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 7a73dfb..dab147a 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -529,7 +529,7 @@ static int hdmi_channel_allocation(struct hdmi_eld *eld, int channels)
 	 * expand ELD's notions to match the ones used by Audio InfoFrame.
 	 */
 	for (i = 0; i < ARRAY_SIZE(eld_speaker_allocation_bits); i++) {
-		if (eld->spk_alloc & (1 << i))
+		if (eld->info.spk_alloc & (1 << i))
 			spk_mask |= eld_speaker_allocation_bits[i];
 	}
 
@@ -543,7 +543,7 @@ static int hdmi_channel_allocation(struct hdmi_eld *eld, int channels)
 		}
 	}
 
-	snd_print_channel_allocation(eld->spk_alloc, buf, sizeof(buf));
+	snd_print_channel_allocation(eld->info.spk_alloc, buf, sizeof(buf));
 	snd_printdd("HDMI: select CA 0x%x for %d-channel allocation: %s\n",
 		    ca, channels, buf);
 
@@ -884,7 +884,7 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec, int pin_idx,
 		ca = 0;
 
 	memset(&ai, 0, sizeof(ai));
-	if (eld->conn_type == 0) { /* HDMI */
+	if (eld->info.conn_type == 0) { /* HDMI */
 		struct hdmi_audio_infoframe *hdmi_ai = &ai.hdmi;
 
 		hdmi_ai->type		= 0x84;
@@ -893,7 +893,7 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec, int pin_idx,
 		hdmi_ai->CC02_CT47	= channels - 1;
 		hdmi_ai->CA		= ca;
 		hdmi_checksum_audio_infoframe(hdmi_ai);
-	} else if (eld->conn_type == 1) { /* DisplayPort */
+	} else if (eld->info.conn_type == 1) { /* DisplayPort */
 		struct dp_audio_infoframe *dp_ai = &ai.dp;
 
 		dp_ai->type		= 0x84;
@@ -1114,7 +1114,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 
 	/* Restrict capabilities by ELD if this isn't disabled */
 	if (!static_hdmi_pcm && eld->eld_valid) {
-		snd_hdmi_eld_update_pcm_info(eld, hinfo);
+		snd_hdmi_eld_update_pcm_info(&eld->info, hinfo);
 		if (hinfo->channels_min > hinfo->channels_max ||
 		    !hinfo->rates || !hinfo->formats) {
 			per_cvt->assigned = 0;
@@ -1185,10 +1185,18 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		"HDMI status: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
 		codec->addr, pin_nid, eld->monitor_present, eld_valid);
 
-	eld->eld_valid = false;
 	if (eld_valid) {
-		if (!snd_hdmi_get_eld(eld, codec, pin_nid))
-			snd_hdmi_show_eld(eld);
+		if (snd_hdmi_get_eld(codec, pin_nid, eld->eld_buffer,
+						     &eld->eld_size) < 0)
+			eld_valid = false;
+		if (eld_valid && snd_hdmi_parse_eld(&eld->info, eld->eld_buffer,
+						    eld->eld_size) < 0)
+			eld_valid = false;
+
+		if (eld_valid) {
+			snd_hdmi_show_eld(&eld->info);
+			eld->eld_valid = true;
+		}
 		else if (repoll) {
 			queue_delayed_work(codec->bus->workq,
 					   &per_pin->work,
-- 
1.7.9.5


--------------030401030405080800050509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030401030405080800050509--
