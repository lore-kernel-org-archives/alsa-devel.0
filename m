Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1490BC77B72
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Apr 2023 11:06:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B999FEEE;
	Thu, 20 Apr 2023 13:06:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B999FEEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681988814;
	bh=BsW4UVCmpcs4lRQ4Ur0+Dxgel0Decd0kkOGtglaHXHE=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=heH2TpUiTmDLejWeHEFt8fD53DjH3s08AFQf7JnJJUp3WPGaz5Vp+VaVeccdPShnb
	 Lh42kEsDhCLBYfbM/UU88ebkOAfhdNOMgumsA9p3F7x0cgf4QMVfK+INk/P2g1vrA3
	 8PVHas/ix1nwndZ1crdlJkEYv2bZz7GnKa2HE77Q=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 310F9F80533;
	Thu, 20 Apr 2023 13:03:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA4BEF805AF; Thu, 20 Apr 2023 13:03:20 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 16980F805AC
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2023 13:03:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16980F805AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WsrvQHmw
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 01672647E2;
	Thu, 20 Apr 2023 11:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1BEC4339C;
	Thu, 20 Apr 2023 11:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681988593;
	bh=BsW4UVCmpcs4lRQ4Ur0+Dxgel0Decd0kkOGtglaHXHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WsrvQHmwBDLv++0lAP/dy0zLSK8jK6vnaotaAc/iNJxBmlSjGkvca3UIpsXDLkdat
	 KYJcNKd766Bf6Kq959BCNa1XuZMvQwEMdPnmk/rsltAFH3BOqiPgHOAo0znSZYpfMx
	 feFYoe9YIr/SDc+stKNAcnBtL9Pv+tlgIjPeVW//10piQKjd8lp/VUq7jk1ERlH8V2
	 aFjdXR56l+tL5q6RPSjluMqzAQEYFc8qh1T7ZGqodbqSbLx0a0F90yU+dLsJ+IJjX+
	 V2CXapSHITigJU2dITkdecIDd0eBfPEwrqlf4NDmrvpcIGXhJ3NdJQHgaFIKUHeMJn
	 T6UEndBLz9pGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/7] ASoC: soc-pcm: fix hw->formats cleared by
 soc_pcm_hw_init() for dpcm
Date: Thu, 20 Apr 2023 07:03:02 -0400
Message-Id: <20230420110308.506181-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420110308.506181-1-sashal@kernel.org>
References: <20230420110308.506181-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7BRSMNIGGIJQGHJ4P6M2NKUTBFPBXNRE
X-Message-ID-Hash: 7BRSMNIGGIJQGHJ4P6M2NKUTBFPBXNRE
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Shengjiu Wang <shengjiu.wang@nxp.com>, Mark Brown <broonie@kernel.org>,
 Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com, tiwai@suse.com,
 alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7BRSMNIGGIJQGHJ4P6M2NKUTBFPBXNRE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 083a25b18d6ad9f1f540e629909aa3eaaaf01823 ]

The hw->formats may be set by snd_dmaengine_pcm_refine_runtime_hwparams()
in component's startup()/open(), but soc_pcm_hw_init() will init
hw->formats in dpcm_runtime_setup_fe() after component's startup()/open(),
which causes the valuable hw->formats to be cleared.

So need to store the hw->formats before initialization, then restore
it after initialization.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1678346017-3660-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3b673477f6215..6f616ac4490f0 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1554,10 +1554,14 @@ static void dpcm_runtime_setup_fe(struct snd_pcm_substream *substream)
 	struct snd_pcm_hardware *hw = &runtime->hw;
 	struct snd_soc_dai *dai;
 	int stream = substream->stream;
+	u64 formats = hw->formats;
 	int i;
 
 	soc_pcm_hw_init(hw);
 
+	if (formats)
+		hw->formats &= formats;
+
 	for_each_rtd_cpu_dais(fe, i, dai) {
 		struct snd_soc_pcm_stream *cpu_stream;
 
-- 
2.39.2

