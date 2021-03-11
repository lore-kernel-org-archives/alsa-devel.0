Return-Path: <SRS0=8+EQ=IJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B5CC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 00:52:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784B064FC1
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Mar 2021 00:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784B064FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00712172A;
	Thu, 11 Mar 2021 01:51:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00712172A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615423926;
	bh=hWOJS+dM7A1EuqUTqpCvEakwNn3+Da/uOx0yvNxXa8c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gIant7QClJZ+hLCuR9FczQqd7iv5Kbnw2u7eoppHnwzCEYKUuvmGhZy1KDQZnbDLj
	 gKbjYx9XWf7pPfoQF9UKxrKGOOJRHSnzf3mqjEHdkdODMh5nXg0KFvb5e1PIHAgN32
	 0Nao6O+sFNkE1CNNxoTAkQboce2lxoMNd0KL5gg0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32D97F804A9;
	Thu, 11 Mar 2021 01:49:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06635F8042F; Thu, 11 Mar 2021 01:49:36 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A4ECF8020D
 for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2021 01:49:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A4ECF8020D
IronPort-SDR: qaIKIcDh4PC+G+Xs/7VTK9WCaNQT5qA0N1pKN55aowLtHbHtOQP598G0d1C5OJbeoqN7OsR1oT
 VjE/sRdJKGRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="167865539"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; d="scan'208";a="167865539"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 16:49:22 -0800
IronPort-SDR: BhKoyhXtdGKV5O1zd6/K9C7KxhHwbj9vnaXtmqYZmIkYx82BA/1XRFhC/c5asRys56K22Q4GZQ
 wV2iI0dMK3Dw==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; d="scan'208";a="370386802"
Received: from theer-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.101.109])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 16:49:21 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/4] ASoC: mediatek: mt2701: rename shadowed array
Date: Wed, 10 Mar 2021 18:49:03 -0600
Message-Id: <20210311004904.121205-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
References: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
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

cppcheck warning:

sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:406:36: style: Local
variable 'memif_data' shadows outer variable [shadowVariable]
 const struct mtk_base_memif_data *memif_data;
                                   ^
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:977:41: note: Shadowed
declaration
static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
                                        ^
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:406:36: note: Shadow
variable
 const struct mtk_base_memif_data *memif_data;
                                   ^
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:431:36: style: Local
variable 'memif_data' shadows outer variable [shadowVariable]
 const struct mtk_base_memif_data *memif_data;
                                   ^
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:977:41: note: Shadowed
declaration
static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
                                        ^
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:431:36: note: Shadow
variable
 const struct mtk_base_memif_data *memif_data;
                                   ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index d5cffe7a7e15..bc3d0466472b 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -974,7 +974,7 @@ static const struct snd_soc_component_driver mt2701_afe_pcm_dai_component = {
 	.resume = mtk_afe_resume,
 };
 
-static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
+static const struct mtk_base_memif_data memif_data_array[MT2701_MEMIF_NUM] = {
 	{
 		.name = "DL1",
 		.id = MT2701_MEMIF_DL1,
@@ -1366,7 +1366,7 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < afe->memif_size; i++) {
-		afe->memif[i].data = &memif_data[i];
+		afe->memif[i].data = &memif_data_array[i];
 		afe->memif[i].irq_usage = -1;
 	}
 
-- 
2.25.1

