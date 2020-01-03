Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECAAC00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:20:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5668521835
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DHzchpvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5668521835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99172170A;
	Fri,  3 Jan 2020 09:19:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99172170A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578039604;
	bh=/4xc8kRZZVgV+XDVlEw/48BYKSKiF3lXsQwAQF9OESc=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DHzchpvOzrHV5p9/fc85GEpJwsUgz9eTfYuraT1EgD++mlGA3mfJW2Uc1hrMXsqkS
	 9PzamfUXuZ/oGTG4DzmWCKcI3NSZKnS9C2lm5tBTO7IbTCs0q2B2bWrzmp7OI+CrU/
	 GcmWHJK2hmLjg6PAOz1yId2Dcsb1rSslX5x+1R5Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE1F5F8015E;
	Fri,  3 Jan 2020 09:17:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CAF54F80315; Fri,  3 Jan 2020 09:17:33 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2DB9F80160
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2DB9F80160
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C7808B21A
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:19 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:16:21 +0100
Message-Id: <20200103081714.9560-6-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 05/58] ALSA: drivers: Constify snd_device_ops
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
 sound/drivers/ml403-ac97cr.c  | 2 +-
 sound/drivers/opl3/opl3_lib.c | 2 +-
 sound/drivers/opl4/opl4_lib.c | 2 +-
 sound/drivers/pcsp/pcsp.c     | 2 +-
 sound/drivers/serial-u16550.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index d1e01d89c722..2cec7c5bf8fd 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1076,7 +1076,7 @@ snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
 {
 	struct snd_ml403_ac97cr *ml403_ac97cr;
 	int err;
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free = snd_ml403_ac97cr_dev_free,
 	};
 	struct resource *resource;
diff --git a/sound/drivers/opl3/opl3_lib.c b/sound/drivers/opl3/opl3_lib.c
index cbdec28e89af..6134e5ffea0b 100644
--- a/sound/drivers/opl3/opl3_lib.c
+++ b/sound/drivers/opl3/opl3_lib.c
@@ -332,7 +332,7 @@ int snd_opl3_new(struct snd_card *card,
 		 unsigned short hardware,
 		 struct snd_opl3 **ropl3)
 {
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free = snd_opl3_dev_free,
 	};
 	struct snd_opl3 *opl3;
diff --git a/sound/drivers/opl4/opl4_lib.c b/sound/drivers/opl4/opl4_lib.c
index 901d339703a9..035645eb5e8d 100644
--- a/sound/drivers/opl4/opl4_lib.c
+++ b/sound/drivers/opl4/opl4_lib.c
@@ -184,7 +184,7 @@ int snd_opl4_create(struct snd_card *card,
 	struct snd_opl4 *opl4;
 	struct snd_opl3 *opl3;
 	int err;
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free = snd_opl4_dev_free
 	};
 
diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 14aacd8267d1..fd79e57c85ca 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -43,7 +43,7 @@ struct snd_pcsp pcsp_chip;
 
 static int snd_pcsp_create(struct snd_card *card)
 {
-	static struct snd_device_ops ops = { };
+	static const struct snd_device_ops ops = { };
 	unsigned int resolution = hrtimer_resolution;
 	int err, div, min_div, order;
 
diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index 4775f1b7b444..893c2b57331f 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -777,7 +777,7 @@ static int snd_uart16550_create(struct snd_card *card,
 				int droponfull,
 				struct snd_uart16550 **ruart)
 {
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free =	snd_uart16550_dev_free,
 	};
 	struct snd_uart16550 *uart;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
