From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Remove unused DAPM_DOUBLE control
	types
Date: Tue, 14 Dec 2010 17:53:21 +0000
Message-ID: <1292349202-25538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 72AC610380E
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 18:53:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There are no users of these and it's not clear what they would do given
the mono flow modelling which DAPM does. If need arises we can add them
again.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

May as well do this anyway, regardless of the fate of patch 2/2 but
patch 2/2 will remove the implementation of stereo controls so depends
on this one.

 include/sound/soc-dapm.h |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 2f76a51..aef975f 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -227,13 +227,6 @@
 	.info = snd_soc_info_volsw, \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
 	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
-#define SOC_DAPM_DOUBLE(xname, reg, shift_left, shift_right, max, invert, \
-	power) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-	.info = snd_soc_info_volsw, \
- 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
- 	.private_value = (reg) | ((shift_left) << 8) | ((shift_right) << 12) |\
-		((max) << 16) | ((invert) << 24) }
 #define SOC_DAPM_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
@@ -241,15 +234,6 @@
 	.tlv.p = (tlv_array), \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
 	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
-#define SOC_DAPM_DOUBLE_TLV(xname, reg, shift_left, shift_right, max, invert, \
-	power, tlv_array) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
-	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
-	.private_value = (reg) | ((shift_left) << 8) | ((shift_right) << 12) |\
-		((max) << 16) | ((invert) << 24) }
 #define SOC_DAPM_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_enum_double, \
-- 
1.7.1
