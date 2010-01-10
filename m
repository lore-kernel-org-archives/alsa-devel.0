From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] ac97: add AC97 STMicroelectronics' codecs
Date: Sun, 10 Jan 2010 17:21:14 +0100
Message-ID: <20100110172114.417be4ba.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 543392471F
	for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2010 17:21:52 +0100 (CET)
Received: from poczta.interia.pl (mi06.poczta.interia.pl [10.217.12.6])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id 85D402702C9
	for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2010 17:21:44 +0100 (CET)
Received: from krzysio.dom.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id D04BF1324A1
	for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2010 17:21:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add the STMicroelectronics ST7597 codec and an unknown codec
from the same manufacturer found on the Creative SB 128 card (CT4810).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
Datasheet of the ST7597 can be found on the web (various datasheet sites have copies).

 sound/pci/ac97/ac97_codec.c |   10 ++++++++++
 sound/pci/ac97/ac97_id.h    |    2 ++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index c119206..a7630e9 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -83,6 +83,7 @@ static const struct ac97_codec_id snd_ac97_codec_id_vendors[] = {
 { 0x4e534300, 0xffffff00, "National Semiconductor", NULL, NULL },
 { 0x50534300, 0xffffff00, "Philips",		NULL,	NULL },
 { 0x53494c00, 0xffffff00, "Silicon Laboratory",	NULL,	NULL },
+{ 0x53544d00, 0xffffff00, "STMicroelectronics",	NULL,	NULL },
 { 0x54524100, 0xffffff00, "TriTech",		NULL,	NULL },
 { 0x54584e00, 0xffffff00, "Texas Instruments",	NULL,	NULL },
 { 0x56494100, 0xffffff00, "VIA Technologies",   NULL,	NULL },
@@ -161,6 +162,7 @@ static const struct ac97_codec_id snd_ac97_codec_ids[] = {
 { 0x4e534350, 0xffffffff, "LM4550",		patch_lm4550,  	NULL }, // volume wrap fix 
 { 0x50534304, 0xffffffff, "UCB1400",		patch_ucb1400,	NULL },
 { 0x53494c20, 0xffffffe0, "Si3036,8",		mpatch_si3036,	mpatch_si3036, AC97_MODEM_PATCH },
+{ 0x53544d02, 0xffffffff, "ST7597",		NULL,		NULL },
 { 0x54524102, 0xffffffff, "TR28022",		NULL,		NULL },
 { 0x54524103, 0xffffffff, "TR28023",		NULL,		NULL },
 { 0x54524106, 0xffffffff, "TR28026",		NULL,		NULL },
@@ -213,6 +215,14 @@ static int snd_ac97_valid_reg(struct snd_ac97 *ac97, unsigned short reg)
 {
 	/* filter some registers for buggy codecs */
 	switch (ac97->id) {
+	case AC97_ID_ST_AC97_ID4:
+		if (reg == 0x08)
+			return 0;
+		/* fall through */
+	case AC97_ID_ST7597:
+		if (reg == 0x22 || reg == 0x7a)
+			return 1;
+		/* fall through */
 	case AC97_ID_AK4540:
 	case AC97_ID_AK4542:
 		if (reg <= 0x1c || reg == 0x20 || reg == 0x26 || reg >= 0x7c)
diff --git a/sound/pci/ac97/ac97_id.h b/sound/pci/ac97/ac97_id.h
index c129492..d603147 100644
--- a/sound/pci/ac97/ac97_id.h
+++ b/sound/pci/ac97/ac97_id.h
@@ -62,3 +62,5 @@
 #define AC97_ID_CM9761_78	0x434d4978
 #define AC97_ID_CM9761_82	0x434d4982
 #define AC97_ID_CM9761_83	0x434d4983
+#define AC97_ID_ST7597		0x53544d02
+#define AC97_ID_ST_AC97_ID4	0x53544d04
-- 
1.6.4
