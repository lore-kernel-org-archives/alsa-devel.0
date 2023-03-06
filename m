Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411DBC678D4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Mar 2023 16:22:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14674114C;
	Mon,  6 Mar 2023 17:21:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14674114C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678119742;
	bh=7yvPKEPPY2trPJojJttHG2D6pJ/Cfqn8LSF5gHmHV8g=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qdvv26GHWCFTao5isoez4nPssAsb6eIkocbXMMX3jIarLUr4ykhMYQC0TSMjZj6F5
	 t3OKe5x4Cu/8w7U8Irhx0r8X7bXC5tgFqHY7qC6mRfpNhiUiMsvGL4T7vAlb9XGYJ7
	 p1AcW+No2oPkIrS97iFuOzq2vn6Ys4Pn5+uZWSws=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C5FF0F805AD;
	Mon,  6 Mar 2023 17:18:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14DB7F80578; Mon,  6 Mar 2023 17:18:41 +0100 (CET)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 37C10F80568
	for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2023 17:18:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37C10F80568
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=A9IaaHjP
Received: (Authenticated sender: herve.codina@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPA id D5978240019;
	Mon,  6 Mar 2023 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1678119518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rNmzbQSxlgYysBCGQaz+s+0O1Jf7YARbWX5NfsCdPg=;
	b=A9IaaHjPm9mDIMgj5GmW+lfUhh98MKEkEQmQ97lICaF3eG0rcnC8A8DAnL/x+FlylFHPND
	Ki18ko4wXO3S+X1mg/QiC4BV/ZJ31kzegDVabxZNGLH7Qbn9WG1chs7Qoofi3UvrA99z54
	FHgoQZgJ3FnUS66mEwkJFNWkpbao4reE9I+vdZrh7d0TZ32ZAy8HQahmsD+YMIB88OPlES
	pU8ZQdRXFtJLaayHGdCFNYm05AXsMNt2WJE3zSwLY7e8PFJiBv26rsES8C6TUMXFkyClpx
	a09EUogixKD+OktcXn+vlIVh9lAkf88GzzNNjkgwqq9TocKpEN4UazpdiO0agA==
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
Subject: [PATCH v7 10/10] MAINTAINERS: add the Freescale QMC audio entry
Date: Mon,  6 Mar 2023 17:17:54 +0100
Message-Id: <20230306161754.89146-11-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306161754.89146-1-herve.codina@bootlin.com>
References: <20230306161754.89146-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GAW5RPYCXECYZGIGAQQOVOZBIHUR5T4F
X-Message-ID-Hash: GAW5RPYCXECYZGIGAQQOVOZBIHUR5T4F
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GAW5RPYCXECYZGIGAQQOVOZBIHUR5T4F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

After contributing the component, add myself as the maintainer for the
Freescale QMC audio ASoC component.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5597d402fbd8..a6e6b70cf8bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8315,6 +8315,14 @@ F:	sound/soc/fsl/fsl*
 F:	sound/soc/fsl/imx*
 F:	sound/soc/fsl/mpc8610_hpcd.c
 
+FREESCALE SOC SOUND QMC DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
+F:	sound/soc/fsl/fsl_qmc_audio.c
+
 FREESCALE USB PERIPHERAL DRIVERS
 M:	Li Yang <leoyang.li@nxp.com>
 L:	linux-usb@vger.kernel.org
-- 
2.39.2

