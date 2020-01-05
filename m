Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C631DC33C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 15:09:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE452085B
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 15:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jurTEIjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE452085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 974F117EA;
	Sun,  5 Jan 2020 16:08:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 974F117EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578236962;
	bh=cIJHRBlD8bCr8cgwPG2JueetKLPdxy4CxWMIgTweim0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jurTEIjr0spSVk0hD+ywVkAH2th8Se92fosC+gbqBisaPc0REA+K3ZYCfrX+hsc+m
	 EjvM7kExyUtcWpu8sMPrFS8vBMCllxdYOSYAZmjnlba4aBj9XQafWAAi6wVLU7m8GG
	 9uW1XttE2lGBpG3+Xs4NNdRQLCrAvAcDwxJwnGdA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79BF3F80307;
	Sun,  5 Jan 2020 15:50:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C063FF80361; Sun,  5 Jan 2020 15:49:18 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BA91F80291
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BA91F80291
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 21167B275
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:33 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:47:45 +0100
Message-Id: <20200105144823.29547-31-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 30/68] ALSA: ca0106: More constifications
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

Apply const prefix to each possible place: the static tables for
registers and verbs, and the string arrays.

Just for minor optimization and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ca0106/ca0106_main.c  |  4 ++--
 sound/pci/ca0106/ca0106_mixer.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 487b1aaafa1e..70d775ff967e 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -1360,7 +1360,7 @@ static int snd_ca0106_pcm(struct snd_ca0106 *emu, int device)
 }
 
 #define SPI_REG(reg, value)	(((reg) << SPI_REG_SHIFT) | (value))
-static unsigned int spi_dac_init[] = {
+static const unsigned int spi_dac_init[] = {
 	SPI_REG(SPI_LDA1_REG,	SPI_DA_BIT_0dB), /* 0dB dig. attenuation */
 	SPI_REG(SPI_RDA1_REG,	SPI_DA_BIT_0dB),
 	SPI_REG(SPI_PL_REG,	SPI_PL_BIT_L_L | SPI_PL_BIT_R_R | SPI_IZD_BIT),
@@ -1378,7 +1378,7 @@ static unsigned int spi_dac_init[] = {
 	SPI_REG(SPI_DACD4_REG,	SPI_DACD4_BIT),
 };
 
-static unsigned int i2c_adc_init[][2] = {
+static const unsigned int i2c_adc_init[][2] = {
 	{ 0x17, 0x00 }, /* Reset */
 	{ 0x07, 0x00 }, /* Timeout */
 	{ 0x0b, 0x22 },  /* Interface control */
diff --git a/sound/pci/ca0106/ca0106_mixer.c b/sound/pci/ca0106/ca0106_mixer.c
index c771995b12b9..3b8ec673dc0a 100644
--- a/sound/pci/ca0106/ca0106_mixer.c
+++ b/sound/pci/ca0106/ca0106_mixer.c
@@ -739,7 +739,7 @@ static int rename_ctl(struct snd_card *card, const char *src, const char *dst)
 static
 DECLARE_TLV_DB_SCALE(snd_ca0106_master_db_scale, -6375, 25, 1);
 
-static char *slave_vols[] = {
+static const char * const slave_vols[] = {
 	"Analog Front Playback Volume",
         "Analog Rear Playback Volume",
 	"Analog Center/LFE Playback Volume",
@@ -752,7 +752,7 @@ static char *slave_vols[] = {
 	NULL
 };
 
-static char *slave_sws[] = {
+static const char * const slave_sws[] = {
 	"Analog Front Playback Switch",
 	"Analog Rear Playback Switch",
 	"Analog Center/LFE Playback Switch",
@@ -762,7 +762,7 @@ static char *slave_sws[] = {
 };
 
 static void add_slaves(struct snd_card *card,
-				 struct snd_kcontrol *master, char **list)
+		       struct snd_kcontrol *master, const char * const *list)
 {
 	for (; *list; list++) {
 		struct snd_kcontrol *slave = ctl_find(card, *list);
@@ -775,9 +775,9 @@ int snd_ca0106_mixer(struct snd_ca0106 *emu)
 {
 	int err;
         struct snd_card *card = emu->card;
-	char **c;
+	const char * const *c;
 	struct snd_kcontrol *vmaster;
-	static char *ca0106_remove_ctls[] = {
+	static const char * const ca0106_remove_ctls[] = {
 		"Master Mono Playback Switch",
 		"Master Mono Playback Volume",
 		"3D Control - Switch",
@@ -801,7 +801,7 @@ int snd_ca0106_mixer(struct snd_ca0106 *emu)
 		"Surround Phase Inversion Playback Switch",
 		NULL
 	};
-	static char *ca0106_rename_ctls[] = {
+	static const char * const ca0106_rename_ctls[] = {
 		"Master Playback Switch", "Capture Switch",
 		"Master Playback Volume", "Capture Volume",
 		"Line Playback Switch", "AC97 Line Capture Switch",
@@ -875,7 +875,7 @@ struct ca0106_vol_tbl {
 	unsigned int reg;
 };
 
-static struct ca0106_vol_tbl saved_volumes[NUM_SAVED_VOLUMES] = {
+static const struct ca0106_vol_tbl saved_volumes[NUM_SAVED_VOLUMES] = {
 	{ CONTROL_FRONT_CHANNEL, PLAYBACK_VOLUME2 },
 	{ CONTROL_REAR_CHANNEL, PLAYBACK_VOLUME2 },
 	{ CONTROL_CENTER_LFE_CHANNEL, PLAYBACK_VOLUME2 },
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
