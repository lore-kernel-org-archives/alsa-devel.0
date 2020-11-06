Return-Path: <SRS0=gYtK=EM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625BAC2D0A3
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:18:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237562075A
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H0xT0HMQ";
	dkim=temperror (0-bit key) header.d=sholland.org header.i=@sholland.org header.b="qP3Y7zh0";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L6eMSLRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237562075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A1B782B;
	Fri,  6 Nov 2020 05:17:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A1B782B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604636289;
	bh=feS5rOxy7ZnXxOFu3lJ26cZI40qIWl0W+MPjSJT6Rdo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H0xT0HMQA3NtbmI7+A/nqaEi9ju9h1SCZ/CfWkTQbt1y/UgNbE5BsD4qZKe5Gyn3z
	 54BfVC7ibWxEgEwQjEiHC4/DuP7KoS/RW44cDv4b13i3VKYtvQDp463IWJvo35kog6
	 od7Qn9s1NA0mv1NnJ0RNGoRZuCMBP7+c3BlJUFGw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E50FF804DF;
	Fri,  6 Nov 2020 05:15:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7766EF800BA; Fri,  6 Nov 2020 05:15:29 +0100 (CET)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DA5BF800BA
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2020 05:15:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DA5BF800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="qP3Y7zh0"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="L6eMSLRs"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 4AD0558054B;
 Thu,  5 Nov 2020 23:15:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 05 Nov 2020 23:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=fM+mBIXLYcK3O
 mS1n9AWddTUKsKTi5ZEVIA4pgh+LXo=; b=qP3Y7zh0nuyqmDe2Zmj0O2CARqUzr
 b5necBApgGlt3XJEx8sOppxkmVH6WHv9YKvcFx72IMoF4xXX9MjhB2dSD5eyOPrC
 91urB2kA9sMtBhmI1WbiaAYeWzr2gBBXDenjS3+kh79Vvx8WB48yvoSGUokT5bVH
 Nm8RfYYSUjiXXlEFzMlZomCiiOim3vweKWg8TONRzeO+F28/CX1RZwKepwif7B/k
 DAYzqInnAiOJE0KcsUDDhyXnjNVtli18G3cjZYNxZM3ZOWxt2SGsXjaVA/uqPsBq
 XFxAyGQRRTVA/lH6/UfwdkHmMSla24T8T9LLqbc18eBN9tIA0M1RZCscQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=fM+mBIXLYcK3OmS1n9AWddTUKsKTi5ZEVIA4pgh+LXo=; b=L6eMSLRs
 wgjhVdUGJjWzbu1S/k0P+OasGaua9Rg7Vmww0ZnmML7PT3aJg6KcccEb90rpCWky
 z/fa/AQW4snqs10I4CUVYQt8TKmCe1sFaA2U3cYAytIWfsBjXSnpz/o/Yf/jWV9j
 5HncSId2x5BK0L/ROvME9hQqBF5gDF2k9N5Inf0sErRepkqLW0GKeM++/7HTk93j
 6cVllQwl1eMHNNuXOFDow2ajRiXvW/N+JofygYt9ZllvWat5oxKsW9JlDoaVtKNu
 e46MonYQN+kdbDtxafoCWrgUWqcDlLZaW9rnHbxpluW8ChDSd2+BX1PE+Eyxua5X
 jb2/7CdTRkbAJg==
X-ME-Sender: <xms:0s2kX5VE5Our2X_bgrzvAu4m8yxvMweaWLiXr_TUtmR0Lte2mJh4_Q>
 <xme:0s2kX5ktIT3Mnd4cwnio9Yf3kL2MdLUvkUdvHapGESjr_rcnTQUq_be6HScVzkipR
 aVolwi5DWDg0mXvUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgjedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
 gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:0s2kX1Y4hITkQLECWWP4VitUCx0NeUxTRzyPes9u4H0uOWPNgVo0JQ>
 <xmx:0s2kX8WsFP9waegg5_yVvcJJnmFMUjD6NEmSPnzfGfTnELlDJq_EOA>
 <xmx:0s2kXzlS5oZDZZ538XMargNqpCpIWwsDIjS8RILFhuDNOuuB93b6IQ>
 <xmx:082kX8iI8jM7-yVPGVLbJS5AuiR3fhjWC7IkW2ZeJMmAVq_WWZx1uA>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 21F333060060;
 Thu,  5 Nov 2020 23:15:14 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/7] ASoC: dt-bindings: sun8i-codec: Increase #sound-dai-cells
Date: Thu,  5 Nov 2020 22:15:07 -0600
Message-Id: <20201106041513.38481-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106041513.38481-1-samuel@sholland.org>
References: <20201106041513.38481-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Increase sound-dai-cells to 1 to allow using the DAIs in the codec
corresponding to AIF2 and AIF3.

The generic ASoC OF code supports a #sound-dai-cells value of 0 or 1
with no impact to the driver, so this is a backward-compatible change.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
index 67405e6d8168..1a2590f54b9b 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 properties:
   "#sound-dai-cells":
-    const: 0
+    const: 1
 
   compatible:
     oneOf:
-- 
2.26.2

