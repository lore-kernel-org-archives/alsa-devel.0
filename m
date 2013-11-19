From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Enable mute/mic-mute LEDs for
 more Thinkpads with Realtek codec
Date: Tue, 19 Nov 2013 11:09:19 +0100
Message-ID: <528B38CF.6090602@canonical.com>
References: <1384771907-2936-1-git-send-email-david.henningsson@canonical.com>
 <s5ha9h1zzaz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050504080205010708000100"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 25E562610C7
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 11:09:22 +0100 (CET)
In-Reply-To: <s5ha9h1zzaz.wl%tiwai@suse.de>
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
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, yk@canonical.com, Alex Hung <alex.hung@canonical.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050504080205010708000100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 11/18/2013 01:09 PM, Takashi Iwai wrote:
> At Mon, 18 Nov 2013 11:51:47 +0100,
> David Henningsson wrote:
>>
>> We're using the ACPI interface to detect whether we're dealing with a Thinkpad
>> or not. This way we're not loading the thinkpad_acpi module when we're not on
>> a Thinkpad, but at the same time, we give the opportunity to check for, and
>> potentially enable, both present and future Thinkpad with mute/micmute LEDs.
>>
>> At least those running the ALC269 family (269 to 299) of Realtek codecs.
>>
>> Cc: Alex Hung <alex.hung@canonical.com>
>> Tested-by: Hui Wang <hui.wang@canonical.com>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>  sound/pci/hda/patch_realtek.c |   29 ++++++++++++++++++++++++++---
>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> Hi Takashi,
>>
>> Sorry I'm late with this one. I'm hoping that you can still merge it for 3.13,
>> but if you can't, we'll just backport it into the Ubuntu 3.13 kernel instead,
>> so not the end of the world I guess.
> 
> OK, I merged it now, as it's not too intrusive, 

Ok, thanks a lot!

> and the build test
> without CONFIG_ACPI passed.

Yeah, I don't think thinkpad_acpi will stop depend on acpi anytime
soon... :-)

Anyway, I'm attaching two more patches - one for enabling thinkpad_acpi
on the lenovo_dock fixup (I must have missed this in the previous
patch), and one for hda-emu.

> 
> 
> thanks,
> 
> Takashi
> 
> 
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index 04d1e6b..05987ff 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -3652,9 +3652,29 @@ static void alc290_fixup_mono_speakers(struct hda_codec *codec,
>>  #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
>>  
>>  #include <linux/thinkpad_acpi.h>
>> +#include <acpi/acpi.h>
>>  
>>  static int (*led_set_func)(int, bool);
>>  
>> +static acpi_status acpi_check_cb(acpi_handle handle, u32 lvl, void *context,
>> +				 void **rv)
>> +{
>> +	bool *found = context;
>> +	*found = true;
>> +	return AE_OK;
>> +}
>> +
>> +static bool is_thinkpad(struct hda_codec *codec)
>> +{
>> +	bool found = false;
>> +	if (codec->subsystem_id >> 16 != 0x17aa)
>> +		return false;
>> +	if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb, &found, NULL)) && found)
>> +		return true;
>> +	found = false;
>> +	return ACPI_SUCCESS(acpi_get_devices("IBM0068", acpi_check_cb, &found, NULL)) && found;
>> +}
>> +
>>  static void update_tpacpi_mute_led(void *private_data, int enabled)
>>  {
>>  	if (led_set_func)
>> @@ -3680,6 +3700,8 @@ static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
>>  	bool removefunc = false;
>>  
>>  	if (action == HDA_FIXUP_ACT_PROBE) {
>> +		if (!is_thinkpad(codec))
>> +			return;
>>  		if (!led_set_func)
>>  			led_set_func = symbol_request(tpacpi_led_set);
>>  		if (!led_set_func) {
>> @@ -4027,6 +4049,8 @@ static const struct hda_fixup alc269_fixups[] = {
>>  	[ALC269_FIXUP_LIMIT_INT_MIC_BOOST] = {
>>  		.type = HDA_FIXUP_FUNC,
>>  		.v.func = alc269_fixup_limit_int_mic_boost,
>> +		.chained = true,
>> +		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
>>  	},
>>  	[ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED] = {
>>  		.type = HDA_FIXUP_FUNC,
>> @@ -4070,8 +4094,6 @@ static const struct hda_fixup alc269_fixups[] = {
>>  	[ALC269_FIXUP_THINKPAD_ACPI] = {
>>  		.type = HDA_FIXUP_FUNC,
>>  		.v.func = alc_fixup_thinkpad_acpi,
>> -		.chained = true,
>> -		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
>>  	},
>>  	[ALC255_FIXUP_DELL1_MIC_NO_PRESENCE] = {
>>  		.type = HDA_FIXUP_PINS,
>> @@ -4173,7 +4195,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>>  	SND_PCI_QUIRK(0x17aa, 0x2208, "Thinkpad T431s", ALC269_FIXUP_LENOVO_DOCK),
>>  	SND_PCI_QUIRK(0x17aa, 0x220c, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>>  	SND_PCI_QUIRK(0x17aa, 0x2212, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>> -	SND_PCI_QUIRK(0x17aa, 0x2214, "Thinkpad", ALC269_FIXUP_THINKPAD_ACPI),
>> +	SND_PCI_QUIRK(0x17aa, 0x2214, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>>  	SND_PCI_QUIRK(0x17aa, 0x2215, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>>  	SND_PCI_QUIRK(0x17aa, 0x5013, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>>  	SND_PCI_QUIRK(0x17aa, 0x501a, "Thinkpad", ALC283_FIXUP_INT_MIC),
>> @@ -4181,6 +4203,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>>  	SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>>  	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
>>  	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
>> +	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", ALC269_FIXUP_THINKPAD_ACPI),
>>  	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
>>  
>>  #if 0
>> -- 
>> 1.7.9.5
>>
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------050504080205010708000100
Content-Type: text/x-patch;
 name="0001-hda-emu-Add-acpi.h-header.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-hda-emu-Add-acpi.h-header.patch"

>From c4b634f2a7fb7a970907b89df99d2333201e8534 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 19 Nov 2013 10:55:17 +0100
Subject: [PATCH] hda-emu: Add acpi.h header

This is needed for the new acpi functionality in patch_realtek.c.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/acpi/acpi.h |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 include/acpi/acpi.h

diff --git a/include/acpi/acpi.h b/include/acpi/acpi.h
new file mode 100644
index 0000000..d7d6cb9
--- /dev/null
+++ b/include/acpi/acpi.h
@@ -0,0 +1,36 @@
+#ifndef __ACPI_H__
+#define __ACPI_H__
+
+/* Copy-pasted from acpixf.h, acexcep.h and actypes.h. */
+
+/*
+ * Miscellaneous types
+ */
+typedef u32 acpi_status;	/* All ACPI Exceptions */
+typedef u32 acpi_name;		/* 4-byte ACPI name */
+typedef char *acpi_string;	/* Null terminated ASCII string */
+typedef void *acpi_handle;	/* Actually a ptr to a NS Node */
+
+typedef
+acpi_status(*acpi_walk_callback) (acpi_handle object,
+				  u32 nesting_level,
+				  void *context, void **return_value);
+
+/*
+ * Success is always zero, failure is non-zero
+ */
+#define ACPI_SUCCESS(a)                 (!(a))
+#define ACPI_FAILURE(a)                 (a)
+
+#define ACPI_SKIP(a)                    (a == AE_CTRL_SKIP)
+#define AE_OK                           (acpi_status) 0x0000
+
+static inline acpi_status
+acpi_get_devices(const char *HID,
+		 acpi_walk_callback user_function,
+		 void *context, void **return_value)
+{
+	return user_function(NULL, 0, context, NULL);
+}
+
+#endif				/* __ACPI_H__ */
-- 
1.7.9.5


--------------050504080205010708000100
Content-Type: text/x-patch;
 name="0001-ALSA-hda-Also-enable-mute-micmute-LED-control-for-Le.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-Also-enable-mute-micmute-LED-control-for-Le.pa";
 filename*1="tch"

>From 026e9cb7c2527dc42448d9ae414eb8ab9661ee24 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 19 Nov 2013 10:25:53 +0100
Subject: [PATCH] ALSA: hda - Also enable mute/micmute LED control for "Lenovo
 dock" fixup

The docking station is a Thinkpad thing, so it makes sense to check
for mute/micmute LEDs for that quirk type too.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 05987ff..8593d4e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3945,6 +3945,8 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
 	[ALC269_FIXUP_DELL1_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
-- 
1.7.9.5


--------------050504080205010708000100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050504080205010708000100--
