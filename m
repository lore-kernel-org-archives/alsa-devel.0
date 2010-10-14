From: <vm.rod25@gmail.com>
Subject: [PATCH v3 4/9] davinci: McASP configuration for
	Omapl138-Hawkboard
Date: Thu, 14 Oct 2010 12:22:39 -0500
Message-ID: <1287076960-4435-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DC14103B86
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 19:21:47 +0200 (CEST)
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

This patch defines Pin Mux configuration for MacASP
used on the Hawkboard-L138 system in order to add Audio support

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
---
 arch/arm/mach-davinci/da850.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 63916b9..f033a0a 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -591,7 +591,7 @@ const short da850_cpgmac_pins[] __initdata = {
 const short da850_mcasp_pins[] __initdata = {
 	DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
 	DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
-	DA850_AXR_11, DA850_AXR_12,
+	DA850_AXR_11, DA850_AXR_12, DA850_AXR_13, DA850_AXR_14,
 	-1
 };
 
-- 
1.6.0.5
