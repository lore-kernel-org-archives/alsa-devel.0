From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 10/18] ARM: ux500: Enable HIGHMEM on all mop500
	platforms
Date: Fri, 27 Jul 2012 13:45:54 +0100
Message-ID: <1343393162-11938-11-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 71F5E265F7F
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 14:46:21 +0200 (CEST)
Received: by mail-we0-f179.google.com with SMTP id x10so1840692wey.38
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 05:46:23 -0700 (PDT)
In-Reply-To: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

The current kernel commandline for ux500 based devices includes
hard-coded allocations for things like mali and hwmem, which
actually run over lowmem. Here we enable highmem in order to
avoid memory corruption errors.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index c013bbf..f51c351 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -28,6 +28,7 @@ config MACH_MOP500
 	select I2C
 	select I2C_NOMADIK
 	select SOC_BUS
+	select HIGHMEM
 	help
 	  Include support for the MOP500 development platform.
 
-- 
1.7.9.5
