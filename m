From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [PATCH] ALSA: re-order AC97 codec ID table.
Date: Tue, 15 Jul 2008 03:23:55 +0200
Message-ID: <487BFC2B.8010107@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080101080400020509010302"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 35AC4243CC
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 03:23:02 +0200 (CEST)
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080101080400020509010302
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

Feel free to drop if considered pointless churn but keeping it ordered 
makes checking easier.

Rene.

--------------080101080400020509010302
Content-Type: text/plain;
 name="0002-ALSA-re-order-AC97-codec-ID-table.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-ALSA-re-order-AC97-codec-ID-table.patch"

>From 389e02fd488d8ffdaabd6cc10cf788792258916d Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Tue, 15 Jul 2008 03:13:01 +0200
Subject: [PATCH] ALSA: re-order AC97 codec ID table.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
---
 sound/pci/ac97/ac97_codec.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 8c49a00..f1e3a47 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -67,8 +67,8 @@ struct ac97_codec_id {
 };
 
 static const struct ac97_codec_id snd_ac97_codec_id_vendors[] = {
-{ 0x414b4d00, 0xffffff00, "Asahi Kasei",	NULL,	NULL },
 { 0x41445300, 0xffffff00, "Analog Devices",	NULL,	NULL },
+{ 0x414b4d00, 0xffffff00, "Asahi Kasei",	NULL,	NULL },
 { 0x414c4300, 0xffffff00, "Realtek",		NULL,	NULL },
 { 0x414c4700, 0xffffff00, "Realtek",		NULL,	NULL },
 { 0x434d4900, 0xffffff00, "C-Media Electronics", NULL,	NULL },
@@ -94,11 +94,6 @@ static const struct ac97_codec_id snd_ac97_codec_id_vendors[] = {
 };
 
 static const struct ac97_codec_id snd_ac97_codec_ids[] = {
-{ 0x414b4d00, 0xffffffff, "AK4540",		NULL,		NULL },
-{ 0x414b4d01, 0xffffffff, "AK4542",		NULL,		NULL },
-{ 0x414b4d02, 0xffffffff, "AK4543",		NULL,		NULL },
-{ 0x414b4d06, 0xffffffff, "AK4544A",		NULL,		NULL },
-{ 0x414b4d07, 0xffffffff, "AK4545",		NULL,		NULL },
 { 0x41445303, 0xffffffff, "AD1819",		patch_ad1819,	NULL },
 { 0x41445340, 0xffffffff, "AD1881",		patch_ad1881,	NULL },
 { 0x41445348, 0xffffffff, "AD1881A",		patch_ad1881,	NULL },
@@ -112,20 +107,25 @@ static const struct ac97_codec_id snd_ac97_codec_ids[] = {
 { 0x41445374, 0xffffffff, "AD1981B",		patch_ad1981b,	NULL },
 { 0x41445375, 0xffffffff, "AD1985",		patch_ad1985,	NULL },
 { 0x41445378, 0xffffffff, "AD1986",		patch_ad1986,	NULL },
+{ 0x414b4d00, 0xffffffff, "AK4540",		NULL,		NULL },
+{ 0x414b4d01, 0xffffffff, "AK4542",		NULL,		NULL },
+{ 0x414b4d02, 0xffffffff, "AK4543",		NULL,		NULL },
+{ 0x414b4d06, 0xffffffff, "AK4544A",		NULL,		NULL },
+{ 0x414b4d07, 0xffffffff, "AK4545",		NULL,		NULL },
 { 0x414c4300, 0xffffff00, "ALC100,100P", 	NULL,		NULL },
 { 0x414c4710, 0xfffffff0, "ALC200,200P",	NULL,		NULL },
+{ 0x414c4720, 0xfffffff0, "ALC650",		patch_alc650,	NULL },
 { 0x414c4721, 0xffffffff, "ALC650D",		NULL,	NULL }, /* already patched */
 { 0x414c4722, 0xffffffff, "ALC650E",		NULL,	NULL }, /* already patched */
 { 0x414c4723, 0xffffffff, "ALC650F",		NULL,	NULL }, /* already patched */
-{ 0x414c4720, 0xfffffff0, "ALC650",		patch_alc650,	NULL },
-{ 0x414c4760, 0xfffffff0, "ALC655",		patch_alc655,	NULL },
-{ 0x414c4781, 0xffffffff, "ALC658D",		NULL,	NULL }, /* already patched */
-{ 0x414c4780, 0xfffffff0, "ALC658",		patch_alc655,	NULL },
-{ 0x414c4790, 0xfffffff0, "ALC850",		patch_alc850,	NULL },
 { 0x414c4730, 0xffffffff, "ALC101",		NULL,		NULL },
 { 0x414c4740, 0xfffffff0, "ALC202",		NULL,		NULL },
 { 0x414c4750, 0xfffffff0, "ALC250",		NULL,		NULL },
+{ 0x414c4760, 0xfffffff0, "ALC655",		patch_alc655,	NULL },
 { 0x414c4770, 0xfffffff0, "ALC203",		NULL,		NULL },
+{ 0x414c4780, 0xfffffff0, "ALC658",		patch_alc655,	NULL },
+{ 0x414c4781, 0xffffffff, "ALC658D",		NULL,	NULL }, /* already patched */
+{ 0x414c4790, 0xfffffff0, "ALC850",		patch_alc850,	NULL },
 { 0x434d4941, 0xffffffff, "CMI9738",		patch_cm9738,	NULL },
 { 0x434d4961, 0xffffffff, "CMI9739",		patch_cm9739,	NULL },
 { 0x434d4969, 0xffffffff, "CMI9780",		patch_cm9780,	NULL },
@@ -143,7 +143,7 @@ static const struct ac97_codec_id snd_ac97_codec_ids[] = {
 { 0x43525970, 0xfffffff8, "CS4202",		NULL,		NULL },
 { 0x43585421, 0xffffffff, "HSD11246",		NULL,		NULL },	// SmartMC II
 { 0x43585428, 0xfffffff8, "Cx20468",		patch_conexant,	NULL }, // SmartAMC fixme: the mask might be different
-{ 0x43585431, 0xffffffff, "Cx20551",           patch_cx20551,  NULL },
+{ 0x43585431, 0xffffffff, "Cx20551",		patch_cx20551,  NULL },
 { 0x44543031, 0xfffffff0, "DT0398",		NULL,		NULL },
 { 0x454d4328, 0xffffffff, "EM28028",		NULL,		NULL },  // same as TR28028?
 { 0x45838308, 0xffffffff, "ESS1988",		NULL,		NULL },
@@ -171,11 +171,11 @@ static const struct ac97_codec_id snd_ac97_codec_ids[] = {
 { 0x56494182, 0xffffffff, "VIA1618",		NULL,		NULL },
 { 0x57454301, 0xffffffff, "W83971D",		NULL,		NULL },
 { 0x574d4c00, 0xffffffff, "WM9701,WM9701A",	NULL,		NULL },
-{ 0x574d4C03, 0xffffffff, "WM9703,WM9707,WM9708,WM9717", patch_wolfson03, NULL},
-{ 0x574d4C04, 0xffffffff, "WM9704M,WM9704Q",	patch_wolfson04, NULL},
-{ 0x574d4C05, 0xffffffff, "WM9705,WM9710",	patch_wolfson05, NULL},
-{ 0x574d4C09, 0xffffffff, "WM9709",		NULL,		NULL},
-{ 0x574d4C12, 0xffffffff, "WM9711,WM9712",	patch_wolfson11, NULL},
+{ 0x574d4c03, 0xffffffff, "WM9703,WM9707,WM9708,WM9717", patch_wolfson03, NULL},
+{ 0x574d4c04, 0xffffffff, "WM9704M,WM9704Q",	patch_wolfson04, NULL},
+{ 0x574d4c05, 0xffffffff, "WM9705,WM9710",	patch_wolfson05, NULL},
+{ 0x574d4c09, 0xffffffff, "WM9709",		NULL,		NULL},
+{ 0x574d4c12, 0xffffffff, "WM9711,WM9712",	patch_wolfson11, NULL},
 { 0x574d4c13, 0xffffffff, "WM9713,WM9714",	patch_wolfson13, NULL, AC97_DEFAULT_POWER_OFF},
 { 0x594d4800, 0xffffffff, "YMF743",		patch_yamaha_ymf743,	NULL },
 { 0x594d4802, 0xffffffff, "YMF752",		NULL,		NULL },
-- 
1.5.5


--------------080101080400020509010302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080101080400020509010302--
