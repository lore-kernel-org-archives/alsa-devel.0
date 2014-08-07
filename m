From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] MAINTAINERS: Add i.MX maintainers and paths to
	Freescale ASoC entry
Date: Thu,  7 Aug 2014 10:48:59 +0100
Message-ID: <1407404939-14950-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 097CA2650C3
 for <alsa-devel@alsa-project.org>; Thu,  7 Aug 2014 11:49:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <Guangyu.Chen@freescale.com>, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

There's several new i.MX specific controllers, try to help make sure they
get reviewed by the people working on them.

Signed-off-by: Mark Brown <broonie@linaro.org>
---

Is this OK wiht everyone?

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e0d24dcb122..2078bd3232a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3835,10 +3835,13 @@ F:	drivers/tty/serial/ucc_uart.c
 
 FREESCALE SOC SOUND DRIVERS
 M:	Timur Tabi <timur@tabi.org>
+M:	Nicolin Chen <Guangyu.Chen@freescale.com>
+M:	Xiubo Li <Li.Xiubo@freescale.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	sound/soc/fsl/fsl*
+F:	sound/soc/fsl/imx*
 F:	sound/soc/fsl/mpc8610_hpcd.c
 
 FREEVXFS FILESYSTEM
-- 
2.0.1
