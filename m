From: Kailang <kailang@realtek.com>
Subject: Re: Update patch for codecs alias name for Dell
Date: Thu, 28 Nov 2013 15:30:56 +0800
Message-ID: <13CB35BE00B34161858F09AF4314495C@realtek.com.tw>
References: <8837DB3485424EB4ADE016301C6D7DF6@realtek.com.tw>
 <s5hhaay6rsk.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D49D2619E3
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 08:30:48 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I remodified the code as belowing.

>From 888b51395ebab411660401f856e3af7988d9240b Mon Sep 17 00:00:00 2001
From: Kailang Yang <kailang@realtek.com>
Date: Thu, 28 Nov 2013 15:23:20 +0800
Subject: [PATCH] ALSA: hda/realtek - Add more codecs alias name for Dell

Dell assigned alias name for more codecs.
ALC3220 ALC3221 ALC3223 ALC3226 ALC3234 ALC3661.

Signed-off-by: Kailang Yang <kailang@realtek.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c4ad9d1..ece86ca 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -903,7 +903,7 @@ static int alc_codec_rename(struct hda_codec *codec, 
const char *name)
 }

 /*
- * Rename codecs appropriately from COEF value
+ * Rename codecs appropriately from COEF value or subvendor id
  */
 struct alc_codec_rename_table {
  unsigned int vendor_id;
@@ -912,6 +912,13 @@ struct alc_codec_rename_table {
  const char *name;
 };

+struct alc_codec_rename_pci_table {
+ unsigned int codec_vendor_id;
+ unsigned short pci_subvendor;
+ unsigned short pci_subdevice;
+ const char *name;
+};
+
 static struct alc_codec_rename_table rename_tbl[] = {
  { 0x10ec0269, 0xfff0, 0x3010, "ALC277" },
  { 0x10ec0269, 0xf0f0, 0x2010, "ALC259" },
@@ -931,9 +938,20 @@ static struct alc_codec_rename_table rename_tbl[] = {
  { } /* terminator */
 };

+static struct alc_codec_rename_pci_table rename_pci_tbl[] = {
+ { 0x10ec0280, 0x1028, 0, "ALC3220" },
+ { 0x10ec0282, 0x1028, 0, "ALC3221" },
+ { 0x10ec0283, 0x1028, 0, "ALC3223" },
+ { 0x10ec0292, 0x1028, 0, "ALC3226" },
+ { 0x10ec0255, 0x1028, 0, "ALC3234" },
+ { 0x10ec0668, 0x1028, 0, "ALC3661" },
+ { } /* terminator */
+};
+
 static int alc_codec_rename_from_preset(struct hda_codec *codec)
 {
  const struct alc_codec_rename_table *p;
+ const struct alc_codec_rename_pci_table *q;

  for (p = rename_tbl; p->vendor_id; p++) {
   if (p->vendor_id != codec->vendor_id)
@@ -941,10 +959,18 @@ static int alc_codec_rename_from_preset(struct 
hda_codec *codec)
   if ((alc_get_coef0(codec) & p->coef_mask) == p->coef_bits)
    return alc_codec_rename(codec, p->name);
  }
+ for (q = rename_pci_tbl; q->codec_vendor_id; q++) {
+  if (q->codec_vendor_id != codec->vendor_id)
+   continue;
+  if (q->pci_subvendor != codec->bus->pci->subsystem_vendor)
+   continue;
+  if (!q->pci_subdevice ||
+      q->pci_subdevice == codec->bus->pci->subsystem_device)
+   return alc_codec_rename(codec, q->name);
+ }
  return 0;
 }

-
 /*
  * Digital-beep handlers
  */


> At Wed, 27 Nov 2013 18:01:03 +0800,
> Kailang wrote:
>>
>> Hi Takashi,
>>
>> Dell assigned more codecs for alias name.
>> I update in attach patch.
>
> It's better to handle the error immediately, i.e. put
>  if (err < 0)
>    goto error;
> just after each alc_codec_rename() call.
>
> Or, it's even better to introduce a table like
>
> struct alc_codec_rename_pci_table {
> unsigned int codec_vendor;
> unsigned short pci_subvendor;
> unsigned short pci_subdevice;
> const char *name;
> };
>
> static struct alc_codec_rename_table rename_pci_tbl[] = {
> { 0x10ec0280, 0x1028, 0, "ALC3220" },
> { 0x10ec0282, 0x1028, 0, "ALC3221" },
> { 0x10280284, 0x1028, 0, "ALC3226" },
> .....
> { } /* terminator */
> };
>
> Then add a check like:
>
> static int alc_codec_rename_from_preset(struct hda_codec *codec)
> {
> const struct alc_codec_rename_table *p;
> const struct alc_codec_rename_pci_table *q;
>
> .....
>
> for (q = rename_pci_tbl; q->codec_vendor; q++) {
> if (q->vendor_id != codec->vendor_id)
> continue;
> if (q->pci_subsystem != codec->bus->pci->subsystem_vendor)
> continue;
> if (!q->pci_subdevice ||
>     q->pci_subdevice == codec->bus->pci->subsystem_device)
> return alc_codec_rename(codec, q->name);
> }
>
> return 0;
> }
>
>
> thanks,
>
> Takashi
>
> ------Please consider the environment before printing this e-mail. 
