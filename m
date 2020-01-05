Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEBBC33C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 15:19:22 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907DE2085B
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 15:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907DE2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFC871816;
	Sun,  5 Jan 2020 16:18:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFC871816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578237560;
	bh=mpDLMx9OSH+8/xcEoRHqSU1JeADYF7fuBUjuIrzgq0I=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rtBJGl0HJJLvEOv5AGLppP0RiBiHwN53VBm3FduzpICzhXZCOvkTf2YEayV9bXD9R
	 zp6rJ08AA9MijIDtJKbL5CumCcGGyU9NsxjWB38c/xnB40CRbLuxyuUyPn8QpGBtVZ
	 h+RIYiMLFFdjlT4UVKMRJQb09ug7NSCCEmqlAVaU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF1A2F804D7;
	Sun,  5 Jan 2020 15:50:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A5AFF80393; Sun,  5 Jan 2020 15:49:40 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1271CF802C3
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1271CF802C3
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1D60AB158
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:34 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:48:05 +0100
Message-Id: <20200105144823.29547-51-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 50/68] ALSA: opti9xx: More constifications
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Apply const prefix to the static resource tables, the mc size tables
and the string arrays.

Just for minor optimization and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/opti9xx/miro.c           | 18 +++++++++---------
 sound/isa/opti9xx/opti92x-ad1848.c | 18 +++++++++---------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index a9c773b9f471..e764816a8f7a 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -119,7 +119,7 @@ struct snd_miro {
 
 static struct snd_miro_aci aci_device;
 
-static char * snd_opti9xx_names[] = {
+static const char * const snd_opti9xx_names[] = {
 	"unknown",
 	"82C928", "82C929",
 	"82C924", "82C925",
@@ -637,7 +637,7 @@ static const struct snd_kcontrol_new snd_miro_capture_control[] = {
 	.put = snd_miro_put_capture,
 }};
 
-static unsigned char aci_init_values[][2] = {
+static const unsigned char aci_init_values[][2] = {
 	{ ACI_SET_MUTE, 0x00 },
 	{ ACI_SET_POWERAMP, 0x00 },
 	{ ACI_SET_PREAMP, 0x00 },
@@ -764,7 +764,7 @@ static int snd_miro_mixer(struct snd_card *card,
 static int snd_miro_init(struct snd_miro *chip,
 			 unsigned short hardware)
 {
-	static int opti9xx_mc_size[] = {7, 7, 10, 10, 2, 2, 2};
+	static const int opti9xx_mc_size[] = {7, 7, 10, 10, 2, 2, 2};
 
 	chip->hardware = hardware;
 	strcpy(chip->name, snd_opti9xx_names[hardware]);
@@ -1387,12 +1387,12 @@ static int snd_miro_isa_match(struct device *devptr, unsigned int n)
 
 static int snd_miro_isa_probe(struct device *devptr, unsigned int n)
 {
-	static long possible_ports[] = {0x530, 0xe80, 0xf40, 0x604, -1};
-	static long possible_mpu_ports[] = {0x330, 0x300, 0x310, 0x320, -1};
-	static int possible_irqs[] = {11, 9, 10, 7, -1};
-	static int possible_mpu_irqs[] = {10, 5, 9, 7, -1};
-	static int possible_dma1s[] = {3, 1, 0, -1};
-	static int possible_dma2s[][2] = { {1, -1}, {0, -1}, {-1, -1},
+	static const long possible_ports[] = {0x530, 0xe80, 0xf40, 0x604, -1};
+	static const long possible_mpu_ports[] = {0x330, 0x300, 0x310, 0x320, -1};
+	static const int possible_irqs[] = {11, 9, 10, 7, -1};
+	static const int possible_mpu_irqs[] = {10, 5, 9, 7, -1};
+	static const int possible_dma1s[] = {3, 1, 0, -1};
+	static const int possible_dma2s[][2] = { {1, -1}, {0, -1}, {-1, -1},
 					   {0, -1} };
 
 	int error;
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 697576459f71..d06b29693c85 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -163,7 +163,7 @@ MODULE_DEVICE_TABLE(pnp_card, snd_opti9xx_pnpids);
 
 #define DEV_NAME KBUILD_MODNAME
 
-static char * snd_opti9xx_names[] = {
+static const char * const snd_opti9xx_names[] = {
 	"unknown",
 	"82C928",	"82C929",
 	"82C924",	"82C925",
@@ -173,7 +173,7 @@ static char * snd_opti9xx_names[] = {
 static int snd_opti9xx_init(struct snd_opti9xx *chip,
 			    unsigned short hardware)
 {
-	static int opti9xx_mc_size[] = {7, 7, 10, 10, 2, 2, 2};
+	static const int opti9xx_mc_size[] = {7, 7, 10, 10, 2, 2, 2};
 
 	chip->hardware = hardware;
 	strcpy(chip->name, snd_opti9xx_names[hardware]);
@@ -808,7 +808,7 @@ static void snd_card_opti9xx_free(struct snd_card *card)
 
 static int snd_opti9xx_probe(struct snd_card *card)
 {
-	static long possible_ports[] = {0x530, 0xe80, 0xf40, 0x604, -1};
+	static const long possible_ports[] = {0x530, 0xe80, 0xf40, 0x604, -1};
 	int error;
 	int xdma2;
 	struct snd_opti9xx *chip = card->private_data;
@@ -958,16 +958,16 @@ static int snd_opti9xx_isa_probe(struct device *devptr,
 {
 	struct snd_card *card;
 	int error;
-	static long possible_mpu_ports[] = {0x300, 0x310, 0x320, 0x330, -1};
+	static const long possible_mpu_ports[] = {0x300, 0x310, 0x320, 0x330, -1};
 #ifdef OPTi93X
-	static int possible_irqs[] = {5, 9, 10, 11, 7, -1};
+	static const int possible_irqs[] = {5, 9, 10, 11, 7, -1};
 #else
-	static int possible_irqs[] = {9, 10, 11, 7, -1};
+	static const int possible_irqs[] = {9, 10, 11, 7, -1};
 #endif	/* OPTi93X */
-	static int possible_mpu_irqs[] = {5, 9, 10, 7, -1};
-	static int possible_dma1s[] = {3, 1, 0, -1};
+	static const int possible_mpu_irqs[] = {5, 9, 10, 7, -1};
+	static const int possible_dma1s[] = {3, 1, 0, -1};
 #if defined(CS4231) || defined(OPTi93X)
-	static int possible_dma2s[][2] = {{1,-1}, {0,-1}, {-1,-1}, {0,-1}};
+	static const int possible_dma2s[][2] = {{1,-1}, {0,-1}, {-1,-1}, {0,-1}};
 #endif	/* CS4231 || OPTi93X */
 
 	if (mpu_port == SNDRV_AUTO_PORT) {
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
