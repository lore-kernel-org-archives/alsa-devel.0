Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7B3C4363D
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 02:21:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4A521941
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 02:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FTJ2pqdF";
	dkim=temperror (0-bit key) header.d=sholland.org header.i=@sholland.org header.b="Rq4liLtM";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UvNxrRGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4A521941
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3684817D9;
	Thu,  1 Oct 2020 04:20:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3684817D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601518886;
	bh=AUECoGsfYf6t1XytYqj2asga0RM/263hsJ6jJUXbq/8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FTJ2pqdFf6gUo2ir/KJlAhvv1k8PQatpVXQuOUKzk4Jc/9l/rzthFtK1Aoh5+Ad3w
	 jxRywT+uxZK+/bmtTJFxv2CBx3WwGKmtuQTrbF1310w06HQf2MDUkjG+NCTjhK5BS9
	 FtTkNF98pP7ulE6/BEEaBHmSbZl0mhe2UNpvmiec=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3769AF80368;
	Thu,  1 Oct 2020 04:12:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA3A8F8033F; Thu,  1 Oct 2020 04:12:26 +0200 (CEST)
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B148F802E1
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 04:12:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B148F802E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="Rq4liLtM"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="UvNxrRGK"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id D119A58037F;
 Wed, 30 Sep 2020 22:11:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 30 Sep 2020 22:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=ESOPut2BeEWC2
 0YRE1QVHBEoR5y2EjI/peFt241C+gI=; b=Rq4liLtMzvb81zu7cyPA6sfd+4qJs
 I9YsabRDGB9cYWtl/mdAbuUtqekNPn/M/kWs0lvTMx4rSKcqDcPncz1wudtMMHDb
 L2CUZ6wUPV6VA8hUhTdlMNvOYA1eXsA1SLFIJieV9d3Y+age4NtPJ/O508Rk0dv/
 sRezzXrd+l1cRpO94l8IIZUHO3LYeMyxPSxFcyJSHm66fYaRLDp/EHTcAhJIvfUb
 2nDn0XjgJW42zD908TNgwSbRXRYrCliL9lHVw2gic2Yyj6fDqc+rzIWT8FqtztAr
 rn4mtSCCU7AHrLvW9i28E3I4ZrGyqL7rROSOzW6k6hBmSeWrEzyvPdW7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=ESOPut2BeEWC20YRE1QVHBEoR5y2EjI/peFt241C+gI=; b=UvNxrRGK
 nsTegUIFxPtfVAevDHsa25FWlASpxUiMdn5yCfvFCa0k8K2+3Vl/j9bw5sdgZwrw
 kEE0IoqLBCOp43t0fcIN5Ej9GRawvYMbbwG1rI8ICkjUHkLH8re3g2HTmk98CXtW
 IT30sGtTHkoqT5Kh15/E3JEh/kicP6aA5XDGeDC3gn5aErzC1ozlocdFZol+Sidl
 xI7WMf9DXhbWCacjUbzmDw1mFzMDjp3HPiK+Rys6HeC+BVdezM1LgVSuESWPDpcr
 1RN4q4ZtVs7lih87+tC/jQbL37bixHG51TUpqXEzc/oCeQqgP4Qbck2fc/wepMC3
 WDrbFjjGIB5s6A==
X-ME-Sender: <xms:7Tp1X-X-5TvZsjEQyDyAkyHNWX--1BK1B6Nh-8aYx0e0Hw1qjlK6nA>
 <xme:7Tp1X6lhAf2Z8kK7C7Xsvi-ZA5vOwcFMbY6ZX6RGUyWg0MpLNe_kzzr2HCXceNGLd
 CJZtjDxV1SrbDfhYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdehkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
 jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
 gvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
 rdhorhhg
X-ME-Proxy: <xmx:7Tp1XybDgIQzsNxt2W1EDQ_-dqQWjO-Zxmvr3RwvAvTZI1DVTcYUmA>
 <xmx:7Tp1X1WnEjqNXSi59wSBUMP3pihTSVs7ES-89Qtzde0A8bq2PT9_9Q>
 <xmx:7Tp1X4lh57BecenD5638bst0olR_TpinqjgvuUf2gphb4qU1YJ7pZg>
 <xmx:7Tp1Xy7BHouOU4YUvo7OH_x8TzAnQFiZ1uGp74Vv_NYYq-OFsaxBkA>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id D76203064683;
 Wed, 30 Sep 2020 22:11:56 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 16/25] ASoC: sun8i-codec: Enforce symmetric DAI parameters
Date: Wed, 30 Sep 2020 21:11:39 -0500
Message-Id: <20201001021148.15852-17-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001021148.15852-1-samuel@sholland.org>
References: <20201001021148.15852-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Samuel Holland <samuel@sholland.org>
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

The AIFs have a single register controlling DAI parameters in both
directions, including BCLK/LRCK divisor word size. The DAIs produce only
noise or silence if any of these parameters is wrong. Therefore, we need
to enforce symmetry for these parameters, so starting a new substream
will not break an existing substream.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 0a53dc0c34d0..f21274530a0e 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -420,16 +420,19 @@ static struct snd_soc_dai_driver sun8i_codec_dais[] = {
 		/* playback capabilities */
 		.playback = {
 			.stream_name	= "AIF1 Playback",
 			.channels_min	= 1,
 			.channels_max	= 2,
 			.rates		= SNDRV_PCM_RATE_8000_192000,
 			.formats	= SNDRV_PCM_FMTBIT_S16_LE,
 		},
+		.symmetric_rates	= true,
+		.symmetric_channels	= true,
+		.symmetric_samplebits	= true,
 	},
 };
 
 static const char *const sun8i_aif_stereo_mux_enum_values[] = {
 	"Stereo", "Reverse Stereo", "Sum Mono", "Mix Mono"
 };
 
 static SOC_ENUM_DOUBLE_DECL(sun8i_aif1_ad0_stereo_mux_enum,
-- 
2.26.2

