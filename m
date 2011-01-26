From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: HDA: Add a new model "asus" for
 Conexant 5066/205xx
Date: Wed, 26 Jan 2011 14:43:27 +0100
Message-ID: <4D4024FF.3040506@canonical.com>
References: <4D398008.8080707@canonical.com>
	<s5hzkqshpdm.wl%tiwai@suse.de>	<4D3D6CB7.5070102@canonical.com>
	<s5hd3nm8nwg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080403010602060706040708"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id F0EB31039C3
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 14:43:28 +0100 (CET)
In-Reply-To: <s5hd3nm8nwg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ajr55555@gmail.com
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080403010602060706040708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2011-01-24 13:52, Takashi Iwai wrote:
> At Mon, 24 Jan 2011 13:12:39 +0100,
> David Henningsson wrote:
>>
>> On 2011-01-22 17:31, Takashi Iwai wrote:
>>> At Fri, 21 Jan 2011 13:46:00 +0100,
>>> David Henningsson wrote:
>>>>
>>>> BugLink: http://bugs.launchpad.net/bugs/701271
>>>>
>>>> This new model, named "asus", is identical to the "hp_laptop" model,
>>>> except for the location of the internal mic, which is at pin 0x1a.
>>>> It is used for Asus K52JU and Lenovo G560.
>>>>
>>>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>>>
>>> Applied, but to topic/asoc branch, as these involve rewrites.
>>> Thanks.
>>
>> You mean the topic/hda branch, right?
>
> Argh, yes, of course...
>
>> Does this mean it'll not be in 2.6.38, and will it be if I provide a
>> backport for the second patch?
>
> Right.

Ok, here's a backport, although untested since I don't have the hardware 
here. Andy, would it be possible for you to test it for me?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------080403010602060706040708
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Add-a-new-model-asus-for-Conexant-5066-205x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Add-a-new-model-asus-for-Conexant-5066-205x.pa";
 filename*1="tch"

>From f36aad0b7f3541bfebc248a7c568b3be8481e050 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 26 Jan 2011 14:27:18 +0100
Subject: [PATCH] ALSA: HDA: Add a new model "asus" for Conexant 5066/205xx

Backport of commit a1d6906e2d2b4655e248f490ab088c27876a600a
(currently in linux/kernel/git/tiwai/sound-2.6.git tree),
meant for kernel 2.6.38.

BugLink: http://bugs.launchpad.net/bugs/701271

This new model, named "asus", is identical to the "hp_laptop" model,
except for the location of the internal mic, which is at pin 0x1a.
It is used for Asus K52JU and Lenovo G560.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |    1 +
 sound/pci/hda/patch_conexant.c               |   41 ++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 16ae430..0caf77e 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -296,6 +296,7 @@ Conexant 5066
 =============
   laptop	Basic Laptop config (default)
   hp-laptop	HP laptops, e g G60
+  asus		Asus K52JU, Lenovo G560
   dell-laptop	Dell laptops
   dell-vostro	Dell Vostro
   olpc-xo-1_5	OLPC XO 1.5
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 9bb030a..32bdd23 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -127,6 +127,7 @@ struct conexant_spec {
 	unsigned int ideapad:1;
 	unsigned int thinkpad:1;
 	unsigned int hp_laptop:1;
+	unsigned int asus:1;
 
 	unsigned int ext_mic_present;
 	unsigned int recording;
@@ -2312,6 +2313,19 @@ static void cxt5066_ideapad_automic(struct hda_codec *codec)
 	}
 }
 
+
+/* toggle input of built-in digital mic and mic jack appropriately */
+static void cxt5066_asus_automic(struct hda_codec *codec)
+{
+	unsigned int present;
+
+	present = snd_hda_jack_detect(codec, 0x1b);
+	snd_printdd("CXT5066: external microphone present=%d\n", present);
+	snd_hda_codec_write(codec, 0x17, 0, AC_VERB_SET_CONNECT_SEL,
+			    present ? 1 : 0);
+}
+
+
 /* toggle input of built-in digital mic and mic jack appropriately */
 static void cxt5066_hp_laptop_automic(struct hda_codec *codec)
 {
@@ -2433,6 +2447,20 @@ static void cxt5066_ideapad_event(struct hda_codec *codec, unsigned int res)
 }
 
 /* unsolicited event for jack sensing */
+static void cxt5066_asus_event(struct hda_codec *codec, unsigned int res)
+{
+	snd_printdd("CXT5066_asus: unsol event %x (%x)\n", res, res >> 26);
+	switch (res >> 26) {
+	case CONEXANT_HP_EVENT:
+		cxt5066_hp_automute(codec);
+		break;
+	case CONEXANT_MIC_EVENT:
+		cxt5066_asus_automic(codec);
+		break;
+	}
+}
+
+/* unsolicited event for jack sensing */
 static void cxt5066_hp_laptop_event(struct hda_codec *codec, unsigned int res)
 {
 	snd_printdd("CXT5066_hp_laptop: unsol event %x (%x)\n", res, res >> 26);
@@ -3053,6 +3081,8 @@ static int cxt5066_init(struct hda_codec *codec)
 			cxt5066_thinkpad_automic(codec);
 		else if (spec->hp_laptop)
 			cxt5066_hp_laptop_automic(codec);
+		else if (spec->asus)
+			cxt5066_asus_automic(codec);
 	}
 	cxt5066_set_mic_boost(codec);
 	return 0;
@@ -3080,6 +3110,7 @@ enum {
 	CXT5066_DELL_VOSTRO,	/* Dell Vostro 1015i */
 	CXT5066_IDEAPAD,	/* Lenovo IdeaPad U150 */
 	CXT5066_THINKPAD,	/* Lenovo ThinkPad T410s, others? */
+	CXT5066_ASUS,		/* Asus K52JU, Lenovo G560 - Int mic at 0x1a and Ext mic at 0x1b */
 	CXT5066_HP_LAPTOP,      /* HP Laptop */
 	CXT5066_MODELS
 };
@@ -3091,6 +3122,7 @@ static const char * const cxt5066_models[CXT5066_MODELS] = {
 	[CXT5066_DELL_VOSTRO]	= "dell-vostro",
 	[CXT5066_IDEAPAD]	= "ideapad",
 	[CXT5066_THINKPAD]	= "thinkpad",
+	[CXT5066_ASUS]		= "asus",
 	[CXT5066_HP_LAPTOP]	= "hp-laptop",
 };
 
@@ -3103,6 +3135,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0408, "Dell Inspiron One 19T", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x103c, 0x360b, "HP G60", CXT5066_HP_LAPTOP),
 	SND_PCI_QUIRK(0x1043, 0x13f3, "Asus A52J", CXT5066_HP_LAPTOP),
+	SND_PCI_QUIRK(0x1043, 0x1643, "Asus K52JU", CXT5066_ASUS),
 	SND_PCI_QUIRK(0x1179, 0xff1e, "Toshiba Satellite C650D", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x1179, 0xff50, "Toshiba Satellite P500-PSPGSC-01800T", CXT5066_OLPC_XO_1_5),
 	SND_PCI_QUIRK(0x1179, 0xffe0, "Toshiba Satellite Pro T130-15F", CXT5066_OLPC_XO_1_5),
@@ -3112,6 +3145,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400s", CXT5066_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x21c5, "Thinkpad Edge 13", CXT5066_THINKPAD),
  	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G560", CXT5066_ASUS),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo", CXT5066_IDEAPAD), /* Fallback for Lenovos without dock mic */
 	{}
 };
@@ -3167,13 +3201,16 @@ static int patch_cxt5066(struct hda_codec *codec)
 		spec->num_init_verbs++;
 		spec->dell_automute = 1;
 		break;
+	case CXT5066_ASUS:
 	case CXT5066_HP_LAPTOP:
 		codec->patch_ops.init = cxt5066_init;
-		codec->patch_ops.unsol_event = cxt5066_hp_laptop_event;
+		codec->patch_ops.unsol_event = board_config == CXT5066_ASUS ?
+			cxt5066_asus_event : cxt5066_hp_laptop_event;
 		spec->init_verbs[spec->num_init_verbs] =
 			cxt5066_init_verbs_hp_laptop;
 		spec->num_init_verbs++;
-		spec->hp_laptop = 1;
+		spec->hp_laptop = board_config == CXT5066_HP_LAPTOP;
+		spec->asus = board_config == CXT5066_ASUS;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixer_master;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixers;
 		/* no S/PDIF out */
-- 
1.7.1


--------------080403010602060706040708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080403010602060706040708--
