Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F85C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:03:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6D96193C
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 22:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6D96193C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8FF5F1684;
	Fri, 26 Mar 2021 23:02:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8FF5F1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616796228;
	bh=9qDUwHPTBroQ8LNiEQzFb6UW4q04SWcs0SnBKY7uo74=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aLKAjDs5MfgbtZL93qhX6ek/Bd6/weVgMSoxtWZPgGyGSjKG4k+FKNupoFYKZMXHd
	 ccNuNrGw7rR0c8KzEl9fxsUVkRpNUnWk/LBIsJF1ayvAns6mHhvBaKIAXCXCnLBB8k
	 l4KSm/Yz+JCtHaWCjqgf1DVdz+grVRXuSA8fLgL8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6AF61F804B2;
	Fri, 26 Mar 2021 23:00:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2496F802E3; Fri, 26 Mar 2021 23:00:14 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61355F80156
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 23:00:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61355F80156
IronPort-SDR: dcLfLEdyGFbiLF54jsD9CA2cN57Xp/gaKUaNAzFEnDSIiEKnXxdz3QfqDfiKVBQfF+pdhdeSnl
 t7rY4gORptTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211396714"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="211396714"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:05 -0700
IronPort-SDR: LPvQQBUTZQoub2tgOnyV3oci46fvQuMKxLtmO0TNsF6EKwhztLoDFYJJu9ibZwwz2dP6h5WHcv
 LChziWVcD0ww==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="416706775"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.255.231.203])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 15:00:03 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 07/17] ASoC: pxa: remove useless assignment
Date: Fri, 26 Mar 2021 16:59:17 -0500
Message-Id: <20210326215927.936377-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org,
 "moderated list:PXA2xx/PXA3xx SUPPORT" <linux-arm-kernel@lists.infradead.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
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

sound/soc/pxa/mmp-pcm.c:207:10: style: Variable 'ret' is assigned a
value that is never used. [unreadVariable]
 int ret = 0, stream;
         ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/pxa/mmp-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 53fc49e32fbc..5d520e18e512 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -204,7 +204,7 @@ static int mmp_pcm_new(struct snd_soc_component *component,
 {
 	struct snd_pcm_substream *substream;
 	struct snd_pcm *pcm = rtd->pcm;
-	int ret = 0, stream;
+	int ret, stream;
 
 	for (stream = 0; stream < 2; stream++) {
 		substream = pcm->streams[stream].substream;
-- 
2.25.1

