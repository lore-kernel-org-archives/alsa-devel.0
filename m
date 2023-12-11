Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5C3C4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Dec 2023 13:54:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4FDD7839;
	Mon, 11 Dec 2023 14:54:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4FDD7839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702302866;
	bh=L/m0usjSFyvIqmBIXS7qRmIZGNCj7oEsBBqzks8O54w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=O10IfFlLl/ugRPg+gh6axKoVplHfvNHVoJ0dSQFYT8VPGpgTsr1BFuEPHUj6Vz+HS
	 Rt9Rl/F1kW9RcDKyyE9Ui/YY7jD4dsXz845sjGuY9SVVb6mAHoaIVqsnw0YPHs7AH6
	 cpnof3YIasszhvl9CvxLH61j5lkkw/peGLq8BZbc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 205ABF80689; Mon, 11 Dec 2023 14:52:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 392E2F8068A;
	Mon, 11 Dec 2023 14:52:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0ABD5F80677; Mon, 11 Dec 2023 14:52:41 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F3EC1F8061C
	for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2023 14:52:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3EC1F8061C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AM2c+Xaz
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EB3D06124F;
	Mon, 11 Dec 2023 13:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2193DC433C8;
	Mon, 11 Dec 2023 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302752;
	bh=L/m0usjSFyvIqmBIXS7qRmIZGNCj7oEsBBqzks8O54w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AM2c+Xaz/hdQiUkmmnAiI3Lq3i7e9lka8Dj2dg91IslTpKr3Uq+leavTz5GJgunHD
	 HdiJWBljnx5JOB3j7MJnRihzcbY1Bsv8zAuIFk4ADXLq2jF3UDS9a3byHWRbjUOg/v
	 kQwlNeKUQRXpqZkXjK3nP8RGoHpekwLwRj8AeFjH1IlTSuPUG47oZDw+vX6DyL0LSz
	 +HrIaEGxnq33D48f+O9HV7OgoVq23XpIAkmHF1uRtFXuuolG/lh1q5oEKn+s6fKksH
	 Oj+eYPcZBdf1JE8O58RP0PoQlnmrPQgKiEi3Sdv1L1VAVTCvhJazmard06qVzHy4Vp
	 CZ6Zjf7+3OKAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/47] ASoC: fsl_xcvr: refine the requested phy
 clock frequency
Date: Mon, 11 Dec 2023 08:50:16 -0500
Message-ID: <20231211135147.380223-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4AA64YR2XCS34VMVKGCIMM3JAH2UXPA6
X-Message-ID-Hash: 4AA64YR2XCS34VMVKGCIMM3JAH2UXPA6
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4AA64YR2XCS34VMVKGCIMM3JAH2UXPA6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 347ecf29a68cc8958fbcbd26ef410d07fe9d82f4 ]

As the input phy clock frequency will divided by 2 by default
on i.MX8MP with the implementation of clk-imx8mp-audiomix driver,
So the requested frequency need to be updated.

The relation of phy clock is:
    sai_pll_ref_sel
       sai_pll
          sai_pll_bypass
             sai_pll_out
                sai_pll_out_div2
                   earc_phy_cg

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Link: https://lore.kernel.org/r/1700702093-8008-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_xcvr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 77f8e2394bf93..f0fb33d719c25 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -358,7 +358,7 @@ static int fsl_xcvr_en_aud_pll(struct fsl_xcvr *xcvr, u32 freq)
 	struct device *dev = &xcvr->pdev->dev;
 	int ret;
 
-	freq = xcvr->soc_data->spdif_only ? freq / 10 : freq;
+	freq = xcvr->soc_data->spdif_only ? freq / 5 : freq;
 	clk_disable_unprepare(xcvr->phy_clk);
 	ret = clk_set_rate(xcvr->phy_clk, freq);
 	if (ret < 0) {
@@ -409,7 +409,7 @@ static int fsl_xcvr_prepare(struct snd_pcm_substream *substream,
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	u32 m_ctl = 0, v_ctl = 0;
 	u32 r = substream->runtime->rate, ch = substream->runtime->channels;
-	u32 fout = 32 * r * ch * 10 * 2;
+	u32 fout = 32 * r * ch * 10;
 	int ret = 0;
 
 	switch (xcvr->mode) {
-- 
2.42.0

