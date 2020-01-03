Return-Path: <SRS0=XflM=2Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1F8C00523
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:24:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF734206DB
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jjVB4J3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF734206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46FD2171F;
	Fri,  3 Jan 2020 09:23:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46FD2171F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578039882;
	bh=WIDUAJnszKi34EuovTVUS7ZStC7bbR4XjwekplPhfpg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jjVB4J3d2CTBTBn6V3hVRVm00k7FxmtDtyrQCeP5hSqLiHe8LlqXmR0Xykb1Vff62
	 E8Y6eHrEcOON7RWbmTJeymLgzo79/Uqcthdx5Qp/4vF95iyj6eb2hm5PpZUzPUcCRB
	 6EiEOY8FQe1H6ICrwh9ly6d9wLyY8WcYVd93Op9Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28928F80341;
	Fri,  3 Jan 2020 09:18:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94DAFF80316; Fri,  3 Jan 2020 09:17:41 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57D49F80271
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 09:17:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57D49F80271
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E2EA0B21D
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2020 08:17:19 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  3 Jan 2020 09:16:23 +0100
Message-Id: <20200103081714.9560-8-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200103081714.9560-1-tiwai@suse.de>
References: <20200103081714.9560-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 07/58] ALSA: isa: Constify snd_device_ops
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
 sound/isa/ad1816a/ad1816a_lib.c | 2 +-
 sound/isa/es1688/es1688_lib.c   | 2 +-
 sound/isa/es18xx.c              | 2 +-
 sound/isa/gus/gus_main.c        | 2 +-
 sound/isa/msnd/msnd_pinnacle.c  | 2 +-
 sound/isa/sb/emu8000.c          | 2 +-
 sound/isa/sb/sb_common.c        | 2 +-
 sound/isa/wss/wss_lib.c         | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index da6f68b8c248..560885fbc983 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -577,7 +577,7 @@ int snd_ad1816a_create(struct snd_card *card,
 		       unsigned long port, int irq, int dma1, int dma2,
 		       struct snd_ad1816a *chip)
 {
-        static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free =	snd_ad1816a_dev_free,
 	};
 	int error;
diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index 632e867c5766..99a833f29544 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -612,7 +612,7 @@ int snd_es1688_create(struct snd_card *card,
 		      int dma8,
 		      unsigned short hardware)
 {
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free =	snd_es1688_dev_free,
 	};
                                 
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index a581083b876b..f9cd05d2b3bd 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1753,7 +1753,7 @@ static int snd_es18xx_new_device(struct snd_card *card,
 				 int irq, int dma1, int dma2)
 {
 	struct snd_es18xx *chip = card->private_data;
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free =	snd_es18xx_dev_free,
         };
 	int err;
diff --git a/sound/isa/gus/gus_main.c b/sound/isa/gus/gus_main.c
index 9f94b5f3b029..e9fc333c0fcb 100644
--- a/sound/isa/gus/gus_main.c
+++ b/sound/isa/gus/gus_main.c
@@ -134,7 +134,7 @@ int snd_gus_create(struct snd_card *card,
 {
 	struct snd_gus_card *gus;
 	int err;
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free =	snd_gus_dev_free,
 	};
 
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 9e7f03eec7e6..7fca418a64f8 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -528,7 +528,7 @@ static int snd_msnd_attach(struct snd_card *card)
 {
 	struct snd_msnd *chip = card->private_data;
 	int err;
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free =      snd_msnd_dev_free,
 		};
 
diff --git a/sound/isa/sb/emu8000.c b/sound/isa/sb/emu8000.c
index 433e32e254f9..bc47e8e51523 100644
--- a/sound/isa/sb/emu8000.c
+++ b/sound/isa/sb/emu8000.c
@@ -1075,7 +1075,7 @@ snd_emu8000_new(struct snd_card *card, int index, long port, int seq_ports,
 	struct snd_seq_device *awe;
 	struct snd_emu8000 *hw;
 	int err;
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free = snd_emu8000_dev_free,
 	};
 
diff --git a/sound/isa/sb/sb_common.c b/sound/isa/sb/sb_common.c
index 4aaf9ab82afe..61ea4078aa95 100644
--- a/sound/isa/sb/sb_common.c
+++ b/sound/isa/sb/sb_common.c
@@ -204,7 +204,7 @@ int snd_sbdsp_create(struct snd_card *card,
 {
 	struct snd_sb *chip;
 	int err;
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free =	snd_sbdsp_dev_free,
 	};
 
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 100e8b547d27..b51b50154e8a 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1772,7 +1772,7 @@ int snd_wss_create(struct snd_card *card,
 		      unsigned short hwshare,
 		      struct snd_wss **rchip)
 {
-	static struct snd_device_ops ops = {
+	static const struct snd_device_ops ops = {
 		.dev_free =	snd_wss_dev_free,
 	};
 	struct snd_wss *chip;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
