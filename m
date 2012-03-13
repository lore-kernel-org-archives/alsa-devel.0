From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 07/16] ASoC: core: Add macro for hwdep range of
	regs control
Date: Tue, 13 Mar 2012 16:11:34 +0100
Message-ID: <1331651503-16917-8-git-send-email-ola.o.lilja@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog106.obsmtp.com (eu1sys200aog106.obsmtp.com
	[207.126.144.121])
	by alsa0.perex.cz (Postfix) with ESMTP id 8880B104324
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:12:18 +0100 (CET)
In-Reply-To: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
List-Id: alsa-devel@alsa-project.org

From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>

Added convenience macro for hwdep range of register controls
that maps a range of consecutive registers exposed as
a multiple value control.

This is specifically useful for hardware that exposes for instance
a range of filter parameters as a range of registers that with
this could be written and read back in one single ioctl operation.

SOC_HWDEP_MULTIPLE_1R  Multiple hwdep signed control values spans one register each

Signed-off-by: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
---
 include/sound/soc.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4acdd35..644167d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -237,6 +237,12 @@
 	.private_value =  \
 		SOC_SINGLE_VALUE_S4R(reg0, reg1, reg2, reg3, \
 			reg4, reg5, reg6, reg7, 1, min, max, invert) }
+#define SOC_HWDEP_MULTIPLE_1R(xname, reg0, count, min, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_HWDEP, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.info = snd_soc_info_xr_sx, .get = snd_soc_get_m1r_sx, \
+	.put = snd_soc_put_m1r_sx, \
+	.private_value = SOC_SINGLE_VALUE_S1R(reg0, count, min, max, invert) }
 
 #define SOC_ENUM_STROBE(xname, xenum) \
 	SOC_ENUM_EXT(xname, xenum, \
-- 
1.7.8.3
