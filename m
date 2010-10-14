From: <vm.rod25@gmail.com>
Subject: [PATCH v3 6/9] davinci: MMC/SD and USB-OHCI
	configuration for Omapl138-Hawkboard
Date: Thu, 14 Oct 2010 12:23:00 -0500
Message-ID: <1287076980-4481-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id D0E3D103BB1
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 19:22:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: nsekhar@ti.com, alsa-devel@alsa-project.org, khasim@ti.com, caglarakyuz@gmail.com, sshtylyov@mvista.com
List-Id: alsa-devel@alsa-project.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch defines Pin Mux configuration to enable MMC/SD
and USB-OHCI on the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
---
 arch/arm/mach-davinci/da850.c            |    4 ++++
 arch/arm/mach-davinci/include/mach/mux.h |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index f033a0a..646e8b2 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -548,6 +548,10 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, GPIO2_15,	5,	0,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_0,		10,	28,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_1,		10,	24,	15,	8,	false)
+	MUX_CFG(DA850, GPIO3_12,	7,	12,	15,	8,	false)
+	MUX_CFG(DA850, GPIO3_13,	7,	8,	15,	8,	false)
+	MUX_CFG(DA850, GPIO2_4,		6,	12,	15,	8,	false)
+	MUX_CFG(DA850, GPIO6_13,	13,	8,	15,	8,	false)
 	MUX_CFG(DA850, RTC_ALARM,	0,	28,	15,	2,	false)
 #endif
 };
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index de11aac..f2c2117 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -913,6 +913,10 @@ enum davinci_da850_index {
 	DA850_GPIO2_15,
 	DA850_GPIO4_0,
 	DA850_GPIO4_1,
+	DA850_GPIO3_12,
+	DA850_GPIO3_13,
+	DA850_GPIO2_4,
+	DA850_GPIO6_13,
 	DA850_RTC_ALARM,
 };
 
-- 
1.6.0.5
