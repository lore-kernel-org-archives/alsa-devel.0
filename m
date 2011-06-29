From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 3/5] ASoC: atmel-ssc: dmaengine usage switch depending on cpu
Date: Wed, 29 Jun 2011 20:00:17 +0200
Message-ID: <bb630ee8242145fa926ee0b0147e0851d3e5b34f.1309368631.git.nicolas.ferre@atmel.com>
References: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
In-Reply-To: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 include/linux/atmel-ssc.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
index 2bab4b4..52b4c20 100644
--- a/include/linux/atmel-ssc.h
+++ b/include/linux/atmel-ssc.h
@@ -3,6 +3,7 @@
=20
 #include <linux/platform_device.h>
 #include <linux/list.h>
+#include <mach/cpu.h>
=20
 struct ssc_device {
 	struct list_head	list;
@@ -310,4 +311,6 @@ void ssc_free(struct ssc_device *ssc);
 #define ssc_readl(base, reg)		__raw_readl(base + SSC_##reg)
 #define ssc_writel(base, reg, value)	__raw_writel((value), base + SSC_=
##reg)
=20
+#define ssc_use_dmaengine()	cpu_is_at91sam9x5()
+
 #endif /* __INCLUDE_ATMEL_SSC_H */
--=20
1.7.3
