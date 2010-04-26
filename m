From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Mon, 26 Apr 2010 15:49:40 -0500
Message-ID: <1272314980-23679-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B7CD24716
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 22:50:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, kumar.gala@freescale.com
List-Id: alsa-devel@alsa-project.org

An upcoming change in the architecture of ALSA SoC (ASoC) will require the
MPC8610 HPCD's ASoC fabric driver to register as a standard platform driver.
Therefore, we need to call platform_device_register_simple() from the board's
platform code.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Kumar, the ASoC mainters are willing to pick up this patch, but they want an
ACK from you first.  Or, you could pick it up, since by itself it's harmless.

 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 5abe137..66afff3 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -98,6 +98,9 @@ static int __init mpc8610_declare_of_platform_devices(void)
 	/* Without this call, the SSI device driver won't get probed. */
 	of_platform_bus_probe(NULL, mpc8610_ids, NULL);
 
+	/* Register the platform device for the ASoC fabric driver */
+	platform_device_register_simple("snd-soc-mpc8610-hpcd", 0, NULL, 0);
+
 	return 0;
 }
 machine_device_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);
-- 
1.6.5
