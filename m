Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD38C7619B
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 02:32:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B1F20718
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 02:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M/cKdaGQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="PXsX6toZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aI+TRD0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B1F20718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4074116AF;
	Mon, 17 Feb 2020 03:31:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4074116AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581906730;
	bh=f/cghTNA08Tlr0zB5Z6Ms/zSzP6BmzqnVZG55RZf9Lc=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M/cKdaGQmzyQPR3eCXJ4uDwY0q3yrbqUwHfFkWRe6VlmJTxouCvwgE/WajLhXJBna
	 ZXO5HgrhxoVoi/GFkNsnVglBMuT6sUVdye/GV9U8zT2Nrbnna2CYNIVhMidqSMwfjO
	 q8oo2T2bD6yc2cNQJ4NJ2bPJVqgJKuXbrFvT6puw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A290F80367;
	Mon, 17 Feb 2020 03:18:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DAA2F80341; Mon, 17 Feb 2020 03:18:36 +0100 (CET)
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C53DF80335
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 03:18:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C53DF80335
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="PXsX6toZ"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="aI+TRD0v"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 97F196D6C;
 Sun, 16 Feb 2020 21:18:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Sun, 16 Feb 2020 21:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=W5xQOTsnDMiNQ
 9X0qwV3u3wX3ye3yBCqbMHL1BzeFW8=; b=PXsX6toZj7aGCIffHj0Jyz8VyfENT
 3qG8NgMGwwW0cF1NpX6FDGlVT41i9E0JYiZIzsC3C88F4Jiu23h3ZPYDTZ0StAhG
 dYgz4yTKe5Bi/2GMwLHNwa4aZs6eFzx3wCpkLyOM5rm4RtYrHPSgH+ZChcFH4wgV
 pm/x2T75aNciH5spmnxxAVRsvAdDH+Q8xeeLLJ+SOEBX3BU6+MPBgur8Kb43uhsn
 ibg+vwq1ONPWrE4wuyA8ouT9d1YFNYBY0TgdA4c2dWd9nIa0BTivRZcWMEulKBwy
 HKI/VZQeMQrVIE3w3b+tK+YixqcERgqgGcZFiuX6YZ7XJUbZj6Y0GKsXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=W5xQOTsnDMiNQ9X0qwV3u3wX3ye3yBCqbMHL1BzeFW8=; b=aI+TRD0v
 omoY5e0UwEo5SwrldOLW8cKWoW8d68iZiGvR54qVU4kx+AuXeBq726B+G5zgpy3X
 hQl32agCH8VsA+GG/LLm0ep78tbjyhZ/cZ1VkBrI1EBMLwnHEyOs5LiYa3P44/GE
 i8+Lqgjqtfxbgbuz+oaw+KzRJVGE5wsQRNTSM/rnKVb0JXDIxDNyhEkF1jGGd7JL
 snMFOeYL/NaKnA7jv4WuZbc4B76hXCU7W87IUh6j+N4sWEwxymF2nqvhpQBJhh3U
 4r60ou3dNqo3gLAbFo1TON3jzBAf3EjKgfCuDikffOgD/4AxUueghbXxgR8VAAF6
 Pnx9wBYF70mpJg==
X-ME-Sender: <xms:6fdJXnfpXSdv4pSFq_9Jd8EQloFG73eBefGcfAYR7sjRm04iDGESCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdegfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
 ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6fdJXillXBbxYHle8285k91B5M-yGKq59pb5ZBavO3IKLLxtkxpWUw>
 <xmx:6fdJXgvPMnNuTvUCRYAfKlgKerIn3bXCbjXGYj72sujVIJ1Wh3V6zA>
 <xmx:6fdJXo-c3L0L4NqfdlKcOmcDWurgz4NeJpZ5Eh8Jve91M90QTgDZjg>
 <xmx:6_dJXhHYdMYPbhE-zLNpvmgeiRUo_Si18V2o9AlV-pUjHIPEy3cL4A>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2C2203060D1A;
 Sun, 16 Feb 2020 21:18:17 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 16 Feb 2020 20:18:11 -0600
Message-Id: <20200217021813.53266-7-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217021813.53266-1-samuel@sholland.org>
References: <20200217021813.53266-1-samuel@sholland.org>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Samuel Holland <samuel@sholland.org>
Subject: [alsa-devel] [PATCH 6/8] ASoC: sun50i-codec-analog: Make line out
	routes stereo
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This matches the hardware more accurately, and is necessary for
including the (stereo) line out mute switch in the DAPM graph.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index 176d6658d099..df39f6ffe25a 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -328,7 +328,9 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 			     SUN50I_ADDA_HP_CTRL_HPPA_EN, 0, NULL, 0),
 	SND_SOC_DAPM_OUTPUT("HP"),
 
-	SND_SOC_DAPM_MUX("Line Out Source Playback Route",
+	SND_SOC_DAPM_MUX("Left Line Out Source",
+			 SND_SOC_NOPM, 0, 0, sun50i_codec_lineout_src),
+	SND_SOC_DAPM_MUX("Right Line Out Source",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_lineout_src),
 	SND_SOC_DAPM_OUTPUT("LINEOUT"),
 
@@ -439,12 +441,14 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Mic2 Amplifier", NULL, "MIC2"},
 
 	/* Line-out Routes */
-	{ "Line Out Source Playback Route", "Stereo", "Left Mixer" },
-	{ "Line Out Source Playback Route", "Stereo", "Right Mixer" },
-	{ "Line Out Source Playback Route", "Mono Differential", "Left Mixer" },
-	{ "Line Out Source Playback Route", "Mono Differential",
-		"Right Mixer" },
-	{ "LINEOUT", NULL, "Line Out Source Playback Route" },
+	{ "Left Line Out Source", "Stereo", "Left Mixer" },
+	{ "Left Line Out Source", "Mono Differential", "Left Mixer" },
+	{ "Left Line Out Source", "Mono Differential", "Right Mixer" },
+	{ "LINEOUT", NULL, "Left Line Out Source" },
+
+	{ "Right Line Out Source", "Stereo", "Right Mixer" },
+	{ "Right Line Out Source", "Mono Differential", "Left Line Out Source" },
+	{ "LINEOUT", NULL, "Right Line Out Source" },
 
 	/* Earpiece Routes */
 	{ "Earpiece Source Playback Route", "DACL", "Left DAC" },
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
