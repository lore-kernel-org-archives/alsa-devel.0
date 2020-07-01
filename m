Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369B8C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:40:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81B42085B
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j3mle5fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81B42085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 572351692;
	Wed,  1 Jul 2020 20:39:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 572351692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593628803;
	bh=RkFQo9n+Yiuv0wMEWX4rfSVldhgSLCuNltGHGSan6qg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j3mle5fzSAEdtaYtUqDXQMXZwZi5CbXkQROsNDXTL59u0ZR1yOjm+fMbQtM0r1zKo
	 5IgtddQTnkSrZvTBDuvucUiLB+BuqSsRjA4jl8LM7NA9BAdkqMIWsi9id7atNDK67a
	 SJ2kTUAw3QqhfMlcAu9438WKkjHs9G4PWMX2PejM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00716F80269;
	Wed,  1 Jul 2020 20:37:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E4C2F80229; Wed,  1 Jul 2020 20:37:34 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E36DBF8020C
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 20:37:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E36DBF8020C
IronPort-SDR: 6weAt5oW1Azi8ypbxjImABTekrVcA94dY59Y4KhZZw7P0t61KXtTY+nMkCxBFgA58JqIb5M5zL
 5eGbLX6x8Qmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="208193422"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="208193422"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:37:25 -0700
IronPort-SDR: lhYy60QrIXJUQlziH/LHNUy2J3R3uueGmWc/CxPLqFjow9FThSgGFLsppxpbglxr9GUIya9cl6
 6dLVQP1F4ddg==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; d="scan'208";a="481692835"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:37:24 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: Intel: atom: fix 'defined but not used' warning
Date: Wed,  1 Jul 2020 13:37:16 -0500
Message-Id: <20200701183716.83314-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701183716.83314-1-pierre-louis.bossart@linux.intel.com>
References: <20200701183716.83314-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

Fix W=1 warning. The VOIP controls were not used in the mainline but
in special versions of Android. Keep and use __maybe_used to make
warning go away.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index ca963383ac5e..ff42f629b035 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -723,7 +723,7 @@ SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_pcm2_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_sprot_l0_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l1_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l2_controls);
-SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_voip_controls);
+SST_SBA_DECLARE_MIX_CONTROLS(__maybe_unused sst_mix_voip_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec0_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec1_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_modem_controls);
-- 
2.25.1

