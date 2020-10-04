Return-Path: <SRS0=6kKU=DL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F258C4363C
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Oct 2020 09:07:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CE220735
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Oct 2020 09:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="neZTzd+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CE220735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19509184D;
	Sun,  4 Oct 2020 11:07:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19509184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601802473;
	bh=bNUqTQuEGygd7PvSr30zF9Xdc1H6v3/6sfYAZHwT2Dc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=neZTzd+4glKCYzNT+RZ2z+kDo1fbaA9ChBAbR9BQ+jZtrmjELOZkPdm9bDIQWYDWH
	 v3QQUk5dFFBlrbWLInUNOu9GYfd+ANLoSl3DoSPuzBw54T7QfSbsIsH9smqFVFwcN6
	 0zqXP5CnBZNdOTYyLbYIY8MqjPV3Pqrqncif0NFA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 030D9F801D8;
	Sun,  4 Oct 2020 11:07:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AAEBF80255; Sun,  4 Oct 2020 11:07:00 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64CFDF801D8
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2020 11:06:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64CFDF801D8
IronPort-SDR: VwrQkk0WqxCdKcv8Uo6typlfNmFqGyWvlCSvoukmJDjv2oMKYcclytINy6mDCiQirTs9sOTlpS
 qaS8NZZEgtSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9763"; a="151060522"
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; d="scan'208";a="151060522"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2020 02:06:41 -0700
IronPort-SDR: Pl/9OELguIPsuEb1D5bAv3Qmi/KaYc6qHHKwb7xgb9+ehm3vYhE70IlOErCpCyd60ioBuJah4V
 mN+B6wQJX17w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; d="scan'208";a="340518140"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2020 02:06:40 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/4] ASoC: Intel: bdw-rt5677: Mark FE DAIs as nonatomic
Date: Sun,  4 Oct 2020 11:06:07 +0200
Message-Id: <20201004090609.29066-2-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201004090609.29066-1-cezary.rojewski@intel.com>
References: <20201004090609.29066-1-cezary.rojewski@intel.com>
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>,
 broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
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

PCM operations for DAI links connected with DSP platform component
involve communication with DSP firmware by IPCs. As IPC protocol may
cause thread to sleep while waiting for a response from DSP, propagate
that information to ALSA core by marking all FE DAIs as nonatomic.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/boards/bdw-rt5677.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index d6584768883b..7a3e773d0a1c 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -323,6 +323,7 @@ static struct snd_soc_dai_link bdw_rt5677_dais[] = {
 	{
 		.name = "System PCM",
 		.stream_name = "System Playback/Capture",
+		.nonatomic = 1,
 		.dynamic = 1,
 		.trigger = {
 			SND_SOC_DPCM_TRIGGER_POST,
-- 
2.17.1

