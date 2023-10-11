Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A89CD98F3
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Oct 2023 06:24:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 684D81655;
	Wed, 11 Oct 2023 08:23:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 684D81655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697005453;
	bh=UAiwOEWMzokbHVZ+qMJND2TPvtmDc3JJ26Nv/ny1wiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Wl4CHehRcgA3KX7AKg6CYmIiDaItpd7Z7YEzIn/DitFGoKqq3q8XC82AZqh0cnEK+
	 WTrHga1GY7xwQvH3UNY/sjxahCwWitCBiS2Tv3zKNH3iy1uHz9+KywXmcte1adK6j7
	 IFWl27xDS3sDyyyhhEgh7rShBhIZrKxVppTv9uHo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CEB70F806C2; Wed, 11 Oct 2023 08:17:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 98294F806CA;
	Wed, 11 Oct 2023 08:17:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3BA8FF8065A; Wed, 11 Oct 2023 08:17:08 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6CD68F80673
	for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2023 08:16:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6CD68F80673
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=HGPWbcBv
Received: by mail.gandi.net (Postfix) with ESMTPA id 9E273E0009;
	Wed, 11 Oct 2023 06:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697004988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eP8so5+40OVF0V/I6f05agR/9uxTfpFGxdMPV+noKD8=;
	b=HGPWbcBvOUusl9kp0Egn9GwxwT+raZZAa1UUOGqKBuXzJVTnbkh3Y55ge+SDjFvBqetb9f
	PO99icTfBy1+WiKEwsyFKtlEAZWqlIhctwe7pH0O+4/g9qVIJ+v3AbFTYL3vu6Faqn9VEV
	Ir0HFflwYVBady/HoTe9LjWIquwg4f0zXNdIy1QXG+UEJzGpBuhln7ClGo+2QoZ9cnlbv3
	SRnmipImpV6O1hUWEEjnE9BgENAtGTtPGGqnurm/sLs2p4nmaeEBwuOugTw54n46dpWWUw
	rZgm2yz+JeGJBXh/dGUpjf3lrX2lqhGtrH+Cn5dCKX+Qj8T+y3hxIJarRPjZKg==
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
Subject: [PATCH v8 28/30] MAINTAINERS: Add the Lantiq PEF2256 driver entry
Date: Wed, 11 Oct 2023 08:14:32 +0200
Message-ID: <20231011061437.64213-29-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011061437.64213-1-herve.codina@bootlin.com>
References: <20231011061437.64213-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
Message-ID-Hash: 66JN2JTA6KICT5YY5I6AS2ZOQH4L74SR
X-Message-ID-Hash: 66JN2JTA6KICT5YY5I6AS2ZOQH4L74SR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/66JN2JTA6KICT5YY5I6AS2ZOQH4L74SR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

After contributing the driver, add myself as the maintainer for the
Lantiq PEF2256 driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b987f2c8633..d8f2433e326e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11876,6 +11876,14 @@ S:	Maintained
 F:	arch/mips/lantiq
 F:	drivers/soc/lantiq
 
+LANTIQ PEF2256 DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
+F:	drivers/net/wan/framer/pef2256/
+F:	drivers/pinctrl/pinctrl-pef2256.c
+F:	include/linux/framer/pef2256.h
+
 LASI 53c700 driver for PARISC
 M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
 L:	linux-scsi@vger.kernel.org
-- 
2.41.0

