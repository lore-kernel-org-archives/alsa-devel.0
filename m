Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709A8C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:03:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DC161A36
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DC161A36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F32D5165E;
	Fri, 26 Mar 2021 23:02:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F32D5165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616796193;
	bh=Vme5TjBQX2HGtHpObReRIZE1eJmymvbuiH+7InkyrXE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uU2wMRoozuTIET0iQVxdWOowdDftV/h2mD01ofvW67LIJK/JWeYX1wm/WI+BetoK6
	 kyLRwv98dt5mA82b1ziiAcS720cayLrGHouUsgIJynzwDO8u5z+8PlBtQ/AVaCcqGy
	 3Sxe2DumqiOiWpzkv/6LvDMGVkfGEQbJtj6KDHJw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2ACA2F804AB;
	Fri, 26 Mar 2021 23:00:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67707F80431; Fri, 26 Mar 2021 23:00:13 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83C57F8016B
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 23:00:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83C57F8016B
IronPort-SDR: GUZyq95vP2FTIZGwh4FOE+pDsvxGJ9CaMAwkLgt7vPieAle8pPiWVGHPGK6/rzrMo/u/TPcO99
 7tWQp9LsaLGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211396700"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="211396700"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 14:59:59 -0700
IronPort-SDR: LJdCYQN16RvUYsE4gJWf4ZNI9EGbp1jH90sWQAEot3oGg+y9m+5BtO26kjAZpyORhn661R/J7i
 OQeje9hHsxsQ==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="416706691"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.255.231.203])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 14:59:58 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 04/17] ASoC: bcm: cygnus_ssp: remove useless initialization
Date: Fri, 26 Mar 2021 16:59:14 -0500
Message-Id: <20210326215927.936377-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Scott Branden <sbranden@broadcom.com>, tiwai@suse.de,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org,
 "maintainer:BROADCOM IPROC ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Ray Jui <rjui@broadcom.com>,
 "moderated list:BROADCOM IPROC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

Cppcheck warning:

sound/soc/bcm/cygnus-ssp.c:1364:6: style: Redundant initialization for
'err'. The initialized value is overwritten before it is
read. [redundantInitialization]
 err = devm_snd_soc_register_component(dev, &cygnus_ssp_component,
     ^
sound/soc/bcm/cygnus-ssp.c:1313:10: note: err is initialized
 int err = -EINVAL;
         ^
sound/soc/bcm/cygnus-ssp.c:1364:6: note: err is overwritten
 err = devm_snd_soc_register_component(dev, &cygnus_ssp_component,
     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/bcm/cygnus-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 6e634b448293..fea296b41a43 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1310,7 +1310,7 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 	struct device_node *child_node;
 	struct resource *res;
 	struct cygnus_audio *cygaud;
-	int err = -EINVAL;
+	int err;
 	int node_count;
 	int active_port_count;
 
-- 
2.25.1

