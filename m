Return-Path: <SRS0=Rqaf=N7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B2AC433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 11:57:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B04363229
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 11:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B04363229
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BCB116CC;
	Thu,  9 Sep 2021 13:56:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BCB116CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631188640;
	bh=KyrPSSFkkaFfgTa331w9So5Bp9nfhgXOj9h8Ox5YpWU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=exeEf1SbdR9JBQVZWcp4YI5nFPorHzLubil/7ptBp64B0rU3FEE6CDBh9mRfXxA72
	 3l1aRTM/0KElr1sIzxuXspSzP1aJzmKfHr6yPOytBb/5TlJu5bCAIfx59smtRurcfC
	 jI+KMRl1cjsrrICpcM0xffTKaRTIysIez02AgFwA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C4A31F80515;
	Thu,  9 Sep 2021 13:54:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8616AF80507; Thu,  9 Sep 2021 13:54:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F04C3F80166
 for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2021 13:54:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F04C3F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="b/J+l6KN"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEBA761B93;
 Thu,  9 Sep 2021 11:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631188463;
 bh=KyrPSSFkkaFfgTa331w9So5Bp9nfhgXOj9h8Ox5YpWU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b/J+l6KNK2rQiTtWk4cnciSa7ifdcJZiMt+Hmk2A5e4Tp3iij+M9Vmbqsn1Qg+IHi
 uk5qFg5C3ljSsH2OwMBFtFrYXLNOsmStCN+du0Wt9d/z7GhvrnPzx06PSWiBIYdbMm
 hzIY7YpSAX8dtwHA4GgpJHqY7FZLHqJ3PyWa926USwhuvIk8P9Eo91OKnfZjrPdDHS
 YG6hddImAFcgEpn12PxLc3CGPC3Sjvff4+88YQudIWQYUbiYm0tU2HsD4O6nHGzv9L
 wLUpM/SXL34oQXfLnJZoWJj4AGRN1NmtT95yOsfs4saBlO9tza35tEgCjBzrFR4VVn
 iiVxrA2ezbpSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 143/176] ASoC: Intel: Skylake: Fix module
 configuration for KPB and MIXER
Date: Thu,  9 Sep 2021 07:50:45 -0400
Message-Id: <20210909115118.146181-143-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909115118.146181-1-sashal@kernel.org>
References: <20210909115118.146181-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org, Lukasz Majczak <lma@semihalf.com>
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

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit e4e0633bcadc950b4b4af06c7f1bb7f7e3e86321 ]

KeyPhrasebuffer, Mixin and Mixout modules configuration is described by
firmware's basic module configuration structure. There are no extended
parameters required. Update functions taking part in building
INIT_INSTANCE IPC payload to reflect that.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Tested-by: Lukasz Majczak <lma@semihalf.com>
Link: https://lore.kernel.org/r/20210818075742.1515155-6-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 476ef1897961..79c6cf2c14bf 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -802,9 +802,12 @@ static u16 skl_get_module_param_size(struct skl_dev *skl,
 
 	case SKL_MODULE_TYPE_BASE_OUTFMT:
 	case SKL_MODULE_TYPE_MIC_SELECT:
-	case SKL_MODULE_TYPE_KPB:
 		return sizeof(struct skl_base_outfmt_cfg);
 
+	case SKL_MODULE_TYPE_MIXER:
+	case SKL_MODULE_TYPE_KPB:
+		return sizeof(struct skl_base_cfg);
+
 	default:
 		/*
 		 * return only base cfg when no specific module type is
@@ -857,10 +860,14 @@ static int skl_set_module_format(struct skl_dev *skl,
 
 	case SKL_MODULE_TYPE_BASE_OUTFMT:
 	case SKL_MODULE_TYPE_MIC_SELECT:
-	case SKL_MODULE_TYPE_KPB:
 		skl_set_base_outfmt_format(skl, module_config, *param_data);
 		break;
 
+	case SKL_MODULE_TYPE_MIXER:
+	case SKL_MODULE_TYPE_KPB:
+		skl_set_base_module_format(skl, module_config, *param_data);
+		break;
+
 	default:
 		skl_set_base_module_format(skl, module_config, *param_data);
 		break;
-- 
2.30.2

