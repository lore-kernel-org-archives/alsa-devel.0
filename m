Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415C2C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:58:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF7421527
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vtTujEoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF7421527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54ADB167A;
	Wed, 17 Jun 2020 18:57:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54ADB167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592413095;
	bh=yaKN6Z4nIivOPT94yvOMoJyqCyMQ6TrqJsZWhoPZztg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vtTujEoQoi0uPZMYgyj5UMYquYl+IlItJieSrg3HBU2fEs67u/qrTLv79WYj4FTvj
	 FR1cuDsYxzcqE9qSalxKQXh55xsVgnVxUl9q9Gh8Yz6tYVoVRmXIMiaf+FN06L+5L4
	 PyhElL2omDKao0P08SneaToZmPlcANnYUOIvNqIQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAB6BF80271;
	Wed, 17 Jun 2020 18:56:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB561F80271; Wed, 17 Jun 2020 18:56:32 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 685A3F800EF
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 18:56:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 685A3F800EF
IronPort-SDR: cvnBl0MFwKkWOB8ivrI82CUEXAXW8/LzDbNEcz21TCPcplcCNPPCQm5EpuNgEFnnWxZ+unSW7H
 2C7aqKJk8MjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 09:56:23 -0700
IronPort-SDR: +dtUVveQi7pzB9ReuenhpcJFmIAQMfQ+Qz7b8quI6/0R35yGsfhUFzYTKXM/h/TKpIpJaUvj0O
 q2hpcKu620TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; d="scan'208";a="277339145"
Received: from zdsmith-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.229.128])
 by orsmga006.jf.intel.com with ESMTP; 17 Jun 2020 09:56:22 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH RESEND 2/3] ASoC: Intel: cht*: simplify card names for SOF uses
Date: Wed, 17 Jun 2020 11:56:15 -0500
Message-Id: <20200617165616.18511-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200617165616.18511-1-pierre-louis.bossart@linux.intel.com>
References: <20200617165616.18511-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>
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

Simplify to use "sof-bytcht <codec_name>" pattern for all cht* machine
drivers. The sof- prefix is added by the core. A generic "SOF" driver
name is used, and UCMv2 will detect the configuration for this driver
by testing the card name.

Legacy uses are unmodified.

Suggested-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 12 +++++++++++-
 sound/soc/intel/boards/cht_bsw_nau8824.c     | 12 +++++++++++-
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 17 +++++++++++++++--
 sound/soc/intel/boards/cht_bsw_rt5672.c      | 12 +++++++++++-
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 767ac2ae03e2..3b0a8aad7ad5 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -382,9 +382,19 @@ static struct snd_soc_dai_link cht_dailink[] = {
 	},
 };
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+/* use space before codec name to simplify card ID, and simplify driver name */
+#define CARD_NAME "bytcht max98090" /* card name will be 'sof-bytcht max98090 */
+#define DRIVER_NAME "SOF"
+#else
+#define CARD_NAME "chtmax98090"
+#define DRIVER_NAME NULL /* card name will be used for driver name */
+#endif
+
 /* SoC card */
 static struct snd_soc_card snd_soc_card_cht = {
-	.name = "chtmax98090",
+	.name = CARD_NAME,
+	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = cht_dailink,
 	.num_links = ARRAY_SIZE(cht_dailink),
diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index 2f7c94d335c1..31e9c77ef3d3 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -231,9 +231,19 @@ static struct snd_soc_dai_link cht_dailink[] = {
 	},
 };
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+/* use space before codec name to simplify card ID, and simplify driver name */
+#define CARD_NAME "bytcht nau8824" /* card name will be 'sof-bytcht nau8824 */
+#define DRIVER_NAME "SOF"
+#else
+#define CARD_NAME "chtnau8824"
+#define DRIVER_NAME NULL /* card name will be used for driver name */
+#endif
+
 /* SoC card */
 static struct snd_soc_card snd_soc_card_cht = {
-	.name = "chtnau8824",
+	.name = CARD_NAME,
+	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = cht_dailink,
 	.num_links = ARRAY_SIZE(cht_dailink),
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 22de138ffa33..27379b75674c 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -479,9 +479,21 @@ static struct snd_soc_dai_link cht_dailink[] = {
 	},
 };
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+/* use space before codec name to simplify card ID, and simplify driver name */
+#define CARD_RT5645_NAME "bytcht rt5645" /* card name 'sof-bytcht rt5645' */
+#define CARD_RT5650_NAME "bytcht rt5650" /* card name 'sof-bytcht rt5650' */
+#define DRIVER_NAME "SOF"
+#else
+#define CARD_RT5645_NAME "chtrt5645"
+#define CARD_RT5650_NAME "chtrt5650"
+#define DRIVER_NAME NULL /* card name will be used for driver name */
+#endif
+
 /* SoC card */
 static struct snd_soc_card snd_soc_card_chtrt5645 = {
-	.name = "chtrt5645",
+	.name = CARD_RT5645_NAME,
+	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = cht_dailink,
 	.num_links = ARRAY_SIZE(cht_dailink),
@@ -494,7 +506,8 @@ static struct snd_soc_card snd_soc_card_chtrt5645 = {
 };
 
 static struct snd_soc_card snd_soc_card_chtrt5650 = {
-	.name = "chtrt5650",
+	.name = CARD_RT5650_NAME,
+	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = cht_dailink,
 	.num_links = ARRAY_SIZE(cht_dailink),
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 7a43c70a1378..73ef709bdb48 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -379,9 +379,19 @@ static int cht_resume_post(struct snd_soc_card *card)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+/* use space before codec name to simplify card ID, and simplify driver name */
+#define CARD_NAME "bytcht rt5672" /* card name will be 'sof-bytcht rt5672' */
+#define DRIVER_NAME "SOF"
+#else
+#define CARD_NAME "cht-bsw-rt5672"
+#define DRIVER_NAME NULL /* card name will be used for driver name */
+#endif
+
 /* SoC card */
 static struct snd_soc_card snd_soc_card_cht = {
-	.name = "cht-bsw-rt5672",
+	.name = CARD_NAME,
+	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = cht_dailink,
 	.num_links = ARRAY_SIZE(cht_dailink),
-- 
2.20.1

