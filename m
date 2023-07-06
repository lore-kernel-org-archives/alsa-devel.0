Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54D5EB64D9
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Jul 2023 11:43:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52D543E8;
	Thu,  6 Jul 2023 13:42:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52D543E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688643815;
	bh=PDaBkm0mutatLEzbOdwB+GrYXFNvhxPQKs/G1MYGr0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Oq5Ait9y8YJHJvm+jWcZHa/KggnXYGhyHsaxuPsLNnF3kIdt5gbu7W7qzC3RwRBGU
	 IC+i2o+Hs+NiZloJSHCb1S9rydz5w08TX7WHiLOItrObDoPQjSpAE6IfplXhHTus6I
	 WwXu7W1sC6bqzAGJysu/6rj7wx6OBulVvsMY16O0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9233F80551; Thu,  6 Jul 2023 13:42:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EC3DEF80153;
	Thu,  6 Jul 2023 13:42:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F37AF8025F; Thu,  6 Jul 2023 13:42:15 +0200 (CEST)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DC5F8F800E4
	for <alsa-devel@alsa-project.org>; Thu,  6 Jul 2023 13:42:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC5F8F800E4
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5979:7b6f:39a:b9cb])
	by laurent.telenet-ops.be with bizsmtp
	id Hni62A00445Xpxs01ni6ha; Thu, 06 Jul 2023 13:42:08 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1qHNN3-000fav-Hy;
	Thu, 06 Jul 2023 13:42:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1qHNN7-000QkI-Td;
	Thu, 06 Jul 2023 13:42:05 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] regmap: REGMAP_SLIMBUS should select REGMAP
Date: Thu,  6 Jul 2023 13:42:03 +0200
Message-Id: 
 <7519324a34015e1c046227269409fef688889f4f.1688643442.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688643442.git.geert@linux-m68k.org>
References: <cover.1688643442.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: T6SOFED6PJ5D6A72T4HSW7OJKWUCH235
X-Message-ID-Hash: T6SOFED6PJ5D6A72T4HSW7OJKWUCH235
X-MailFrom: geert@linux-m68k.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T6SOFED6PJ5D6A72T4HSW7OJKWUCH235/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

If CONFIG_SND_SOC_WCD934X=y, CONFIG_COMPILE_TEST=y,
CONFIG_MFD_WCD934X=n, CONFIG_REGMAP=n:

    sound/soc/codecs/wcd934x.c:518:38: error: array type has incomplete element type ‘struct regmap_range_cfg’
      518 | static const struct regmap_range_cfg wcd934x_ifc_ranges[] = {
	  |                                      ^~~~~~~~~~~~~~~~~~

Fix this by making REGMAP_SLIMBUS select REGMAP.

Drop the selection of REGMAP by MFD_WCD934X, as this is not needed
(now both REGMAP_SLIMBUS and REGMAP_IRQ select REGMAP).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/base/regmap/Kconfig | 1 +
 drivers/mfd/Kconfig         | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index e25cc619c75de3d9..c3a260ed4e864959 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -34,6 +34,7 @@ config REGMAP_I2C
 config REGMAP_SLIMBUS
 	tristate
 	depends on SLIMBUS
+	select REGMAP
 
 config REGMAP_SPI
 	tristate
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0b6af476f554a191..5857dad2c64828fa 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2121,7 +2121,6 @@ config MFD_STMFX
 config MFD_WCD934X
 	tristate "Support for WCD9340/WCD9341 Codec"
 	depends on SLIMBUS
-	select REGMAP
 	select REGMAP_SLIMBUS
 	select REGMAP_IRQ
 	select MFD_CORE
-- 
2.34.1

