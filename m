From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 1/2] MAINTAINERS: add atmel ssc driver
	maintainer entry
Date: Sun, 28 Sep 2014 09:57:18 +0800
Message-ID: <1411869439-2719-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DVREDG02.corp.atmel.com (nasmtp01.atmel.com [192.199.1.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 81379260539
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 03:57:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, nicolas.ferre@atmel.com
Cc: Bo Shen <voice.shen@atmel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3705430..c004e6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1703,6 +1703,13 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
 F:	drivers/spi/spi-atmel.*
 
+ATMEL SSC DRIVER
+M:	Bo Shen <voice.shen@atmel.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/misc/atmel-ssc.c
+F:	include/linux/atmel-ssc.h
+
 ATMEL Timer Counter (TC) AND CLOCKSOURCE DRIVERS
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.1.0.24.g4109c28
