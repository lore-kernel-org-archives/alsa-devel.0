Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2E0C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 18:52:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB8C64DA5
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 18:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB8C64DA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7956E1660;
	Fri,  5 Feb 2021 19:51:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7956E1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612551126;
	bh=fCPEcINiGiC/Snp1RqGxxFOxQNAY78sFdgD+9NfKR1A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n93DkDuePD0CrKPMBYoa0IbNeFxUvk9XFv6fEhAyHSAuCWaaxbgpUzFzdWL1KRQv3
	 amP4BwLCp+yDbp2T6IrxCXLWp+2BFlOe0u3rP3MSD4pEovTuSuyjRTvIgEwclB01oj
	 ed9fMAi87trASsXsec+mGPlpjqSsAlwZtGrt/BNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 052C0F80290;
	Fri,  5 Feb 2021 19:50:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2BAAF80264; Fri,  5 Feb 2021 19:50:15 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7DF5F800C0
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 19:50:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7DF5F800C0
IronPort-SDR: CH3P79WG1W4K8T29ubUyZnmnXCOll938nUX/uq3P86dxjQlSlI7FmKbO5KQVMloTwEuTG8+q56
 DWm9P/loKqsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="178914216"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; d="scan'208";a="178914216"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 10:50:06 -0800
IronPort-SDR: vElIgUU+wll7Gu0Z7q/Oy3V+Pq02awTrzO83oUcycG6sHTeQyuhRXGALG57ugssYW8NdJ+2oyC
 ypts9UpWWh+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; d="scan'208";a="508632701"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga004.jf.intel.com with ESMTP; 05 Feb 2021 10:50:04 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH v2 2/3] ASoC: SOF: Intel: hda: use hdac_ext fine-grained link
 management
Date: Fri,  5 Feb 2021 20:46:29 +0200
Message-Id: <20210205184630.1938761-3-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205184630.1938761-1-kai.vehmanen@linux.intel.com>
References: <20210205184630.1938761-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

Opt-in to use snd_hdac_ext_bus_link_power() to manage HDA link
power up/down events.

This allows to reduce power consumption in cases where some HDA codecs
are suspended, but other child devices (HDA or non-HDA codecs) remain
active and controller itself remains in active state.

By using snd_hdac_ext_bus_link_power(), the individual HDA links can be
powered off and if all HDA codecs are powered down, the command DMA can
also be shut down.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda-bus.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-bus.c b/sound/soc/sof/intel/hda-bus.c
index 789148e5584b..1ac6e79d7e62 100644
--- a/sound/soc/sof/intel/hda-bus.c
+++ b/sound/soc/sof/intel/hda-bus.c
@@ -19,13 +19,21 @@
 #define sof_hda_ext_ops	NULL
 #endif
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+static const struct hdac_bus_ops bus_core_ops = {
+	.command = snd_hdac_bus_send_cmd,
+	.get_response = snd_hdac_bus_get_response,
+	.link_power = snd_hdac_ext_bus_link_power,
+};
+#endif
+
 /*
  * This can be used for both with/without hda link support.
  */
 void sof_hda_bus_init(struct hdac_bus *bus, struct device *dev)
 {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-	snd_hdac_ext_bus_init(bus, dev, NULL, sof_hda_ext_ops);
+	snd_hdac_ext_bus_init(bus, dev, &bus_core_ops, sof_hda_ext_ops);
 #else /* CONFIG_SND_SOC_SOF_HDA */
 	memset(bus, 0, sizeof(*bus));
 	bus->dev = dev;
-- 
2.29.2

