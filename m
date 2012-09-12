From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 06/11] ARM: OMAP4: hwmod_data: Add resource
	names to McPDM memory ranges
Date: Wed, 12 Sep 2012 14:47:02 +0300
Message-ID: <1347450427-27627-7-git-send-email-peter.ujfalusi@ti.com>
References: <1347450427-27627-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
 [74.125.149.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B5E5C2616B4
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 13:47:00 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so2399929obb.38
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 04:46:59 -0700 (PDT)
In-Reply-To: <1347450427-27627-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Ricardo Neri <ricardo.neri@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

To help the driver to get the correct memory range to access McPDM
registers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 242aee4..f65251e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5059,6 +5059,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__mcbsp4 = {
 
 static struct omap_hwmod_addr_space omap44xx_mcpdm_addrs[] = {
 	{
+		.name		= "mpu",
 		.pa_start	= 0x40132000,
 		.pa_end		= 0x4013207f,
 		.flags		= ADDR_TYPE_RT
@@ -5077,6 +5078,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcpdm = {
 
 static struct omap_hwmod_addr_space omap44xx_mcpdm_dma_addrs[] = {
 	{
+		.name		= "dma",
 		.pa_start	= 0x49032000,
 		.pa_end		= 0x4903207f,
 		.flags		= ADDR_TYPE_RT
-- 
1.7.12
