From: <vm.rod25@gmail.com>
Subject: [PATCH v6 4/9] davinci: McASP configuration for
	Omapl138-Hawkboard
Date: Fri, 29 Oct 2010 10:10:40 -0500
Message-ID: <1288365045-2709-5-git-send-email-vm.rod25@gmail.com>
References: <1288365045-2709-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from victor-desktop (unknown [200.52.114.70])
	by alsa0.perex.cz (Postfix) with ESMTP id A583124491
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 17:10:48 +0200 (CEST)
In-Reply-To: <1288365045-2709-1-git-send-email-vm.rod25@gmail.com>
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
Cc: alsa-devel@alsa-project.org, sshtylyov@mvista.com, khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, khasim@ti.com, caglarakyuz@gmail.com, lrg@slimlogic.co.uk
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
1.7.0.4
