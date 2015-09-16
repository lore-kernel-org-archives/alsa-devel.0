From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Add SOC_SINGLE_RANGE_EXT_TLV macro
Date: Wed, 16 Sep 2015 13:59:42 +0100
Message-ID: <1442408383-31682-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1442408383-31682-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 07E40261555
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 15:23:19 +0200 (CEST)
In-Reply-To: <1442408383-31682-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Add a version of the SOC_SINGLE_RANGE_TLV macro that allows a custom get
and put to be specified.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 884e728..9ffa285 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -226,6 +226,18 @@
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert, 0) }
+#define SOC_SINGLE_RANGE_EXT_TLV(xname, xreg, xshift, xmin, xmax, xinvert, \
+				 xhandler_get, xhandler_put, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw_range, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg, .rreg = xreg, .shift = xshift, \
+		 .rshift = xshift, .min = xmin, .max = xmax, \
+		 .platform_max = xmax, .invert = xinvert} }
 #define SOC_DOUBLE_EXT_TLV(xname, xreg, shift_left, shift_right, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-- 
1.7.2.5
