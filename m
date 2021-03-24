Return-Path: <SRS0=3oXn=IW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C88C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 17:54:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4D361992
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 17:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4D361992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95E88167B;
	Wed, 24 Mar 2021 18:53:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95E88167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616608446;
	bh=mIT8WaLPNOkEiWdijyCEs+SgoOhTTVJODOjC5SnJJSE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jP+JmdgeQBrBJXcha1x5Tbvhh31SoMCySZY6XNvqONbq13+8M1NfRc9GaVpqnWA3y
	 95OvSJZ+vv7EeNWzKACWuWqpJ7FMNKz4otwBJ8Zu1LXmRWscXgJnF4RI/XUk+CTdVa
	 TUho20/rKYsYMatdh8K1QnAqLck7aiaz03AW7l04=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5472F802E3;
	Wed, 24 Mar 2021 18:52:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA721F80240; Wed, 24 Mar 2021 18:52:43 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E3E0F80156
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 18:52:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E3E0F80156
IronPort-SDR: Uw9nMuc/AwPa/vQKuOJycqwgocO2p3KvzyKSdXpXQjXSeoaGO/ZBsuKVCZeShJe4ZqsEVN+a+f
 pgOUtI3qD/Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="187452412"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="187452412"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 10:52:32 -0700
IronPort-SDR: eKEUiwJmWQpDTOGoTayxaSCtZg+MCbcFv6k9VfmQ1a2OoR6BpG9mSeyAvs9Juehrm+/+hFrJ5z
 H0o+jlXK5vww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="442344378"
Received: from snappy-s2600wt2r.iind.intel.com ([10.223.163.26])
 by fmsmga002.fm.intel.com with ESMTP; 24 Mar 2021 10:52:30 -0700
From: vamshi.krishna.gopal@intel.com
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ASoC: Intel: kbl: Add MST route change to kbl machine
 drivers
Date: Wed, 24 Mar 2021 23:21:59 +0530
Message-Id: <20210324175200.44922-2-vamshi.krishna.gopal@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324175200.44922-1-vamshi.krishna.gopal@intel.com>
References: <20210324175200.44922-1-vamshi.krishna.gopal@intel.com>
Cc: harshapriya.n@intel.com, broonie@kernel.org, sathya.prakash.m.r@intel.com,
 biernacki@google.com, vamshi.krishna.gopal@intel.com,
 pierre-louis.bossart@intel.com
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

From: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>

To support MST hdmi audio, modify the current routes to be based on port in da7219_max98357a machine.

Signed-off-by: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
---
 sound/soc/intel/boards/kbl_da7219_max98357a.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index dc3d897ad280..1d6b2855874d 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -91,7 +91,9 @@ static const struct snd_soc_dapm_widget kabylake_widgets[] = {
 	SND_SOC_DAPM_SPK("Spk", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
 	SND_SOC_DAPM_SPK("DP", NULL),
-	SND_SOC_DAPM_SPK("HDMI", NULL),
+	SND_SOC_DAPM_SPK("HDMI1", NULL),
+	SND_SOC_DAPM_SPK("HDMI2", NULL),
+	SND_SOC_DAPM_SPK("HDMI3", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
 			SND_SOC_DAPM_POST_PMD),
@@ -108,9 +110,6 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
 	{ "MIC", NULL, "Headset Mic" },
 	{ "DMic", NULL, "SoC DMIC" },
 
-	{ "HDMI", NULL, "hif5 Output" },
-	{ "DP", NULL, "hif6 Output" },
-
 	/* CODEC BE connections */
 	{ "HiFi Playback", NULL, "ssp0 Tx" },
 	{ "ssp0 Tx", NULL, "codec0_out" },
-- 
2.17.1

