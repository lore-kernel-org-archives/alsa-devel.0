Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C50CC433E7
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 06:23:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D4F2222E
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 06:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i04Jtymx";
	dkim=temperror (0-bit key) header.d=sholland.org header.i=@sholland.org header.b="IuzzdR03";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dWrC20xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D4F2222E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3038116E0;
	Wed, 14 Oct 2020 08:22:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3038116E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602656586;
	bh=kwFxCzmN2o+LqA+mUC3j9DXCbzQiwLahXWu9h9nvATg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i04JtymxX2FYOi3mbh4ZtwYiWaZ2q/YBUZR3AfaPrxZ/jEs+3mZ+6Hi/qNuTHIeF/
	 E3U4iO5KOk2uXA9/hiKKsZoH/DrfhLueBKPbM4pwADEDxNBmPLBOl3fzwrzi5pM8Hz
	 LnNR7KZVO4G0CFYGqHchvlyszOJYHuPkXHz582T0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A0FAF80226;
	Wed, 14 Oct 2020 08:20:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30736F802B2; Wed, 14 Oct 2020 08:20:08 +0200 (CEST)
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com
 [64.147.123.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5DCDF80268
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2020 08:19:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5DCDF80268
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="IuzzdR03"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="dWrC20xv"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.west.internal (Postfix) with ESMTP id AEB51D1E;
 Wed, 14 Oct 2020 02:19:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 14 Oct 2020 02:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=EqGca1O/37qL2
 eEQTtuQjYXAemOTb/tmNMF84A0l+X8=; b=IuzzdR03YnZdmZDodg18o5RQVDTGN
 zCd1jGcGYLtt+rl5EwB4u/tsoY9zcaCeoKGaX43vN+oFq/gDYBuEFuvOflS0jxwB
 hysUbzKjdSJ3noTAp/wlQwogryGCnyQ2vi3hXyXpU5lNfiXEDRBLp3yeHMKCm7VF
 l1NMp0Fw6moIymbUPXnVMiuUVE8pwFWo2Y/+r3gySD/Q8GfAPTd8rALrnYVfgxxP
 TtFTCjR9oq1RVhqIx2a3wFtJSmphe53U6B8YgiTL9GHXEKAe9lWzYc1iGI1QDtea
 L00OsB2Js5liIUMpNEypiLNVzh+WtXJDcqCgWUXy4LGY0cCcyhCktq30Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=EqGca1O/37qL2eEQTtuQjYXAemOTb/tmNMF84A0l+X8=; b=dWrC20xv
 qEs40NO6dzLuCZGzeBmwkcVp26ne9cKiCNDgokcEULiB/F0UCh3n8rY5TyqUnNyp
 vBzxQEFiTYQEUrX7l+vc2gCwhonIhUb0FYYZQEHEmSvBJoks8i00MDiSQoH7J7dt
 zqIaaBIYtLZJjp1YQvLm+gtBVwk3t/pUhphWH2XI7ATte6mT8+n34lu7GF1v57Ew
 z96kHI7XlBFbL8EIPA2euKDDt7QUwA17xlOEEFID2Xqh3FHPwB0gig3fJtGXQhjN
 MU0JGLYScXQIDpzxJYIe6oFkczdIR/4Ust428e30JoPJxMUmhpKLkitvaSMc6KQa
 z62VfFvR2qpZEw==
X-ME-Sender: <xms:gpiGX3JoAwwHlgac3eABVJ2RPfL4hSHoP2QmSbirtqX9Ap5UdDwtuA>
 <xme:gpiGX7IAWJoGY15y8ZBxz7XeJJ_HkYc13Ly8UbsX_sG3oFzburAKZB9bT2-n9qTrX
 suPTyotv8CCwkMUdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedtgddutdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
 gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
 iivgepjeenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:gpiGX_uPkL8U2zsy_xgk5DvfXn45CMCaYnFoC4X5Q7QTLybNUGKD0g>
 <xmx:gpiGXwY8MBwRfT8iyLctB2wYxlVMPlJ_EPIwbz39HQ4T1M1PxZn5rQ>
 <xmx:gpiGX-a2QhwK-G-lNbvjnSRRTJwMA2W61RnWpQU2vABMjwhajcHFRQ>
 <xmx:gpiGX0NtP1qwkKeP0J39vM-Cq1NrFUzoHoPup0YobuDU_gujfvu-jxvNn3c>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9F95B328005A;
 Wed, 14 Oct 2020 02:19:45 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 08/17] ASoC: sun8i-codec: Enforce symmetric DAI parameters
Date: Wed, 14 Oct 2020 01:19:32 -0500
Message-Id: <20201014061941.4306-9-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014061941.4306-1-samuel@sholland.org>
References: <20201014061941.4306-1-samuel@sholland.org>
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
directions, including BCLK/LRCK divisor and word size. The DAIs produce
only noise or silence if any of these parameters is wrong. Therefore, we
need to enforce symmetry for these parameters, so starting a new
substream will not break an existing substream.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 49e763d1891b..21104e6e8892 100644
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

