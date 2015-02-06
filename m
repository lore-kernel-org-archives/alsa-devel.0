From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH v2 1/3] m32r: add definition of ioremap_wc to io.h
Date: Fri,  6 Feb 2015 19:15:26 +0530
Message-ID: <1423230328-6721-2-git-send-email-a.kesavan@samsung.com>
References: <1423230328-6721-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423230328-6721-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, hirokazu.takata.wj@renesas.com
Cc: catalin.marinas@arm.com, Will.Deacon@arm.com, heiko@sntech.de, shc_work@mail.ru, p.zabel@pengutronix.de, nicoleotsuka@gmail.com, padma.v@samsung.com, arnd@arndb.de, alsa-devel@alsa-project.org, shawn.guo@linaro.org, bcousson@baylibre.com, tony@atomide.com, kernel@pengutronix.de, kgene@kernel.org
List-Id: alsa-devel@alsa-project.org

Before adding a resource managed ioremap_wc function, we need
to have ioremap_wc defined for m32r to prevent build errors.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/m32r/include/asm/io.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m32r/include/asm/io.h b/arch/m32r/include/asm/io.h
index 6e7787f..9cc00db 100644
--- a/arch/m32r/include/asm/io.h
+++ b/arch/m32r/include/asm/io.h
@@ -67,6 +67,7 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 
 extern void iounmap(volatile void __iomem *addr);
 #define ioremap_nocache(off,size) ioremap(off,size)
+#define ioremap_wc ioremap_nocache
 
 /*
  * IO bus memory addresses are also 1:1 with the physical address
-- 
1.7.9.5
