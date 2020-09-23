Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF36C2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 08:10:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600A023899
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 08:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Bq8vbuUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600A023899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB6DB171C;
	Wed, 23 Sep 2020 10:09:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB6DB171C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600848629;
	bh=GU9Lb/LbbBYtmtefwnV6PFjvKULxF/WtEVyQHgqtsrI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bq8vbuUdcVvrl1y2wdZE20RSvs/KZicS5X/g+mR4luKKEWEVwFc1ZkUAYO6cV80E/
	 SoFiQsjCwDFkFOA5NzyGkO/L3PzFJ5ZhwGq7eP6XzvfGFxfenn9szbObx0WJJ+5GEN
	 o/RCP4qSwMvZGN1H5IKIq5d7CFNrABVFzTozNmYw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A48BF802EA;
	Wed, 23 Sep 2020 10:07:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B913F802E2; Wed, 23 Sep 2020 10:07:20 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9648F8021C
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 10:07:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9648F8021C
IronPort-SDR: quYP2uHrkXOfI+cpWr3MbQu1BCcyrUAkhBmd4zF7XWVemG+dxJzpsaQ+nDw9AsoCdWLg2d+xdG
 K5Y/bsybDIEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="158178515"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="158178515"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 01:07:12 -0700
IronPort-SDR: Q5tjekwsjXep/ZagCav4D3ZWMncN6f/m2k+d9xdAG10JxsnRVxWOGk8CgkxNW6UeFQBkrZLeAn
 rGrbbQVwINFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="335371254"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga004.fm.intel.com with ESMTP; 23 Sep 2020 01:07:10 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 5/6] ASoC: Intel: sof_sdw_rt700: add codec prefix
Date: Wed, 23 Sep 2020 11:05:13 +0300
Message-Id: <20200923080514.3242858-6-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200923080514.3242858-1-kai.vehmanen@linux.intel.com>
References: <20200923080514.3242858-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Somehow for this codec we never used any prefix for the controls,
likely because the test platform has a single SoundWire device.

Follow the convention and use the codec prefix across the board to
avoid possible conflicts.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw_rt700.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw_rt700.c b/sound/soc/intel/boards/sof_sdw_rt700.c
index bff69cfe27f4..21e7e4a81779 100644
--- a/sound/soc/intel/boards/sof_sdw_rt700.c
+++ b/sound/soc/intel/boards/sof_sdw_rt700.c
@@ -23,9 +23,9 @@ static const struct snd_soc_dapm_widget rt700_widgets[] = {
 
 static const struct snd_soc_dapm_route rt700_map[] = {
 	/* Headphones */
-	{ "Headphones", NULL, "HP" },
-	{ "Speaker", NULL, "SPK" },
-	{ "MIC2", NULL, "AMIC" },
+	{ "Headphones", NULL, "rt700 HP" },
+	{ "Speaker", NULL, "rt700 SPK" },
+	{ "rt700 MIC2", NULL, "AMIC" },
 };
 
 static const struct snd_kcontrol_new rt700_controls[] = {
-- 
2.27.0

