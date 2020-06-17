Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF1AC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:59:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387CE2098B
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VORpOjIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387CE2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C23361681;
	Wed, 17 Jun 2020 18:58:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C23361681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592413143;
	bh=2MUHHgj5lg4dHOYdi7xtrZsMXHrE80J5wG5NvBy4QcM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VORpOjIpf5D6VZHoKN+tH5Mi31+/LRDuo6exgSr4IIthh/pCjiIw+cPGg3XjE/PT6
	 h0MRtgscRK4DSZ01R63sNn4YQ95Chjw7KMD2vD1vyL+5NiUEKqajCc/Mt1PV26/5QP
	 tW7xIZiK8P+Ay4q16yl7LpWbtpXBeeLk2f8muMT0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 722DAF80171;
	Wed, 17 Jun 2020 18:56:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3737EF802A2; Wed, 17 Jun 2020 18:56:35 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C8C8F80171
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 18:56:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C8C8F80171
IronPort-SDR: ++YkECi1w89VigkupB6ZtKeydPIwpurFk0m6ObYyQeeUNOywN+5QJedxziIN4Agctx0p38h2jD
 9gKTzcHCPlpQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 09:56:24 -0700
IronPort-SDR: 9KY0wNj7jXevn16i6/2FxJRzrauWyXEavhwB5BpCAyMnyJcQlt5Ek9IqckkLpMvHeDiEB0aOMm
 Sh6Bo0KqdbJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; d="scan'208";a="277339142"
Received: from zdsmith-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.229.128])
 by orsmga006.jf.intel.com with ESMTP; 17 Jun 2020 09:56:22 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH RESEND 1/3] ASoC: Intel: byt*: simplify card names for SOF uses
Date: Wed, 17 Jun 2020 11:56:14 -0500
Message-Id: <20200617165616.18511-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200617165616.18511-1-pierre-louis.bossart@linux.intel.com>
References: <20200617165616.18511-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Blindly adding an sof- prefix to the card name is not user friendly
and causes UCM issues with a driver name truncated to 16 characters.

Simplify to use "sof-bytcht <codec_name>" pattern for all byt* machine
drivers. The sof- prefix is added by the core. A generic "SOF" driver
name is used, and UCMv2 will detect the configuration for this driver
by testing the card name.

Legacy uses are unmodified.

Suggested-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_cx2072x.c | 12 +++++++++++-
 sound/soc/intel/boards/bytcht_da7213.c  | 12 +++++++++++-
 sound/soc/intel/boards/bytcht_es8316.c  | 12 +++++++++++-
 sound/soc/intel/boards/bytcr_rt5640.c   | 12 +++++++++++-
 sound/soc/intel/boards/bytcr_rt5651.c   | 12 +++++++++++-
 5 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
index fad937610494..9cb42ba40c07 100644
--- a/sound/soc/intel/boards/bytcht_cx2072x.c
+++ b/sound/soc/intel/boards/bytcht_cx2072x.c
@@ -205,9 +205,19 @@ static struct snd_soc_dai_link byt_cht_cx2072x_dais[] = {
 	},
 };
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+/* use space before codec name to simplify card ID, and simplify driver name */
+#define CARD_NAME "bytcht cx2072x" /* card name will be 'sof-bytcht cx2072x' */
+#define DRIVER_NAME "SOF"
+#else
+#define CARD_NAME "bytcht-cx2072x"
+#define DRIVER_NAME NULL /* card name will be used for driver name */
+#endif
+
 /* SoC card */
 static struct snd_soc_card byt_cht_cx2072x_card = {
-	.name = "bytcht-cx2072x",
+	.name = CARD_NAME,
+	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = byt_cht_cx2072x_dais,
 	.num_links = ARRAY_SIZE(byt_cht_cx2072x_dais),
diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index f3791ff2bad1..17bb4ca34672 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -205,9 +205,19 @@ static struct snd_soc_dai_link dailink[] = {
 	},
 };
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+/* use space before codec name to simplify card ID, and simplify driver name */
+#define CARD_NAME "bytcht da7213" /* card name will be 'sof-bytcht da7213' */
+#define DRIVER_NAME "SOF"
+#else
+#define CARD_NAME "bytcht-da7213"
+#define DRIVER_NAME NULL /* card name will be used for driver name */
+#endif
+
 /* SoC card */
 static struct snd_soc_card bytcht_da7213_card = {
-	.name = "bytcht-da7213",
+	.name = CARD_NAME,
+	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = dailink,
 	.num_links = ARRAY_SIZE(dailink),
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 9e5fc9430628..98e47a5d3a65 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -407,8 +407,18 @@ static int byt_cht_es8316_resume(struct snd_soc_card *card)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+/* use space before codec name to simplify card ID, and simplify driver name */
+#define CARD_NAME "bytcht es8316" /* card name will be 'sof-bytcht es8316' */
+#define DRIVER_NAME "SOF"
+#else
+#define CARD_NAME "bytcht-es8316"
+#define DRIVER_NAME NULL /* card name will be used for driver name */
+#endif
+
 static struct snd_soc_card byt_cht_es8316_card = {
-	.name = "bytcht-es8316",
+	.name = CARD_NAME,
+	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = byt_cht_es8316_dais,
 	.num_links = ARRAY_SIZE(byt_cht_es8316_dais),
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 1fdb70b9e478..1851aea983c7 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1127,8 +1127,18 @@ static int byt_rt5640_resume(struct snd_soc_card *card)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+/* use space before codec name to simplify card ID, and simplify driver name */
+#define CARD_NAME "bytcht rt5640" /* card name will be 'sof-bytcht rt5640' */
+#define DRIVER_NAME "SOF"
+#else
+#define CARD_NAME "bytcr-rt5640"
+#define DRIVER_NAME NULL /* card name will be used for driver name */
+#endif
+
 static struct snd_soc_card byt_rt5640_card = {
-	.name = "bytcr-rt5640",
+	.name = CARD_NAME,
+	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = byt_rt5640_dais,
 	.num_links = ARRAY_SIZE(byt_rt5640_dais),
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 520e916e329c..3e5cd3a87c3d 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -827,8 +827,18 @@ static int byt_rt5651_resume(struct snd_soc_card *card)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+/* use space before codec name to simplify card ID, and simplify driver name */
+#define CARD_NAME "bytcht rt5651" /* card name will be 'sof-bytcht rt5651' */
+#define DRIVER_NAME "SOF"
+#else
+#define CARD_NAME "bytcr-rt5651"
+#define DRIVER_NAME NULL /* card name will be used for driver name */
+#endif
+
 static struct snd_soc_card byt_rt5651_card = {
-	.name = "bytcr-rt5651",
+	.name = CARD_NAME,
+	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = byt_rt5651_dais,
 	.num_links = ARRAY_SIZE(byt_rt5651_dais),
-- 
2.20.1

