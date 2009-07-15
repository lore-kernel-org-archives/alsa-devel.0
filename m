From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 2/3] ASoC: add SOC_DOUBLE_R_EXT_TLV control type
Date: Wed, 15 Jul 2009 20:33:50 +0900
Message-ID: <4A5DBE9E.8030301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id C6C1910382B
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jul 2009 13:34:46 +0200 (CEST)
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KMT00C90MSE2S@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 15 Jul 2009 20:33:51 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KMT00L7XMSE45@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 15 Jul 2009 20:33:50 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This is a macro for double controls with special callback function and
TLV. The SOC_DOUBLE_R_EXT_TLV needs two registers and one shift for
double controls.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 include/sound/soc.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 795a6b4..756fb59 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -146,6 +146,17 @@
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = xreg, .shift = shift_left, .rshift = shift_right, \
 		.max = xmax, .invert = xinvert} }
+#define SOC_DOUBLE_R_EXT_TLV(xname, reg_left, reg_right, xshift, xmax, xinvert,\
+	 xhandler_get, xhandler_put, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw_2r, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
+		.max = xmax, .invert = xinvert} }
 #define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_bool_ext, \
-- 
1.6.0.4
