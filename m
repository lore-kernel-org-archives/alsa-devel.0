Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71013C35242
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 06:51:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007E820679
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 06:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jGvThEkG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="rA0TWI3a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AlfQlKZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007E820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 635981686;
	Mon, 17 Feb 2020 07:50:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 635981686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581922308;
	bh=F8OX6nBbvXJP2ACnLyACie4ljDz4iSa7V1NKemYsvYQ=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jGvThEkGpkbK8jZWpZSwGGqM2GLf5ZqiZ8QTJ0WAFigNO/LPsfvqSTYKxN8NH0+V9
	 E1UQDGgxxfPtvxfF8RFc07x1A1bgwgwqvl430r5WRKJAaXV49ynTtbjN70zNsKMZQC
	 bXfU34sYY6Q1bpOBPPitNEiFQwkWbaS6tAZ3P1iQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7531F80315;
	Mon, 17 Feb 2020 07:43:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE662F802E0; Mon, 17 Feb 2020 07:43:14 +0100 (CET)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4FEAF80278
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 07:42:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4FEAF80278
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="rA0TWI3a"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="AlfQlKZV"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 24A6151E1;
 Mon, 17 Feb 2020 01:42:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=p9ksJoRp95f7P
 lFbHwIyRMPpDKeA8eop3QczTiTwM5I=; b=rA0TWI3a7YFet8EoCuVsI860z8I+E
 SUNvecqs39KS3JIqqi4RPpfstCl9Iu0k0P0q2gD+P370ar9as8z7XTME/yXhIf0o
 0Pz3ifUxbqWnK+BILkTy2G+vAwMuTOaTptOmGT3NfPRJsKC7oe90DAYixPMoFcZ4
 GSeMwwiv30gl01gdhxiIj1k7zFrQTdoNf4vWQH4MVfwhLxLv5vVvwRqEyLkhsYg5
 e/CMCVuWb0U4WkpEbnmyTN4xGsrFOc0q38nJCjdtDbdhF/F5wdowWQQe76XC3BSa
 u97lrGQaqg62vw8uTIS8242pggrnupimDn1pVK4JfhXMSrdiGijCa1fkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=p9ksJoRp95f7PlFbHwIyRMPpDKeA8eop3QczTiTwM5I=; b=AlfQlKZV
 qcRoroqJR4iTVy4z9ZXqbfLjezcInYcOwoGHcanXsBb6P4+ojJrWStsrkWvOe12a
 1CuXUnSPXaJfpYNRxjzmGfcLUwlhL+spH4EcgvN8gv9Xc1jILUJRysrfTRFSr0xI
 0AghczMyxRXG+HAsmNhla3yUAdwnZVOmcvdvEUh0BRaekNipf4hM9b7S2t1uw4PG
 oN3aq68Eeo2CdCGC8gglEsRmFudh+9OFvwwhhNIFzMunWdxDi0H4I56lkLHWSNCK
 HJEhz9rA8VBM8Ex1CUoZ/GXW5HvuWdwP1KR8TYEKb5et1QhXCQ6R/Kj/IRMHPLDf
 GZvIzJmUZUBaKA==
X-ME-Sender: <xms:8jVKXuK9HKg9G6WO2NREAqZOPZCX8hmCXdNeEnTVWwRYWpEtp-R08Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
 ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:8jVKXvh2bpMMC8HC_kQnNmyw7Lm3xPXPyJE7f3uUA8Igk4vsn8qSEQ>
 <xmx:8jVKXn32rdAvcrLynx_oIv794La04keS7WNjTjRV7-oN9eGE76TCbw>
 <xmx:8jVKXmZvnwHAVVAjFGhKULDsskpS2SfDCpFese_5F_hfq-cLyFGkpg>
 <xmx:8jVKXsaWB5rtxRbfRjy0WwXVusYWIB3S3_-jHErYgoffgIJ_6DLQJg>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 69ECA3280059;
 Mon, 17 Feb 2020 01:42:57 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>,
 =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date: Mon, 17 Feb 2020 00:42:27 -0600
Message-Id: <20200217064250.15516-12-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Samuel Holland <samuel@sholland.org>
Subject: [alsa-devel] [RFC PATCH 11/34] ASoC: sun8i-codec: Enforce parameter
	symmetry
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

Each of the codec's DAIs has a single set of parameters for its clock,
channels, and word size. If both capture and playback are active on a
single DAI, they must use compatible parameters. Set the symmetric_*
flags in the DAI driver to enforce this.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index bf12f5199e96..3d5ed2f4575a 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -534,6 +534,9 @@ static struct snd_soc_dai_driver sun8i_codec_dai = {
 	},
 	/* pcm operations */
 	.ops = &sun8i_codec_dai_ops,
+	.symmetric_rates = 1,
+	.symmetric_channels = 1,
+	.symmetric_samplebits = 1,
 };
 
 static const struct snd_soc_component_driver sun8i_soc_component = {
-- 
2.24.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
