Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298E3C64EC4
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Feb 2023 14:59:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA925F5B;
	Fri, 17 Feb 2023 15:58:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA925F5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676645982;
	bh=0UB/yNRyEFAth1fC7YRsGnLMIl3uLDgmVErqPdBGiIw=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=B8h+E/WuvYzM3u8tYizgbP10Op1KeYnbD4L3WuVq+7QTv5PiiaDfDXNKu/D5IctOr
	 2uyb6WFOBiD6aBmCWz/wvIRH9u20rHGP2oilW+jQ6yQ67VcNJzuZm6pGWfpo1+ws7a
	 /gZv1Fb7NlNTm+qiB5L7VXk/zq0BIIAMNZTlYVVg=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C222F80552;
	Fri, 17 Feb 2023 15:57:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 190F5F8053D; Fri, 17 Feb 2023 15:57:15 +0100 (CET)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::228])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9083BF80171
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2023 15:57:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9083BF80171
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=M5Qt2ZWa
Received: (Authenticated sender: herve.codina@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPA id D4AE31BF210;
	Fri, 17 Feb 2023 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1676645821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeJZjqKMo5SsRic4MTk2gtRIeqiw1QrtK/miER8ISu8=;
	b=M5Qt2ZWaClgXW7oeSEdTWhKz9zm0QDoLPYzerXs6jjnufix1h6rMIvG5m8Rm8Eu2EH2V0n
	/zQQL+uAF9EPi6bahw+8kMwjaSU4MFXo1ST6aTMU+seJKXKUMyuz1OaGKBwxeofoVXCox/
	aweLeH9c2jYzz6j6wnogflTvkr4oXAVM3u38xajoQqOHTakzXlOR67P+FuRN3OmZVSOAfy
	A7s8ixLoHEufIHsDSPysYc1xSL3Fu+wapk74x3ri6aX0U05PkdmHWgEgAKYM/+fL7cAiFa
	bqHhyRmtc0arJmYntYsokQjDhpj8d/Nf5shY/QqXQLsm5dH6hXS7k5HJoW8iVQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v6 03/10] MAINTAINERS: add the Freescale TSA controller entry
Date: Fri, 17 Feb 2023 15:56:38 +0100
Message-Id: <20230217145645.1768659-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217145645.1768659-1-herve.codina@bootlin.com>
References: <20230217145645.1768659-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2XHBEMBRWMYCJEKCW4XRS2ZYEHHRVL35
X-Message-ID-Hash: 2XHBEMBRWMYCJEKCW4XRS2ZYEHHRVL35
X-MailFrom: herve.codina@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2XHBEMBRWMYCJEKCW4XRS2ZYEHHRVL35/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

After contributing the driver, add myself as the maintainer
for the Freescale TSA controller.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..097a80d6623b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8372,6 +8372,15 @@ S:	Maintained
 F:	drivers/soc/fsl/qe/
 F:	include/soc/fsl/qe/
 
+FREESCALE QUICC ENGINE TSA DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
+F:	drivers/soc/fsl/qe/tsa.c
+F:	drivers/soc/fsl/qe/tsa.h
+F:	include/dt-bindings/soc/cpm1-fsl,tsa.h
+
 FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
 M:	Li Yang <leoyang.li@nxp.com>
 L:	netdev@vger.kernel.org
-- 
2.39.1

