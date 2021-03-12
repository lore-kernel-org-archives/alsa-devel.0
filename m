Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D2C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:04:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A626864F43
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 18:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A626864F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32DA31707;
	Fri, 12 Mar 2021 19:03:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32DA31707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615572280;
	bh=KPw1p2Df5ULTir8YpcDNyO2I6BZIlzSxIXh3Hnuyu1Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qO48OccV03xR5duMCoTBRT4Ha1rQb4OjCxtoTB2rN6xEtEh5anS4pneLAwtSJLzfZ
	 1lsocVL4LgJnlgp5WeLO9VNUd8FQIy4iJV6J82XpThH+lduaGSITzqQXTuYxic6oyq
	 How7/drT+GAjMyoRQYNCP0s2TjApTxq5k82hqCIM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CD4EF802E0;
	Fri, 12 Mar 2021 19:03:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5065F802E7; Fri, 12 Mar 2021 19:03:05 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35D88F800BF
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 19:02:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35D88F800BF
IronPort-SDR: oOQYkDIEbXfHMzNVp9By/pw2WwM9CW3Occ/L4yZqKIuTtZxLLFEhJneqcjojICHtmOMBly6K9G
 6+FYhLQ3bjJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="176459534"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="176459534"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:02:41 -0800
IronPort-SDR: wFpCV7UH3NzPfKfGD0tdBnfMjuNak1xdyMYqiETvXjM/QLWDS/doJJjpNdqtikabg2cltuGTGZ
 eNkeRgvb2SuA==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; d="scan'208";a="432013369"
Received: from amiteshs-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.37.30])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2021 10:02:40 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v4 2/2] ASoC: samsung: tm2_wm5110: remove shadowed variable
Date: Fri, 12 Mar 2021 12:02:31 -0600
Message-Id: <20210312180231.2741-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312180231.2741-1-pierre-louis.bossart@linux.intel.com>
References: <20210312180231.2741-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
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

sound/soc/samsung/tm2_wm5110.c:552:26: style: Local variable 'args'
shadows outer variable [shadowVariable]
  struct of_phandle_args args;
                         ^
sound/soc/samsung/tm2_wm5110.c:504:25: note: Shadowed declaration
 struct of_phandle_args args;
                        ^
sound/soc/samsung/tm2_wm5110.c:552:26: note: Shadow variable
  struct of_phandle_args args;
                         ^
Move the top-level variable to the lower scope where it's needed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/samsung/tm2_wm5110.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index 125e07f65d2b..84c2c63d5a87 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -501,7 +501,6 @@ static int tm2_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card = &tm2_card;
 	struct tm2_machine_priv *priv;
-	struct of_phandle_args args;
 	struct snd_soc_dai_link *dai_link;
 	int num_codecs, ret, i;
 
@@ -585,6 +584,8 @@ static int tm2_probe(struct platform_device *pdev)
 	}
 
 	if (num_codecs > 1) {
+		struct of_phandle_args args;
+
 		/* HDMI DAI link (I2S1) */
 		i = card->num_links - 1;
 
-- 
2.25.1

