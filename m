From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH V2 1/8] platform: Increase platform name size
Date: Fri, 26 Jul 2013 19:06:45 +0530
Message-ID: <1374845812-7803-2-git-send-email-padma.v@samsung.com>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, padma.v@samsung.com, padma.kvr@gmail.com
Cc: broonie@kernel.org, kgene.kim@samsung.com, abrestic@chromium.org, tomasz.figa@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch increases the platform name size from 20 to 30.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 include/linux/mod_devicetable.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index b62d4af..f67b5d5 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -478,7 +478,7 @@ struct dmi_system_id {
 #define DMI_MATCH(a, b)	{ .slot = a, .substr = b }
 #define DMI_EXACT_MATCH(a, b)	{ .slot = a, .substr = b, .exact_match = 1 }
 
-#define PLATFORM_NAME_SIZE	20
+#define PLATFORM_NAME_SIZE	30
 #define PLATFORM_MODULE_PREFIX	"platform:"
 
 struct platform_device_id {
-- 
1.7.4.4
