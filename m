Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65DCCA0ECA
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Sep 2023 09:53:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B04D8A4D;
	Tue, 12 Sep 2023 11:52:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B04D8A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694512405;
	bh=NuDSgU/za9u2Y0vgU21V368MH+0liwIWfP/620NIUoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YiIiIPRxfPtDzl27/WHLq/2bncCBE/7dwSinKErRVhfixXtES9+sCWNgVgonJ78Wn
	 XCM6guUdyZERKeSbri5QEUdQWfz3nmgZK3pBoh9BuefUcBUIDZFf9CKIK7WMh4w2FZ
	 YGrt8Nap+PZxekg9VvCrF5Ilf7hj3Oa1bVfjPojg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8199DF8055A; Tue, 12 Sep 2023 11:52:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1286CF80425;
	Tue, 12 Sep 2023 11:52:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B91FF80425; Tue, 12 Sep 2023 11:52:04 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 93A29F800AA
	for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2023 11:52:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93A29F800AA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=K+nnYXVg
Received: by mail.gandi.net (Postfix) with ESMTPA id 5A722240009;
	Tue, 12 Sep 2023 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1694512320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScPjzuZaLLYh2lcosF7mjC3LbbKogbqWDUhQ8RkAceU=;
	b=K+nnYXVgVTeIYLV1BYZk8yVPM7a2nPu/2JA6GWMyyv0Za8enlurHjBH7plSt2lkrUaQgFx
	0f+eic3JBBgKxtWXmU15F2NOL2ZoHFXm8dROGgnxxRWdTKbO53xzFHJjRrH2cKPixxWiIQ
	X0H50mqA/O7gee/qxhpcScSAQrz6oC5amb4tHHTsy3EQ30w3liig4hh60CmVmm0cSjrsOm
	3+A4lbr4FIsGWAyRl0hBgn4ip8FNO3Untij7ggUFAU3Q5C3z+B+ux/Tq3eCFHsmlxJXwfW
	EQItj5FZbLmxsodLOd0QDPWT6RUBUWUp7yQWKgN05HapEUcrPwoojI25LbtKJQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	Simon Horman <horms@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 07/31] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc: Add
 'additionalProperties: false' in child nodes
Date: Tue, 12 Sep 2023 10:14:58 +0200
Message-ID: <20230912081527.208499-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912081527.208499-1-herve.codina@bootlin.com>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: SRXA6CD2YQP5WEW2I62NVYH5ULYVL56L
X-Message-ID-Hash: SRXA6CD2YQP5WEW2I62NVYH5ULYVL56L
X-MailFrom: herve.codina@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SRXA6CD2YQP5WEW2I62NVYH5ULYVL56L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Additional properties in child node should not be allowed.

Prevent them adding 'additionalProperties: false'

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
index 450a0354cb1d..82d9beb48e00 100644
--- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
@@ -64,6 +64,7 @@ patternProperties:
     description:
       A channel managed by this controller
     type: object
+    additionalProperties: false
 
     properties:
       reg:
-- 
2.41.0

