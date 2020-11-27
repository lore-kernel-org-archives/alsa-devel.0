Return-Path: <SRS0=aYR+=FB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19D6C3E8C5
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 16:45:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DB2206D8
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Nov 2020 16:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GjU0PR61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DB2206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EEB99186A;
	Fri, 27 Nov 2020 17:44:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EEB99186A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606495529;
	bh=u9ZjlnkqKT3UHITb2SCKm7K5gywJ32vECXPLti9hjXE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GjU0PR61G+pd0k/hOKbgqcI32QVjDmgw3IN3pbCRvguOkMNyalhuXqRG3pYl8AUEC
	 c0q643+1OclkHeRV6bW+A8OoMMKlKOBwsO0a0TeC5VXeJQYd+iCMowEw+KwGT9GJdz
	 Lk6FjhL8t7E1I9ewbdmA107bnUwwBAwXj2ye1Fi4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D12E7F804C3;
	Fri, 27 Nov 2020 17:43:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A4A4F804BC; Fri, 27 Nov 2020 17:43:06 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66A4FF800E0
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2020 17:42:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66A4FF800E0
IronPort-SDR: feiC79HHGHDW/4g0uB/Be0XRsXT6bIGvJScCmCD+ebjH33st6TqQRv8QoTivmLl6aS2WoPblyw
 EQCHd3Xkkbeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9818"; a="234020284"
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; d="scan'208";a="234020284"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2020 08:42:58 -0800
IronPort-SDR: e7CgmP1uKkUNQxiK/vZHApVC9+tVFotgl8iE6Inphhl0DI5CeTrtH61s5HqMWRBNg+3y2KZjo3
 Y2zqJwrPX+1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; d="scan'208";a="403933353"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga001.jf.intel.com with ESMTP; 27 Nov 2020 08:42:56 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 3/5] ASoC: SOF: ext_manifest: parse cavs extra config data elem
Date: Fri, 27 Nov 2020 18:40:20 +0200
Message-Id: <20201127164022.2498406-4-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201127164022.2498406-1-kai.vehmanen@linux.intel.com>
References: <20201127164022.2498406-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, Fred Oh <fred.oh@linux.intel.com>,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

From: Fred Oh <fred.oh@linux.intel.com>

OUTBOX_SIZE, INBOX_SIZE are defined but not being used yet. Handle
these elements to avoid warning about unknown token type.

Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/ext_manifest.h | 2 ++
 sound/soc/sof/intel/hda-loader.c   | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/ext_manifest.h b/sound/soc/sof/intel/ext_manifest.h
index a30e25b4e655..2dfae9285d3c 100644
--- a/sound/soc/sof/intel/ext_manifest.h
+++ b/sound/soc/sof/intel/ext_manifest.h
@@ -21,6 +21,8 @@
 enum sof_cavs_config_elem_type {
 	SOF_EXT_MAN_CAVS_CONFIG_EMPTY		= 0,
 	SOF_EXT_MAN_CAVS_CONFIG_CAVS_LPRO	= 1,
+	SOF_EXT_MAN_CAVS_CONFIG_OUTBOX_SIZE	= 2,
+	SOF_EXT_MAN_CAVS_CONFIG_INBOX_SIZE	= 3,
 };
 
 /* EXT_MAN_ELEM_PLATFORM_CONFIG_DATA elements */
diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 73806223abd1..52101b1a3dac 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -498,8 +498,12 @@ int hda_dsp_ext_man_get_cavs_config_data(struct snd_sof_dev *sdev,
 			dev_dbg(sdev->dev, "FW clock config: %s\n",
 				hda->clk_config_lpro ? "LPRO" : "HPRO");
 			break;
+		case SOF_EXT_MAN_CAVS_CONFIG_OUTBOX_SIZE:
+		case SOF_EXT_MAN_CAVS_CONFIG_INBOX_SIZE:
+			/* These elements are defined but not being used yet. No warn is required */
+			break;
 		default:
-			dev_warn(sdev->dev, "unsupported token type: %d\n",
+			dev_info(sdev->dev, "unsupported token type: %d\n",
 				 config_data->elems[i].token);
 		}
 
-- 
2.28.0

