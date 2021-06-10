Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668FDC48BD1
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 20:55:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C753613E7
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 20:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C753613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34A0217C9;
	Thu, 10 Jun 2021 22:54:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34A0217C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623358546;
	bh=F+SMSgFPTSKQDWzxd/zxzfn28obJcdoXL0KoFMN0/3Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UmnvCdWkTTv1Ma0Gv0WF3GvWd2cSJmcI0zVYHlR/aidbFGKzI1GKDxVMB+lqg8cxW
	 UqguQClzVBPMg34YHgRjuzjEQecfvSuIjA4UPg5bv3coF6C3Z2SLxMND8MVHkVa0K0
	 CRZltX4FhNf++Nch6LU4CEgYZuxLaxo5rZHvp9DM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C113BF80149;
	Thu, 10 Jun 2021 22:54:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A063F804CA; Thu, 10 Jun 2021 22:54:07 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43515F80149
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 22:53:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43515F80149
IronPort-SDR: iulhtTfM0Z9yxbXhMUve14VNAUSlff3J4tsaGnQotpH4s12uerykVFLkvT2/GU81EI2Gadhbb0
 lVKJN7ZTcF1A==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="226812410"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; d="scan'208";a="226812410"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2021 13:53:49 -0700
IronPort-SDR: MJ2+famsyIhfVZjcvJPf5hU9YNds/tHTMqP2hFyM5cQpXXiARFxl3rDAk6k2c7ZwXffVurwdXj
 RqQsIdggbmVA==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; d="scan'208";a="620183620"
Received: from umedepal-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.213.170.65])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2021 13:53:48 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/8] ASoC: SOF: Intel: Kconfig: clarify DMI L1 option
 description
Date: Thu, 10 Jun 2021 15:53:19 -0500
Message-Id: <20210610205326.1176400-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610205326.1176400-1-pierre-louis.bossart@linux.intel.com>
References: <20210610205326.1176400-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

This option is only valid for HDaudio platforms. This was described in
the help but not explicit in the option description.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 4bce89b5ea40..d9108b12740e 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -250,7 +250,7 @@ config SND_SOC_SOF_HDA_PROBES
 	  If unsure, select "N".
 
 config SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1
-	bool "SOF enable DMI Link L1"
+	bool "SOF Intel-HDA enable DMI Link L1"
 	help
 	  This option enables DMI L1 for both playback and capture
 	  and disables known workarounds for specific HDAudio platforms.
-- 
2.25.1

