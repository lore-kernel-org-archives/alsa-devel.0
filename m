From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/10] ASoC: Add SOC_SINGLE_EXT_TLV control type
Date: Wed, 11 Jun 2008 13:47:13 +0100
Message-ID: <1213188435-1986-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1213188435-1986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2DE652482F
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 14:47:18 +0200 (CEST)
In-Reply-To: <1213188435-1986-7-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Montour <mail@mmontour.net>
List-Id: alsa-devel@alsa-project.org

From: Mike Montour <mail@mmontour.net>

Signed-off-by: Mike Montour <mail@mmontour.net>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 56d2224..1f5c621 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -100,6 +100,15 @@
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmask, xinvert) }
+#define SOC_SINGLE_EXT_TLV(xname, xreg, xshift, xmask, xinvert,\
+	 xhandler_get, xhandler_put, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmask, xinvert) }
 #define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_bool_ext, \
-- 
1.5.5.3
