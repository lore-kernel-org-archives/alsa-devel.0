Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF95EC47253
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:05:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4022A2063A
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gmTRG56w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4tQu3a3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4022A2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 914A316C2;
	Thu, 30 Apr 2020 16:04:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 914A316C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588255517;
	bh=nYvNC5mp3p9E42LUYjMDSuncRs7p9od0b/nf87IZNn8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gmTRG56wByzOB9oBtr9Tr4ytQ583VFoz6NGEyzhGObXyDbRqL9cuEQbdrA5Vq6H6L
	 h4CoK8jJ6A1myZ2RTX5FNneoiZS0ctBoD4+2F1q78z/U/DLp7KPFf72DD1i3INpEK3
	 CxXmuomxqKQcjX5xGZ3iI2IeGRPVm2y58uTHK0WE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DBECF8036F;
	Thu, 30 Apr 2020 15:52:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D210F80361; Thu, 30 Apr 2020 15:52:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37873F8035E
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 15:52:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37873F8035E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="B4tQu3a3"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 089DE24965;
 Thu, 30 Apr 2020 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588254747;
 bh=nYvNC5mp3p9E42LUYjMDSuncRs7p9od0b/nf87IZNn8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B4tQu3a3ykmzTDTVcJLPFx0KMCKj6hiI2OZKVR+ApH0iNQc04gnFhUhRUvuz1KGSW
 /JsGrVhyYasScJ+SRF09f5hU+MPeoGIyHkORV5jKBTzDqxMRt524itZlcoST7Y9EqX
 gPqHGaF1KIq8TjETN/gFahDIMv2fRic3oXVSMVVU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 07/57] ASoC: topology: Check return value of
 soc_tplg_dai_config
Date: Thu, 30 Apr 2020 09:51:28 -0400
Message-Id: <20200430135218.20372-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135218.20372-1-sashal@kernel.org>
References: <20200430135218.20372-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit dd8e871d4e560eeb8d22af82dde91457ad835a63 ]

Function soc_tplg_dai_config can fail, check for and handle possible
failure.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200327204729.397-7-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 22960f5932c7f..2d4a5a3058c41 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2431,7 +2431,7 @@ static int soc_tplg_dai_elems_load(struct soc_tplg *tplg,
 {
 	struct snd_soc_tplg_dai *dai;
 	int count;
-	int i;
+	int i, ret;
 
 	count = le32_to_cpu(hdr->count);
 
@@ -2446,7 +2446,12 @@ static int soc_tplg_dai_elems_load(struct soc_tplg *tplg,
 			return -EINVAL;
 		}
 
-		soc_tplg_dai_config(tplg, dai);
+		ret = soc_tplg_dai_config(tplg, dai);
+		if (ret < 0) {
+			dev_err(tplg->dev, "ASoC: failed to configure DAI\n");
+			return ret;
+		}
+
 		tplg->pos += (sizeof(*dai) + le32_to_cpu(dai->priv.size));
 	}
 
-- 
2.20.1

