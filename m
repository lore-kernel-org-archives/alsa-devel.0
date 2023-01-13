Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1626EC54EBE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Jan 2023 06:24:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C998AA2F9;
	Fri, 13 Jan 2023 07:24:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C998AA2F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673591096;
	bh=i3sSStN6YGv2VD2iucXwcEXTNpiewt6+NgnJAHHwh6k=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=erDZksC6olFqsuQVUFqL8f/1SDIBjc6Ncdt67ELJYdQDcuYV7s2oVwxvmDwbRYbch
	 r/JLM04jT3VRzcUTFRGOIt3WvYCxRhCvswSSp6NIDItlnXJGeUquazicPs9maxEHyl
	 6nUlRDJ6rYd27OYq8jeGXlHH/DG4VJrSGGCyGIhI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 799DCF803DC;
	Fri, 13 Jan 2023 07:24:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A341F8026D; Fri, 13 Jan 2023 07:24:04 +0100 (CET)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30256F802E8
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2023 07:24:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30256F802E8
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=UPm4fiFN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=pE5vHsweVi9sw+XFtbQOjd8ZmlFDvTP0hqXRxtOPgdI=; b=UPm4fiFNqG828TmS+12Rola8gO
 eqHlHcKs17NiINhJVso8pQaJLXAawxXFCKuLlP7HRjKIjJN2ZXqL/cl3jIEux4plqaePmjKWoVYai
 QlJizCpTb7yVhQxL/QJWjJ37KmX8qVxA7Rot4hYXsbm50Ukgoehbb75E6d7ZbOqa0NS55yCF1vD12
 hTv+9XqO7HKABDyO220qXwurWxcmgcwBxl9/GRlKpDUCPyGWGMAz1KKVnajqZK+KC0juYlZ2W8UlT
 3xv/hB5gSMNo2fI0kJb/GNm6IFqQb0S3ZTYgJMi4xbRkGq5u2ysaI8Zc1eFL7BGimSK1gVFq75foe
 LEx3cuRw==;
Received: from [2001:4bb8:181:656b:9509:7d20:8d39:f895] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pGDTf-000lNa-NO; Fri, 13 Jan 2023 06:23:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/22] usb: remove the dead USB_OHCI_SH option
Date: Fri, 13 Jan 2023 07:23:19 +0100
Message-Id: <20230113062339.1909087-3-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113062339.1909087-1-hch@lst.de>
References: <20230113062339.1909087-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-sh@vger.kernel.org, alsa-devel@alsa-project.org,
 dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-arch@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-rtc@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

USB_OHCI_SH is a dummy option that never builds any code, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/host/Kconfig | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 8d799d23c476e1..ca5f657c092cf4 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -548,17 +548,6 @@ config USB_OHCI_HCD_SSB
 
 	  If unsure, say N.
 
-config USB_OHCI_SH
-	bool "OHCI support for SuperH USB controller (DEPRECATED)"
-	depends on SUPERH || COMPILE_TEST
-	select USB_OHCI_HCD_PLATFORM
-	help
-	  This option is deprecated now and the driver was removed, use
-	  USB_OHCI_HCD_PLATFORM instead.
-
-	  Enables support for the on-chip OHCI controller on the SuperH.
-	  If you use the PCI OHCI controller, this option is not necessary.
-
 config USB_OHCI_EXYNOS
 	tristate "OHCI support for Samsung S5P/Exynos SoC Series"
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
-- 
2.39.0

