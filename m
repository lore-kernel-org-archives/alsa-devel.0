Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17E1C433E7
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 06:23:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A13C2177B
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 06:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FUYuXF7+";
	dkim=temperror (0-bit key) header.d=sholland.org header.i=@sholland.org header.b="oAtdAZ/5";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lsB9QQHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A13C2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91ABF16C9;
	Wed, 14 Oct 2020 08:23:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91ABF16C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602656633;
	bh=Cl0OIKx0YfhGCBI1VI2SpAplwEcxKpunT6PHOdHjyp8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FUYuXF7+KpvwCXkneXbLI+YJJYF6Wd6pnTFjnPPLVMYB/olXeHshIHw/gUO6ZWaG8
	 PaKRuqgaGeCl6D1iFRYomfo5eD2mRoyy7lfjBMOtFeUk/keAQp7l7DDADr46Jn6wck
	 iGZo9oo96/iV2qjQkqyej7AeFIgwecdml9FyhQNQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DEC4F802D7;
	Wed, 14 Oct 2020 08:20:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EEF2AF802D8; Wed, 14 Oct 2020 08:20:13 +0200 (CEST)
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com
 [64.147.123.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBC68F80269
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2020 08:19:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBC68F80269
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="oAtdAZ/5"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="lsB9QQHF"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.west.internal (Postfix) with ESMTP id A5395CDC;
 Wed, 14 Oct 2020 02:19:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 14 Oct 2020 02:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=Uq+D08HxvzTG1
 9wqye1HARI/n17MUW30E0i8Uib4oD0=; b=oAtdAZ/5FWXOneoaI0Mn1PC0Njy//
 7jm7V2wWdkeh4y8SSYYTNM1rNzMf2Qx7qsht+wh2FwQOhTiGgSSesmah4J6pBA+E
 pkyOocnBckrLZkSQ/fARPqQKY7CdTql6JyIP/dft5mFjXJp8gga8vuoKYUNXvFN1
 W5g8Gc5flqExkgJoue/IU4WqlQlGK2a7p7UAi0nqs21MUWJNL+exzm7sZ2aXGCw3
 zNNAIpJMLK+AdujCHFnJfb4fZmNxOEQG9itln4j9pBYp/TovTxZB+yWIbspVUsyt
 wsRVsKzulQ/wOjg4xenJspMT+0SYSdMtBNFCqRv8Th8b+AiVP4Zs90myw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=Uq+D08HxvzTG19wqye1HARI/n17MUW30E0i8Uib4oD0=; b=lsB9QQHF
 zIdJZo7UjCE/M9lAwsQy5Jd+l5S8k3wKHiXTgD/FwTV2wf9C01y29kb6Mv0EIq1C
 TAlAm5j78QMe7AqIAc+01B9VxRRSQ66dykzpGgWNhWStCUp+vxkyVDgUTG2f8N0I
 Vf8zFVpwW9dbmWZpTLH+/OaqXwc+xK10LVmpcU1WYwoetkC0bzHIYcTvE+X/7iY/
 Olc24RsxVwPgKg+f8DLR87XYmIGVZD1dWVh6ve1wu1ehilN+iLb1zZbonBH4qY2G
 Pm5cDFXw3ohQgyxULeuMpSITvMXHLPrnPItrSXj1S5oL47iJqZQztpCrIXjpqPuG
 thoz2oxFh4ST9Q==
X-ME-Sender: <xms:hJiGX7S8CWMX08vjgKTox6z8AGwnI76h9Es5L1b0BgRwJ8FcBoPikA>
 <xme:hJiGX8wslUB5cQLVPkbulMVzuRFfKi-h2kojUpvTg6521aL3xjywjGXr0txeMShKw
 5CJ698Rhvm73C-NCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedtgddutdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
 gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
 iivgepjeenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:hZiGXw2zM7EdaBO8DVpmOBvGozj3dEBsBbt-EjWjoiWShvblXFYNYg>
 <xmx:hZiGX7BWwIAi5y9x8JZymrvAFzMerife-lAJjSrHgaMaZ8EhiX_-uw>
 <xmx:hZiGX0jNSmalNdVmbC6AQmIDgFPT_9ixwKfesahiSfT5j9dDFUixpA>
 <xmx:hZiGX9V4GZ9U3z98B0Yb4KdDI-NUTDL6rZglbfHFwrzLkHrBDMLGOwD1cSU>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 791FD328005E;
 Wed, 14 Oct 2020 02:19:48 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 14/17] ASoC: sun8i-codec: Enable all supported PCM formats
Date: Wed, 14 Oct 2020 01:19:38 -0500
Message-Id: <20201014061941.4306-15-samuel@sholland.org>
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

Now that the DAI clock setup is correct for all hardware-supported PCM
formats, we can enable them in the driver. With the appropriate support
in the CPU DAI driver, this allows userspace to access the additional
formats.

Since this codec is connected to the CPU via a DAI, not directly, we do
not care if the CPU DAI is using 3-byte or 4-byte formats, so we can
support them both.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index a530e58018b7..e3abf8363d9b 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -91,16 +91,23 @@
 #define SUN8I_AIF1CLK_CTRL_AIF1_CLK_INV_MASK	GENMASK(14, 13)
 #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK	GENMASK(12, 9)
 #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK	GENMASK(8, 6)
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK	GENMASK(5, 4)
 #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK	GENMASK(3, 2)
 
 #define SUN8I_CODEC_PASSTHROUGH_SAMPLE_RATE 48000
 
+#define SUN8I_CODEC_PCM_FORMATS	(SNDRV_PCM_FMTBIT_S8     |\
+				 SNDRV_PCM_FMTBIT_S16_LE |\
+				 SNDRV_PCM_FMTBIT_S20_LE |\
+				 SNDRV_PCM_FMTBIT_S24_LE |\
+				 SNDRV_PCM_FMTBIT_S20_3LE|\
+				 SNDRV_PCM_FMTBIT_S24_3LE)
+
 #define SUN8I_CODEC_PCM_RATES	(SNDRV_PCM_RATE_8000_48000|\
 				 SNDRV_PCM_RATE_88200     |\
 				 SNDRV_PCM_RATE_96000     |\
 				 SNDRV_PCM_RATE_176400    |\
 				 SNDRV_PCM_RATE_192000    |\
 				 SNDRV_PCM_RATE_KNOT)
 
 enum {
@@ -535,26 +542,26 @@ static struct snd_soc_dai_driver sun8i_codec_dais[] = {
 		.id	= SUN8I_CODEC_AIF1,
 		.ops	= &sun8i_codec_dai_ops,
 		/* capture capabilities */
 		.capture = {
 			.stream_name	= "AIF1 Capture",
 			.channels_min	= 1,
 			.channels_max	= 2,
 			.rates		= SUN8I_CODEC_PCM_RATES,
-			.formats	= SNDRV_PCM_FMTBIT_S16_LE,
+			.formats	= SUN8I_CODEC_PCM_FORMATS,
 			.sig_bits	= 24,
 		},
 		/* playback capabilities */
 		.playback = {
 			.stream_name	= "AIF1 Playback",
 			.channels_min	= 1,
 			.channels_max	= 2,
 			.rates		= SUN8I_CODEC_PCM_RATES,
-			.formats	= SNDRV_PCM_FMTBIT_S16_LE,
+			.formats	= SUN8I_CODEC_PCM_FORMATS,
 		},
 		.symmetric_rates	= true,
 		.symmetric_channels	= true,
 		.symmetric_samplebits	= true,
 	},
 };
 
 static int sun8i_codec_aif_event(struct snd_soc_dapm_widget *w,
-- 
2.26.2

