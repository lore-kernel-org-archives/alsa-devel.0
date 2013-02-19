From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v2 3/4] ALSA: hda - hdmi: protect access to
	ELD buffer
Date: Tue, 19 Feb 2013 10:45:40 +0100
Message-ID: <512349C4.2080401@canonical.com>
References: <1361263657-15888-1-git-send-email-david.henningsson@canonical.com>
 <1361263657-15888-4-git-send-email-david.henningsson@canonical.com>
 <s5h1uccbr6s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C3752651C2
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 10:45:37 +0100 (CET)
In-Reply-To: <s5h1uccbr6s.wl%tiwai@suse.de>
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

On 02/19/2013 10:15 AM, Takashi Iwai wrote:
> At Tue, 19 Feb 2013 09:47:36 +0100,
> David Henningsson wrote:
>>
>> Because the eld buffer can be simultaneously accessed from both
>> workqueue context (updating) and process context (kcontrol read),
>> we need to protect it with a spinlock to guarantee consistency.
>
> We can't use a spinlock for snd_iprintf(), as this involves with
> vmalloc().  Use a mutex intead.

Ok, thanks for spotting.

>> To avoid holding the spinlock while reading the ELD info from the
>> codec, we introduce a temporary eld buffer.
>
> Looking through the patches, it's better to split to a few parts now:
>
> struct parsed_hdmi_eld {
> 	bool monitor_present;
> 	....
> };
>
> struct hdmi_eld {
> 	char eld_buffer[ELD_MAX_SIZE];
> 	struct parsed_hdmi_eld info;
> 	struct mutex lock;
> #ifdef CONFIG_PROC_FS
> 	struct snd_info_entry *proc_entry;
> #endif
> };
>
> In that way, you can avoid the hack like offset() calculation in
> patch_hdmi.c.  The comparison can be done only for eld_buffer[], too.

This sounds like a good idea. I will do it. I think eld_valid and 
monitor_present should be in hdmi_eld and not parsed_hdmi_eld, because 
those fields do not come from the raw ELD info.



>
>
> thanks,
>
> Takashi
>
>>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>   sound/pci/hda/hda_eld.c    |   12 +++++++++---
>>   sound/pci/hda/hda_local.h  |    3 +++
>>   sound/pci/hda/patch_hdmi.c |   32 +++++++++++++++++++++++++-------
>>   3 files changed, 37 insertions(+), 10 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
>> index 4c054f4..766f011 100644
>> --- a/sound/pci/hda/hda_eld.c
>> +++ b/sound/pci/hda/hda_eld.c
>> @@ -490,7 +490,7 @@ static void hdmi_print_eld_info(struct snd_info_entry *entry,
>>   	struct hdmi_eld *e = entry->private_data;
>>   	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
>>   	int i;
>> -	static char *eld_versoin_names[32] = {
>> +	static char *eld_version_names[32] = {
>>   		"reserved",
>>   		"reserved",
>>   		"CEA-861D or below",
>> @@ -505,15 +505,18 @@ static void hdmi_print_eld_info(struct snd_info_entry *entry,
>>   		[4 ... 7] = "reserved"
>>   	};
>>
>> +	spin_lock(&e->lock);
>>   	snd_iprintf(buffer, "monitor_present\t\t%d\n", e->monitor_present);
>>   	snd_iprintf(buffer, "eld_valid\t\t%d\n", e->eld_valid);
>> -	if (!e->eld_valid)
>> +	if (!e->eld_valid) {
>> +		spin_unlock(&e->lock);
>>   		return;
>> +	}
>>   	snd_iprintf(buffer, "monitor_name\t\t%s\n", e->monitor_name);
>>   	snd_iprintf(buffer, "connection_type\t\t%s\n",
>>   				eld_connection_type_names[e->conn_type]);
>>   	snd_iprintf(buffer, "eld_version\t\t[0x%x] %s\n", e->eld_ver,
>> -					eld_versoin_names[e->eld_ver]);
>> +					eld_version_names[e->eld_ver]);
>>   	snd_iprintf(buffer, "edid_version\t\t[0x%x] %s\n", e->cea_edid_ver,
>>   				cea_edid_version_names[e->cea_edid_ver]);
>>   	snd_iprintf(buffer, "manufacture_id\t\t0x%x\n", e->manufacture_id);
>> @@ -530,6 +533,7 @@ static void hdmi_print_eld_info(struct snd_info_entry *entry,
>>
>>   	for (i = 0; i < e->sad_count; i++)
>>   		hdmi_print_sad_info(i, e->sad + i, buffer);
>> +	spin_unlock(&e->lock);
>>   }
>>
>>   static void hdmi_write_eld_info(struct snd_info_entry *entry,
>> @@ -542,6 +546,7 @@ static void hdmi_write_eld_info(struct snd_info_entry *entry,
>>   	long long val;
>>   	unsigned int n;
>>
>> +	spin_lock(&e->lock);
>>   	while (!snd_info_get_line(buffer, line, sizeof(line))) {
>>   		if (sscanf(line, "%s %llx", name, &val) != 2)
>>   			continue;
>> @@ -593,6 +598,7 @@ static void hdmi_write_eld_info(struct snd_info_entry *entry,
>>   				e->sad_count = n + 1;
>>   		}
>>   	}
>> +	spin_unlock(&e->lock);
>>   }
>>
>>
>> diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
>> index 05f1d59..b2d6a9e 100644
>> --- a/sound/pci/hda/hda_local.h
>> +++ b/sound/pci/hda/hda_local.h
>> @@ -712,8 +712,11 @@ struct cea_sad {
>>
>>   /*
>>    * ELD: EDID Like Data
>> + *
>> + * Note: The order of these fields is used in hdmi_present_sense
>>    */
>>   struct hdmi_eld {
>> +	spinlock_t lock;
>>   	bool	monitor_present;
>>   	bool	eld_valid;
>>   	int	eld_size;
>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>> index 7a73dfb..52b1afc 100644
>> --- a/sound/pci/hda/patch_hdmi.c
>> +++ b/sound/pci/hda/patch_hdmi.c
>> @@ -91,6 +91,7 @@ struct hdmi_spec {
>>   	struct hda_pcm pcm_rec[MAX_HDMI_PINS];
>>   	unsigned int channels_max; /* max over all cvts */
>>
>> +	struct hdmi_eld temp_eld;
>>   	/*
>>   	 * Non-generic ATI/NVIDIA specific
>>   	 */
>> @@ -352,7 +353,9 @@ static int hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
>>   	pin_idx = kcontrol->private_value;
>>   	eld = &spec->pins[pin_idx].sink_eld;
>>
>> +	spin_lock(&eld->lock);
>>   	uinfo->count = eld->eld_valid ? eld->eld_size : 0;
>> +	spin_unlock(&eld->lock);
>>
>>   	return 0;
>>   }
>> @@ -368,7 +371,9 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
>>   	pin_idx = kcontrol->private_value;
>>   	eld = &spec->pins[pin_idx].sink_eld;
>>
>> +	spin_lock(&eld->lock);
>>   	if (eld->eld_size > ARRAY_SIZE(ucontrol->value.bytes.data)) {
>> +		spin_unlock(&eld->lock);
>>   		snd_BUG();
>>   		return -EINVAL;
>>   	}
>> @@ -376,6 +381,7 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
>>   	if (eld->eld_valid)
>>   		memcpy(ucontrol->value.bytes.data, eld->eld_buffer,
>>   		       eld->eld_size);
>> +	spin_unlock(&eld->lock);
>>
>>   	return 0;
>>   }
>> @@ -1162,7 +1168,9 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
>>   static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>>   {
>>   	struct hda_codec *codec = per_pin->codec;
>> -	struct hdmi_eld *eld = &per_pin->sink_eld;
>> +	struct hdmi_spec *spec = codec->spec;
>> +	struct hdmi_eld *eld = &spec->temp_eld;
>> +	struct hdmi_eld *pin_eld = &per_pin->sink_eld;
>>   	hda_nid_t pin_nid = per_pin->pin_nid;
>>   	/*
>>   	 * Always execute a GetPinSense verb here, even when called from
>> @@ -1173,28 +1181,37 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
>>   	 * the unsolicited response to avoid custom WARs.
>>   	 */
>>   	int present = snd_hda_pin_sense(codec, pin_nid);
>> -	bool eld_valid = false;
>> +	bool update_eld = false;
>>
>>   	memset(eld, 0, offsetof(struct hdmi_eld, eld_buffer));
>>
>>   	eld->monitor_present	= !!(present & AC_PINSENSE_PRESENCE);
>>   	if (eld->monitor_present)
>> -		eld_valid	= !!(present & AC_PINSENSE_ELDV);
>> +		eld->eld_valid  = !!(present & AC_PINSENSE_ELDV);
>>
>>   	_snd_printd(SND_PR_VERBOSE,
>>   		"HDMI status: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
>> -		codec->addr, pin_nid, eld->monitor_present, eld_valid);
>> +		codec->addr, pin_nid, eld->monitor_present, eld->eld_valid);
>>
>> -	eld->eld_valid = false;
>> -	if (eld_valid) {
>> -		if (!snd_hdmi_get_eld(eld, codec, pin_nid))
>> +	if (eld->eld_valid) {
>> +		if (!snd_hdmi_get_eld(eld, codec, pin_nid)) {
>>   			snd_hdmi_show_eld(eld);
>> +			update_eld = true;
>> +		}
>>   		else if (repoll) {
>>   			queue_delayed_work(codec->bus->workq,
>>   					   &per_pin->work,
>>   					   msecs_to_jiffies(300));
>>   		}
>>   	}
>> +
>> +	spin_lock(&pin_eld->lock);
>> +	if (pin_eld->eld_valid && !eld->eld_valid)
>> +		update_eld = true;
>> +	if (update_eld)
>> +		memcpy(&pin_eld->monitor_present, &eld->monitor_present,
>> +		       sizeof(struct hdmi_eld) - sizeof(spinlock_t));
>> +	spin_unlock(&pin_eld->lock);
>>   }
>>
>>   static void hdmi_repoll_eld(struct work_struct *work)
>> @@ -1662,6 +1679,7 @@ static int generic_hdmi_init_per_pins(struct hda_codec *codec)
>>   		struct hdmi_eld *eld = &per_pin->sink_eld;
>>
>>   		per_pin->codec = codec;
>> +		spin_lock_init(&eld->lock);
>>   		INIT_DELAYED_WORK(&per_pin->work, hdmi_repoll_eld);
>>   		snd_hda_eld_proc_new(codec, eld, pin_idx);
>>   	}
>> --
>> 1.7.9.5
>>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
