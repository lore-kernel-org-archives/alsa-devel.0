From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/11] ASoC: wm8991: Use SOC_SINGLE_EXT_TLV()
	instead of open-coding it
Date: Wed, 19 Jun 2013 19:33:58 +0200
Message-ID: <1371663243-10032-6-git-send-email-lars@metafoo.de>
References: <1371663243-10032-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-226.synserver.de (smtp-out-227.synserver.de
 [212.40.185.227])
 by alsa0.perex.cz (Postfix) with ESMTP id D33B42625EF
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2013 19:33:56 +0200 (CEST)
In-Reply-To: <1371663243-10032-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8991.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8991.h b/sound/soc/codecs/wm8991.h
index 8a942ef..07707d8 100644
--- a/sound/soc/codecs/wm8991.h
+++ b/sound/soc/codecs/wm8991.h
@@ -822,12 +822,7 @@
 
 #define SOC_WM899X_OUTPGA_SINGLE_R_TLV(xname, reg, shift, max, invert,\
 					 tlv_array) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
-		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
-	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw, .put = wm899x_outpga_put_volsw_vu, \
-	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert) }
+	SOC_SINGLE_EXT_TLV(xname, reg, shift, max, invert, \
+		snd_soc_get_volsw, wm899x_outpga_put_volsw_vu, tlv_array)
 
 #endif /* _WM8991_H */
-- 
1.8.0
