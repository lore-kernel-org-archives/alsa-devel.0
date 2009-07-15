From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 1/3] ASoC: add SOC_DOUBLE_EXT_TLV control type
Date: Wed, 15 Jul 2009 20:33:47 +0900
Message-ID: <4A5DBE9B.5020502@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id E1550103806
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jul 2009 13:33:51 +0200 (CEST)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KMT005RZMSB0T@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 15 Jul 2009 20:33:47 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KMT00GRTMSBOT@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 15 Jul 2009 20:33:47 +0900 (KST)
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
TLV. The SOC_DOUBLE_EXT_TLV needs one register and two shifts for double
controls.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 include/sound/soc.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 94fcc65..795a6b4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -135,6 +135,17 @@
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) }
+#define SOC_DOUBLE_EXT_TLV(xname, xreg, shift_left, shift_right, xmax, xinvert,\
+	 xhandler_get, xhandler_put, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg, .shift = shift_left, .rshift = shift_right, \
+		.max = xmax, .invert = xinvert} }
 #define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_bool_ext, \
-- 
1.6.0.4
