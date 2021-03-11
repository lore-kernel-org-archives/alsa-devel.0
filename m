Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED231C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 00:46:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E7364FC1
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 00:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E7364FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8587B170D;
	Thu, 11 Mar 2021 01:45:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8587B170D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615423585;
	bh=e9qX5sv1T9BGj+Ak0VcazTK16TY86x2xSs20XMQaB0w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ULOVnvcQxjveRi+2hhT6fAi5aph8+62T2ZFVPqZlpFIJ83qCSBmf8wpnhqVwWQNkY
	 GewVKUlass50TVHNhHrPeFfmq0aWLhg1/Nn9yAR/NQ7JiE/mM45YW7Z+ar355qZV6S
	 HY4V7/W5f3AiSVA3METpDG0LSif7GtioiocZIuz8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0090F8032B;
	Thu, 11 Mar 2021 01:44:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49DBAF80430; Thu, 11 Mar 2021 01:44:02 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49ED3F801D8
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 01:43:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49ED3F801D8
IronPort-SDR: R/Lte7mK3DJ8awzKzVRzFoxmfu8Xli2t/Q9rwWJSVod5UprlRlNAkbVwTqNJibV9zHjJVUCG2Z
 7iDkSQJj+QNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="176185736"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; d="scan'208";a="176185736"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 16:43:42 -0800
IronPort-SDR: jcryvle+k/XXX4a7+c+f8li3K8Tyv+0YkMXXRL71dIuFNLJa7u3ULdo3LR+mfIBJVln8EPhSzs
 lkoxvTd1h1nA==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; d="scan'208";a="370385612"
Received: from theer-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.101.109])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 16:43:41 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 02/10] ASoC: madera: align function prototype
Date: Wed, 10 Mar 2021 18:43:24 -0600
Message-Id: <20210311004332.120901-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311004332.120901-1-pierre-louis.bossart@linux.intel.com>
References: <20210311004332.120901-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, patches@opensource.cirrus.com, broonie@kernel.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
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

cppcheck warning:

sound/soc/codecs/madera.c:3372:51: style:inconclusive: Function
'madera_init_dai' argument 2 names different: declaration 'dai'
definition 'id'. [funcArgNamesDifferent]
int madera_init_dai(struct madera_priv *priv, int id)
                                                  ^
sound/soc/codecs/madera.h:433:51: note: Function 'madera_init_dai'
argument 2 names different: declaration 'dai' definition 'id'.
int madera_init_dai(struct madera_priv *priv, int dai);
                                                  ^
sound/soc/codecs/madera.c:3372:51: note: Function 'madera_init_dai'
argument 2 names different: declaration 'dai' definition 'id'.
int madera_init_dai(struct madera_priv *priv, int id)
                                                  ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/madera.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/madera.h b/sound/soc/codecs/madera.h
index e0c0be59e2ef..09ad6e9bce4b 100644
--- a/sound/soc/codecs/madera.h
+++ b/sound/soc/codecs/madera.h
@@ -430,7 +430,7 @@ int madera_init_bus_error_irq(struct madera_priv *priv, int dsp_num,
 			      irq_handler_t handler);
 void madera_free_bus_error_irq(struct madera_priv *priv, int dsp_num);
 
-int madera_init_dai(struct madera_priv *priv, int dai);
+int madera_init_dai(struct madera_priv *priv, int id);
 
 int madera_set_output_mode(struct snd_soc_component *component, int output,
 			   bool differential);
-- 
2.25.1

