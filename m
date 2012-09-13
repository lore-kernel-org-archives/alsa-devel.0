From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH 1/7] powerpc/52xx: define FSL_SOC
Date: Thu, 13 Sep 2012 17:43:10 -0400
Message-ID: <1347572596-37540-2-git-send-email-emillbrandt@dekaresearch.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 30773265344
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 23:43:27 +0200 (CEST)
In-Reply-To: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anatolij Gustschin <agust@denx.de>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

mpc52xx socs need to have FSL_SOC defined to build their drivers (i2c-mpc, ASoC)

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 90f4496..fb35944 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -1,6 +1,7 @@
 config PPC_MPC52xx
 	bool "52xx-based boards"
 	depends on 6xx
+	select FSL_SOC
 	select PPC_CLOCK
 	select PPC_PCI_CHOICE
 
-- 
1.7.2.5
