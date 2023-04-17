Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D853C77B7A
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Apr 2023 17:18:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A5D8DF3;
	Mon, 17 Apr 2023 19:17:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A5D8DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681751928;
	bh=XDU4jlyzmdQW4/QfGeW1fbimLHGUhYg1t2ws2GQbQ4M=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:Cc:From;
	b=eQ7YM6WMXKG72NC1I0sFQ76UXzcIXEO0xEpa+SDBN9j+01GQCF339fXKxqsvPKgyQ
	 g7VUc/3PnlY5o5NKUjywZb7SgFLdaWXy2C9Vdz5PmjuH11/MyNH+K5/qYIVtZyKew+
	 lM3j+ToGr9oqIBjtDVNwid2xidAo2ScdFpiLKjTw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 056DEF80552;
	Mon, 17 Apr 2023 19:16:31 +0200 (CEST)
To: Herve Codina <herve.codina@bootlin.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v6 7/7] MAINTAINERS: Add the Lantiq PEF2256 driver entry
Date: Mon, 17 Apr 2023 19:16:01 +0200
In-Reply-To: <20230417171601.74656-1-herve.codina@bootlin.com>
References: <20230417171601.74656-1-herve.codina@bootlin.com>
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DKPV2MCTQTMUUVV44NZSNYJZVXUKQC4B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
MIME-Version: 1.0
Message-ID: 
 <168175178971.26.14882333995549062928@mailman-core.alsa-project.org>
From: Herve Codina via Alsa-devel <alsa-devel@alsa-project.org>
Reply-To: Herve Codina <herve.codina@bootlin.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: message/rfc822
Content-Disposition: inline

Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F3CBF8025D; Mon, 17 Apr 2023 19:16:23 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on alsa1.perex.cz
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.6
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8EE6EF8025D
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2023 19:16:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EE6EF8025D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=XL1wwpJC
Received: (Authenticated sender: herve.codina@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPA id EB463C000D;
	Mon, 17 Apr 2023 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1681751780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRdAwLRTSaUIQFjNu8nfQaWlxXGiOc76su+qD7ZXN2E=;
	b=XL1wwpJCVqEHV1SH6hiI/gFOw0ISz/OnuC7oCiDhUuFp2MmZgVaZdl/tJ8sIRvIBNIq8s1
	m0wINFDG9MvnLIErOQknMPqvEO/bL7WAFEL4fWXi4/m6BTXB8rFJlMovHhcdkglCwwEDTK
	q/8WJhZwLUcMNS/j228Kh+awXJB32hwZJsLrcoMQnild0eGxE11HJapE7ZjFagbJM7N+Lr
	Ka5sUwT1ztpxA4s0ZCPfw4lK5pkXyBLGKk9QEYaaCnXgMVOiAl3V94C8GYbK0Xo3n71Up+
	jl8vB4hF3VvZF4UXqeWAOvEeta32GZcG5XfCEAaFxQYWA8ZEXWh9rYjZRzkQhA==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v6 7/7] MAINTAINERS: Add the Lantiq PEF2256 driver entry
Date: Mon, 17 Apr 2023 19:16:01 +0200
Message-Id: <20230417171601.74656-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417171601.74656-1-herve.codina@bootlin.com>
References: <20230417171601.74656-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DKPV2MCTQTMUUVV44NZSNYJZVXUKQC4B
X-Message-ID-Hash: DKPV2MCTQTMUUVV44NZSNYJZVXUKQC4B
X-MailFrom: herve.codina@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DKPV2MCTQTMUUVV44NZSNYJZVXUKQC4B/>
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
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcb69242cd19..dc579a8b5562 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11651,6 +11651,18 @@ S:	Maintained
 F:	arch/mips/lantiq
 F:	drivers/soc/lantiq
 
+LANTIQ PEF2256 DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256
+F:	Documentation/devicetree/bindings/mfd/lantiq,pef2256.yaml
+F:	drivers/mfd/pef2256-regs.h
+F:	drivers/mfd/pef2256.c
+F:	drivers/pinctrl/pinctrl-pef2256-regs.h
+F:	drivers/pinctrl/pinctrl-pef2256.c
+F:	include/linux/mfd/pef2256.h
+F:	sound/soc/codecs/pef2256-codec.c
+
 LASI 53c700 driver for PARISC
 M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
 L:	linux-scsi@vger.kernel.org
-- 
2.39.2

