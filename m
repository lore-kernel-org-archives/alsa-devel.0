Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A54EC35242
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 06:48:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2668F206F4
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 06:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JCDSocQA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="KutxqOI2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kJLHeIeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2668F206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E5204E;
	Mon, 17 Feb 2020 07:47:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E5204E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581922101;
	bh=ZD+IMTU/ASXJQqcP9cRl/PK+Z4eU+dchjerf6ZHQ3jI=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JCDSocQAJ5qgr7ASDsV043CFQ3WOFvP+KUExZjm1vwsgRBK+HtYoViHDI5xz4PPkn
	 lxhatPg8+KVyEenbLbzN85bxCQAaNkMilF6gGecgL9Ot1H9unHsOBU/G0y1bBtex/n
	 kvPXov0sa1pcOkZqFKC+nhKHx9T0PC94k7qFnB98=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7621F802E9;
	Mon, 17 Feb 2020 07:43:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16365F802BD; Mon, 17 Feb 2020 07:43:10 +0100 (CET)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8686EF801F5
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 07:42:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8686EF801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="KutxqOI2"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="kJLHeIeK"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 9E80353C8;
 Mon, 17 Feb 2020 01:42:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=4oosZxTt0fEhw
 STmSYl/k9XHF9CYNsoiHSHZf3lt07Q=; b=KutxqOI2gtyYxbFsVOgHWlx2v9cmo
 BpFrEABQgpDfbqZyHiDLWIom96ahWk4e5WdCMw5dEAeWf8RSAJHUJpLr6v6tMBVD
 aEWui8VNH0fTv7WI8Zyo7nXXIzkQ0S3aslvUixhct5UpOdmCvYDrD+o14UHRrF8/
 1mby+g9uNvncxRhavhv/oUkNuz+Ogo3/6gC/tTrvXD+81ZZpd6obyAZs+oV1fSYK
 +IHc2X0C+kYPvI36QpznniVIDjZ1Yht0WZjRZ1ynG3qDjoJ7d4449EPK0fMpY+OC
 9XdLT1JNPL4AvPt+R2ALyLXImveGHzw0buip3kN7vu9OtRY4jhg+FWkjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=4oosZxTt0fEhwSTmSYl/k9XHF9CYNsoiHSHZf3lt07Q=; b=kJLHeIeK
 WA2mLG2C2mgX6ZDGh1f8gCQb0jnh8mCvanXsgorKFkr58AYTexH2m6nim8A6kzNQ
 AzVbfFQjr8dNLchrVlantceTauO7hWTHl406KNAoeFOsmG7Yei4yCB/BZ+lDXxSb
 +U5nsSUuiIt1/qRqZKo5agBaEoJc+ipKYJl3sZZnuxaZuFXrYdN8wgpX4jaK5mbi
 9TQrNNytPMPfz4hVgpXMZ20Rm5nE9nIg0FkFJEvMpPJQOAMBWHu6d/KjlRnGEleM
 gcYk6WH/yQhzeRDoXUK5Z5a07gyN3YeSuHYyMf+thFeYIYTFkpz5egeuEh0I6f3d
 Nb9mhXcU+pDtQQ==
X-ME-Sender: <xms:7zVKXtxAOZORVKqyIycYBsYoZmo3x8DLue4BMkpx06iGcUpdVKUHag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
 ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:7zVKXjYpAbDpyKYoH52pGJQ1K-0RBvLVy6NqAbqVtir0aE2s8wwThw>
 <xmx:7zVKXt3BfpcTWrZSblEV3aa98g9kymKemgU4pWTiqJADvEt1ZcajHw>
 <xmx:7zVKXpiueZEVCBUR9R_HT0YExyrLcSoaI1Hp2-WZDqe_cafH_8JxeQ>
 <xmx:7zVKXp_QzYTIEtGNdgHO5jFYO9kTsJtRKPps1BB_ADuk3MJS4sGpkw>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id D68C63280059;
 Mon, 17 Feb 2020 01:42:54 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>,
 =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date: Mon, 17 Feb 2020 00:42:23 -0600
Message-Id: <20200217064250.15516-8-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 stable@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [RFC PATCH 07/34] ASoC: sun8i-codec: Remove extraneous
	widgets
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

This driver is for the digital part of the codec, which has no
microphone input. These widgets look like they were copied from
sun4i-codec. Since they do not belong here, remove them.

Cc: stable@kernel.org
Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index cb3867644363..0eca75d22f13 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -441,10 +441,6 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 			    SUN8I_MOD_RST_CTL_DAC, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("RST ADC", SUN8I_MOD_RST_CTL,
 			    SUN8I_MOD_RST_CTL_ADC, 0, NULL, 0),
-
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_MIC("Mic", NULL),
-
 };
 
 static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
