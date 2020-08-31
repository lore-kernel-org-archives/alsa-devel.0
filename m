Return-Path: <SRS0=wuVw=CJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE9EC433E6
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 03:54:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776F020720
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 03:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IC9l1z5/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="YisBLVkB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IkQVEbgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776F020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19473184E;
	Mon, 31 Aug 2020 05:53:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19473184E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598846055;
	bh=uK7ALvoPYTQ4JLYD4gvvm4nNLuRXplJ1ByPBRgGMA5k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IC9l1z5/F+Cw1MiebLWFJ4Ou64MiLqg0D+Xq8haG0X4yzfvgtrQ68VkMPBz8iZZut
	 IIx1uCI5Ww/lHDf01Iq8yj5buaIq+CZ1dzS2sWH+1CRmuIGCUe3Y5aJnGyf2tlZqmL
	 ASCNHWEUPHXzi/nd2/2+qX0VAz2sY24qSrBTVV5U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A17BF802F7;
	Mon, 31 Aug 2020 05:49:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E844F802D2; Mon, 31 Aug 2020 05:49:20 +0200 (CEST)
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65CD9F802A2
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 05:49:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65CD9F802A2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="YisBLVkB"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="IkQVEbgY"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 44ADB58055B;
 Sun, 30 Aug 2020 23:48:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 30 Aug 2020 23:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=7CWxrO6xNUhIK
 /C5Oja7RYJCP9GppzvCcosOoPA19Mc=; b=YisBLVkB9UDkvdPp5J4DFa3sh2GDE
 gfJQFzNaU8B+F0P9O3cwFUPtkd9+bgjPZC0EmyyZB7MzkLTFESyE01bQhTHxppeO
 BYbNDvaAh6BCRIU24sf4tsqlu3UTg58qrS43WSYQvyjkfvcNT1BqJLIcQYgq+2i+
 8D6r22oJENhqMQQ/OiH1JIMLTHLPtvg2jtQcwVs87Ivtgc17niu5NRliA4TRNr4J
 FRfIqkTZPAuLgD419kx94QizpxnV/s4xnMw+8op4NrfIKrmQAas8XONhLI+O3cUp
 TGQesfgyxpaNCZHABQRF7KPaBNiA1Tj7aaDiUUrzMdzGvlPNOsZz4DrcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=7CWxrO6xNUhIK/C5Oja7RYJCP9GppzvCcosOoPA19Mc=; b=IkQVEbgY
 8QOtBuZU1CuOmXgSKUDtOPcwRXL5HLUD7LxZ4+LtQyW24Ofpoc+IhSbnSQNhvZXh
 CiJY//d0LYzR9yJukQw66fFXiiuq++AnkdpZ3u/YjSS5WVIHXlq0pPTOCzjndkmj
 IAb7ZfT8Ky4cuQgGoM7JHBD96x8jrwNuD0G7A/Zx+Rec6lK81qK2M3GWcuN0tsQK
 ryCCpVyr2zOwDZHLQUNrdqVzMEsQz+ujiydvitm2q6t5LimWsaZMJJwLqN0AZ+jq
 C44RvokeliPu4uPXTO4GYLoCY/6TJ18K43P1Su6YzxkbmIhhqqAj0lVj5pminhCb
 7mViLeGAnjVLYw==
X-ME-Sender: <xms:KXNMXz5Q1sPzHvlT50FAeWx_cT9wB9EDILvNT9Q8JbybYP3rC4H73A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedgjeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
 gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
 iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:KXNMX476dfN0udxnRqQhwu8cxp9AOD7TRmuC1GGQQnJ0G29DiEavtA>
 <xmx:KXNMX6ean75SWk6Q3Bmd9wqm5XmexRVC6y5OkktsV3KbuBLkA1eaQQ>
 <xmx:KXNMX0JPvjf7OOh2ufzBJB4oUr34Ov-pvpijQWs1jnEj86hXfMHrCA>
 <xmx:KXNMX0pEq3eHuAEItbR_yHdmXidOAaJpZEelUB7QyudumU5qb4XAEQ>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id A9D743280060;
 Sun, 30 Aug 2020 23:48:56 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 6/9] ASoC: sun8i-codec: Fix field bit number indentation
Date: Sun, 30 Aug 2020 22:48:49 -0500
Message-Id: <20200831034852.18841-7-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831034852.18841-1-samuel@sholland.org>
References: <20200831034852.18841-1-samuel@sholland.org>
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

Several fields have inconsistent indentation, presumably because the
patch "looked correct" due to the additional "+" character at the
beginning of the line.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 4218a00a9aba..62d4b1b44e76 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -68,15 +68,15 @@
 #define SUN8I_ADC_DIG_CTRL_ADOUT_DTS			2
 #define SUN8I_ADC_DIG_CTRL_ADOUT_DLY			1
 #define SUN8I_DAC_DIG_CTRL				0x120
-#define SUN8I_DAC_DIG_CTRL_ENDA			15
+#define SUN8I_DAC_DIG_CTRL_ENDA				15
 #define SUN8I_DAC_MXR_SRC				0x130
-#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA0L	15
-#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA1L	14
-#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF2DACL	13
+#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA0L		15
+#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA1L		14
+#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF2DACL		13
 #define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_ADCL		12
-#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA0R	11
-#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R	10
-#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR	9
+#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA0R		11
+#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R		10
+#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR		9
 #define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_ADCR		8
 
 #define SUN8I_SYS_SR_CTRL_AIF1_FS_MASK		GENMASK(15, 12)
-- 
2.26.2

