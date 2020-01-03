Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC3BC00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:21:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC042206DB
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="X7mXlyqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC042206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13F0B170E;
	Fri,  3 Jan 2020 09:21:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13F0B170E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578039715;
	bh=0sJ9CaJrHQkTIBVUpDCRDrnvBFhglUualiA5du+4neE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X7mXlyqDO3eYlybBelgwt1k2bCtsy6/YZccMSdsOJuWG5JR1jdoxFCTAmJPsfZUb7
	 sjhjMmHvu1tl5C/VJaa0bbuYq6fXWctk/tyLKtO61Oa2FUvG6t8Pk025twUkG18Q+6
	 bKhrE5ehiV7bn8nAzd9bVcYAT0TQVyKSE250a8rU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56EC2F80323;
	Fri,  3 Jan 2020 09:17:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D309F80160; Fri,  3 Jan 2020 09:17:35 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF30FF8021D
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF30FF8021D
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D4832B21C
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:19 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:16:22 +0100
Message-Id: <20200103081714.9560-7-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 06/58] ALSA: i2c: Constify snd_device_ops
	definitions
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

Now we may declare const for snd_device_ops definitions, so let's do
it for optimization.

There should be no functional changes by this patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/i2c/i2c.c          | 2 +-
 sound/i2c/other/ak4113.c | 2 +-
 sound/i2c/other/ak4114.c | 2 +-
 sound/i2c/other/ak4117.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/i2c/i2c.c b/sound/i2c/i2c.c
index 37b3c6940cac..a684faa771ef 100644
--- a/sound/i2c/i2c.c
+++ b/sound/i2c/i2c.c
@@ -67,7 +67,7 @@ int snd_i2c_bus_create(struct snd_card *card, const char *name,
 {
 	struct snd_i2c_bus *bus;
 	int err;
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free =	snd_i2c_bus_dev_free,
 	};
 
diff --git a/sound/i2c/other/ak4113.c b/sound/i2c/other/ak4113.c
index 775f9a354a86..2700a8470388 100644
--- a/sound/i2c/other/ak4113.c
+++ b/sound/i2c/other/ak4113.c
@@ -60,7 +60,7 @@ int snd_ak4113_create(struct snd_card *card, ak4113_read_t *read,
 	struct ak4113 *chip;
 	int err;
 	unsigned char reg;
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free =     snd_ak4113_dev_free,
 	};
 
diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index 6611c7debf23..e7325af8af5b 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -71,7 +71,7 @@ int snd_ak4114_create(struct snd_card *card,
 	struct ak4114 *chip;
 	int err = 0;
 	unsigned char reg;
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free =     snd_ak4114_dev_free,
 	};
 
diff --git a/sound/i2c/other/ak4117.c b/sound/i2c/other/ak4117.c
index 381949c8f15f..0d9e8252cc27 100644
--- a/sound/i2c/other/ak4117.c
+++ b/sound/i2c/other/ak4117.c
@@ -64,7 +64,7 @@ int snd_ak4117_create(struct snd_card *card, ak4117_read_t *read, ak4117_write_t
 	struct ak4117 *chip;
 	int err = 0;
 	unsigned char reg;
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free =     snd_ak4117_dev_free,
 	};
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
