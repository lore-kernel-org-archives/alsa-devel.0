Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBF2C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Apr 2022 20:20:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCA7716D9;
	Mon, 11 Apr 2022 22:19:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCA7716D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649708441;
	bh=rFwcUSwf8rO8Y817ZYM1DZyth1S4HDFgJ4ZJ/Y9mZVQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kl7akEVDh5Ui4nXnBqE/xOfeitNJWCZAYlfuUfT8BnGdPtGT3gL+LccoI20zwa7q7
	 CAJBgW18trNMqrcXYry9Ql2aeKaWmsIj6J4F33W+RVVGMvEnZBD64ipwf6i6uspdWV
	 vfKjPE0pqudB53/Q/IU1vvP43D375S6cegNP7/N0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A610F80511;
	Mon, 11 Apr 2022 22:18:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5D8BF80536; Mon, 11 Apr 2022 22:18:10 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B217FF804E7
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2022 22:17:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B217FF804E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="OniSTYbg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649708279; x=1681244279;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rFwcUSwf8rO8Y817ZYM1DZyth1S4HDFgJ4ZJ/Y9mZVQ=;
 b=OniSTYbgDchAb3fzvg8OchcE5CYTkmGWybNoEE3Y2RJAL2pSz6LY3tUf
 vIOpMsRfLwizg7oIsX6bzcv/R9lSxbsVCUsjbzqdugF5k+L8suown6CdP
 T+M2cZNp+fbJTLpiISnssqULWTm7Ccb3QAZONydN2Ew/Q3C7ZKLajEN5Z
 Jl7GNe575Q2fycJxQWnAsjxpUBL2ivlrUUIsXI2DDY8ctwYZSeTaju13b
 h1X95IYKRkxjoP8H0+Qb7HI0cjaYJMl/c8zlV43OH9sKJeRer/rtqKKRv
 mCyUPeoDNEEb6dkCnrjiThm8dnwLQ/NBf9toNr6OkbaBteTEMhyKkZP3o w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244090834"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="244090834"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 13:17:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="526135662"
Received: from prposam-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.162.151])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 13:17:52 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/16] ASoC: SOF: sof-pci-dev: add parameter to override
 firmware filename
Date: Mon, 11 Apr 2022 15:17:16 -0500
Message-Id: <20220411201727.77971-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411201727.77971-1-pierre-louis.bossart@linux.intel.com>
References: <20220411201727.77971-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 Paul Olaru <paul.olaru@oss.nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
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

The existing 'fw_path' module parameter can be used to load alternate
firmware files, be it for development or to handle OEM-specific or
board-specific releases. The firmware name is however non-modifiable
and defined by platform-specific descriptors.

For additional flexibility during development or enable quirks, this
patch adds the 'fw_filename' module parameter to override default
firmware names.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/sof-pci-dev.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 470c0ac4a4e0..15fffcdf6907 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -23,6 +23,10 @@ static char *fw_path;
 module_param(fw_path, charp, 0444);
 MODULE_PARM_DESC(fw_path, "alternate path for SOF firmware.");
 
+static char *fw_filename;
+module_param(fw_filename, charp, 0444);
+MODULE_PARM_DESC(fw_filename, "alternate filename for SOF firmware.");
+
 static char *tplg_path;
 module_param(tplg_path, charp, 0444);
 MODULE_PARM_DESC(tplg_path, "alternate path for SOF topology.");
@@ -175,7 +179,15 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	sof_pdata->dev = dev;
 
 	sof_pdata->ipc_type = desc->ipc_default;
-	sof_pdata->fw_filename = desc->default_fw_filename[sof_pdata->ipc_type];
+
+	if (fw_filename) {
+		sof_pdata->fw_filename = fw_filename;
+
+		dev_dbg(dev, "Module parameter used, changed fw filename to %s\n",
+			sof_pdata->fw_filename);
+	} else {
+		sof_pdata->fw_filename = desc->default_fw_filename[sof_pdata->ipc_type];
+	}
 
 	/*
 	 * for platforms using the SOF community key, change the
-- 
2.30.2

