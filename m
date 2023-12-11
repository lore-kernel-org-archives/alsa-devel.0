Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB36C10DC3
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Dec 2023 13:54:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2121EBC0;
	Mon, 11 Dec 2023 14:53:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2121EBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702302846;
	bh=B/U5W9npea2EkzEYQL8tfRUKdcmXLdor/S2UDsVoyR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sf2cyVBtxgV24u6PCrs6N4f7LhZUtToeYgtEj41CllfubEdGKRyQaQkFp0/+jqjOY
	 U3N6N3h7WuRj1wFfEq4pz2TTMhQ31SOML4RBb8B8LR/dgKC7QevtjIEcmHkBHOsTjT
	 XNzOdvIVEMkndtho8aDEFfECFWujseQ04W39jKL8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C157F8064F; Mon, 11 Dec 2023 14:52:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C3E12F80633;
	Mon, 11 Dec 2023 14:52:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51622F805C8; Mon, 11 Dec 2023 14:52:31 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9B796F805C8
	for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2023 14:52:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B796F805C8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ho+7+k85
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B8A85CE111F;
	Mon, 11 Dec 2023 13:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C21C433C7;
	Mon, 11 Dec 2023 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302744;
	bh=B/U5W9npea2EkzEYQL8tfRUKdcmXLdor/S2UDsVoyR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ho+7+k85nLQyj9pznnMr9mQ1U5Ir0QqFxjBXCVLpDZvvp9L0jqr4eB6dopFa7jSYd
	 4QaCTiFl/ZEC5WZ4pf9LIBhMGXlaT//rb0SjyrZ0pJJGCShUfNkSOPqiq5wbGEET9K
	 xWQf9wN3w0l7h6XME5L96Lt53V452Wyg5i4BPqWD0yZaMDHbZ43dBEdYROvC6fMYk9
	 gsR5sCFzZM5jycl9QNTUgPyVC7kDhaAehVZCY1F5P26an9dIw1BLBeTiGGk5v1TDCt
	 pGeFLaLSFdF86T6tV1/H8tFAvQ+SJ9KSyimj9OcNp7XcmL6zveaFj8bB7wDRIaLMt5
	 9saGaJckwGDow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
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
Subject: [PATCH AUTOSEL 6.6 12/47] ASoC: fsl_xcvr: Enable 2 * TX bit clock for
 spdif only case
Date: Mon, 11 Dec 2023 08:50:13 -0500
Message-ID: <20231211135147.380223-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit
Message-ID-Hash: PSLBNA7FK6W4MFIOLA77QYYYACFU2PPC
X-Message-ID-Hash: PSLBNA7FK6W4MFIOLA77QYYYACFU2PPC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PSLBNA7FK6W4MFIOLA77QYYYACFU2PPC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit c33fd110424dfcb544cf55a1b312f43fe1918235 ]

The bit 10 in TX_DPTH_CTRL register controls the TX clock rate.
If this bit is set, TX datapath clock should be = 2* TX bit rate.
If this bit is not set, TX datapath clock should be 10* TX bit rate.

As the spdif only case, we always use 2 * TX bit clock, so
this bit need to be set.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1700617373-6472-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_xcvr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index fa0a15263c66d..77f8e2394bf93 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -414,6 +414,16 @@ static int fsl_xcvr_prepare(struct snd_pcm_substream *substream,
 
 	switch (xcvr->mode) {
 	case FSL_XCVR_MODE_SPDIF:
+		if (xcvr->soc_data->spdif_only && tx) {
+			ret = regmap_update_bits(xcvr->regmap, FSL_XCVR_TX_DPTH_CTRL_SET,
+						 FSL_XCVR_TX_DPTH_CTRL_BYPASS_FEM,
+						 FSL_XCVR_TX_DPTH_CTRL_BYPASS_FEM);
+			if (ret < 0) {
+				dev_err(dai->dev, "Failed to set bypass fem: %d\n", ret);
+				return ret;
+			}
+		}
+		fallthrough;
 	case FSL_XCVR_MODE_ARC:
 		if (tx) {
 			ret = fsl_xcvr_en_aud_pll(xcvr, fout);
-- 
2.42.0

