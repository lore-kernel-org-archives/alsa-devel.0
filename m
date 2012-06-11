From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Create phantom jacks for fixed
 inputs and outputs
Date: Mon, 11 Jun 2012 13:58:43 +0200
Message-ID: <4FD5DD73.5070300@canonical.com>
References: <1339077128-9534-1-git-send-email-david.henningsson@canonical.com>
	<s5h62b2tcbg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010405080703040807000606"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 0963B2435C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 13:58:43 +0200 (CEST)
In-Reply-To: <s5h62b2tcbg.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------010405080703040807000606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2012 10:52 AM, Takashi Iwai wrote:
> At Thu,  7 Jun 2012 15:52:08 +0200,
> David Henningsson wrote:
>>
>> PulseAudio sometimes have difficulties knowing that there is a
>> "Speaker" or "Internal Mic", if they have no individual volume
>> controls or selectors. As a result, only e g "Headphone" might
>> be created for a laptop, but no "Speaker".
>> To help out, create phantom jacks (that are always present,
>> at least for now) for "Speaker", "Internal Mic" etc, in case we
>> detect them.
>> The naming convention is e g "Speaker Phantom Jack".
>>
>> In order not to pollute the /dev/input namespace with even more
>> devices, these are added to the kcontrols only, not the input devices.
>>
>> An implementation note:
>> The possibility to override how to actually do jack sensing opens
>> up for more advanced usage of the jack infrastructure in the future
>> (e g letting the headphone jack detection set presence status for
>> both headphone and mic in case of a headset jack, among other things).
>>
>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>> ---
>>   sound/pci/hda/hda_jack.c |   64 ++++++++++++++++++++++++++++++++++------------
>>   sound/pci/hda/hda_jack.h |    5 ++++
>>   2 files changed, 52 insertions(+), 17 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
>> index 2dd1c11..c5569f1 100644
>> --- a/sound/pci/hda/hda_jack.c
>> +++ b/sound/pci/hda/hda_jack.c
>> @@ -133,6 +133,13 @@ static void jack_detect_update(struct hda_codec *codec,
>>   	}
>>   }
>>
>> +static void jack_detect_always_present(struct hda_codec *codec,
>> +				       struct hda_jack_tbl *jack)
>> +{
>> +	jack->pin_sense = AC_PINSENSE_PRESENCE;
>> +	jack->jack_dirty = 0;
>> +}
>> +
>>   /**
>>    * snd_hda_set_dirty_all - Mark all the cached as dirty
>>    *
>> @@ -162,7 +169,8 @@ u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid)
>>   {
>>   	struct hda_jack_tbl *jack = snd_hda_jack_tbl_get(codec, nid);
>>   	if (jack) {
>> -		jack_detect_update(codec, jack);
>> +		if (jack->update_func)
>> +			jack->update_func(codec, jack);
>
> IMO, it's easier to modify jack_detect_update().
> Instead of adding update_func pointer, add a new flag phantom_jack
> (can be a bit field), then in jack_detect_update():

The idea was to open up for other types of jack overrides as well, but 
if you prefer to keep it simpler while we can, I'm okay with that.

I'm attaching the modified patch.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------010405080703040807000606
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Create-phantom-jacks-for-fixed-inputs-and-o.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Create-phantom-jacks-for-fixed-inputs-and-o.pa";
 filename*1="tch"

>From da45741a45fafc4b4d3767948d269be06cf36851 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 4 Jun 2012 09:33:51 +0200
Subject: [PATCH] ALSA: HDA: Create phantom jacks for fixed inputs and outputs

PulseAudio sometimes have difficulties knowing that there is a
"Speaker" or "Internal Mic", if they have no individual volume
controls or selectors. As a result, only e g "Headphone" might
be created for a laptop, but no "Speaker".
To help out, create phantom jacks (that are always present,
at least for now) for "Speaker", "Internal Mic" etc, in case we
detect them.
The naming convention is e g "Speaker Phantom Jack".

In order not to pollute the /dev/input namespace with even more
devices, these are added to the kcontrols only, not the input devices.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_jack.c |   59 ++++++++++++++++++++++++++++++++--------------
 sound/pci/hda/hda_jack.h |    1 +
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 2dd1c11..60c976f 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -127,10 +127,15 @@ void snd_hda_jack_tbl_clear(struct hda_codec *codec)
 static void jack_detect_update(struct hda_codec *codec,
 			       struct hda_jack_tbl *jack)
 {
-	if (jack->jack_dirty || !jack->jack_detect) {
+	if (!jack->jack_dirty)
+		return;
+
+	if (jack->phantom_jack)
+		jack->pin_sense = AC_PINSENSE_PRESENCE;
+	else
 		jack->pin_sense = read_pin_sense(codec, jack->nid);
-		jack->jack_dirty = 0;
-	}
+
+	jack->jack_dirty = 0;
 }
 
 /**
@@ -264,8 +269,8 @@ static void hda_free_jack_priv(struct snd_jack *jack)
  * This assigns a jack-detection kctl to the given pin.  The kcontrol
  * will have the given name and index.
  */
-int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name, int idx)
+static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
+			  const char *name, int idx, bool phantom_jack)
 {
 	struct hda_jack_tbl *jack;
 	struct snd_kcontrol *kctl;
@@ -283,19 +288,30 @@ int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 	if (err < 0)
 		return err;
 	jack->kctl = kctl;
+	jack->phantom_jack = !!phantom_jack;
+
 	state = snd_hda_jack_detect(codec, nid);
 	snd_kctl_jack_report(codec->bus->card, kctl, state);
 #ifdef CONFIG_SND_HDA_INPUT_JACK
-	jack->type = get_input_jack_type(codec, nid);
-	err = snd_jack_new(codec->bus->card, name, jack->type, &jack->jack);
-	if (err < 0)
-		return err;
-	jack->jack->private_data = jack;
-	jack->jack->private_free = hda_free_jack_priv;
-	snd_jack_report(jack->jack, state ? jack->type : 0);
+	if (!phantom_jack) {
+		jack->type = get_input_jack_type(codec, nid);
+		err = snd_jack_new(codec->bus->card, name, jack->type,
+				   &jack->jack);
+		if (err < 0)
+			return err;
+		jack->jack->private_data = jack;
+		jack->jack->private_free = hda_free_jack_priv;
+		snd_jack_report(jack->jack, state ? jack->type : 0);
+	}
 #endif
 	return 0;
 }
+
+int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
+			  const char *name, int idx)
+{
+	return __snd_hda_jack_add_kctl(codec, nid, name, idx, false);
+}
 EXPORT_SYMBOL_HDA(snd_hda_jack_add_kctl);
 
 static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
@@ -305,25 +321,32 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 	unsigned int def_conf, conn;
 	char name[44];
 	int idx, err;
+	bool phantom_jack;
 
 	if (!nid)
 		return 0;
-	if (!is_jack_detectable(codec, nid))
-		return 0;
 	def_conf = snd_hda_codec_get_pincfg(codec, nid);
 	conn = get_defcfg_connect(def_conf);
-	if (conn != AC_JACK_PORT_COMPLEX)
+	if (conn == AC_JACK_PORT_NONE)
 		return 0;
+	phantom_jack = (conn != AC_JACK_PORT_COMPLEX) ||
+		       !is_jack_detectable(codec, nid);
 
 	snd_hda_get_pin_label(codec, nid, cfg, name, sizeof(name), &idx);
+	if (phantom_jack)
+		/* Example final name: "Internal Mic Phantom Jack" */
+		strncat(name, " Phantom", sizeof(name) - strlen(name) - 1);
 	if (!strcmp(name, lastname) && idx == *lastidx)
 		idx++;
-	strncpy(lastname, name, 44);
+	strncpy(lastname, name, sizeof(name));
 	*lastidx = idx;
-	err = snd_hda_jack_add_kctl(codec, nid, name, idx);
+	err = __snd_hda_jack_add_kctl(codec, nid, name, idx, phantom_jack);
 	if (err < 0)
 		return err;
-	return snd_hda_jack_detect_enable(codec, nid, 0);
+
+	if (!phantom_jack)
+		return snd_hda_jack_detect_enable(codec, nid, 0);
+	return 0;
 }
 
 /**
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index 8ae5246..a9803da 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -23,6 +23,7 @@ struct hda_jack_tbl {
 	unsigned int pin_sense;		/* cached pin-sense value */
 	unsigned int jack_detect:1;	/* capable of jack-detection? */
 	unsigned int jack_dirty:1;	/* needs to update? */
+	unsigned int phantom_jack:1;    /* a fixed, always present port? */
 	struct snd_kcontrol *kctl;	/* assigned kctl for jack-detection */
 #ifdef CONFIG_SND_HDA_INPUT_JACK
 	int type;
-- 
1.7.9.5


--------------010405080703040807000606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010405080703040807000606--
