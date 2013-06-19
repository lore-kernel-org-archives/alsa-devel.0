From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/11] ASoC: wm8995: Use SOC_SINGLE_EXT()
	instead of open-coding it
Date: Wed, 19 Jun 2013 19:34:00 +0200
Message-ID: <1371663243-10032-8-git-send-email-lars@metafoo.de>
References: <1371663243-10032-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-226.synserver.de (smtp-out-227.synserver.de
 [212.40.185.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 8527026262D
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2013 19:34:03 +0200 (CEST)
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
 sound/soc/codecs/wm8995.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8995.h b/sound/soc/codecs/wm8995.h
index 5642121..508ad27 100644
--- a/sound/soc/codecs/wm8995.h
+++ b/sound/soc/codecs/wm8995.h
@@ -4237,11 +4237,8 @@
 #define WM8995_SPK2_MUTE_SEQ1_WIDTH                  8	/* SPK2_MUTE_SEQ1 - [7:0] */
 
 #define WM8995_CLASS_W_SWITCH(xname, reg, shift, max, invert) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_dapm_get_volsw, .put = wm8995_put_class_w, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) \
-}
+	SOC_SINGLE_EXT(xname, reg, shift, max, invert, \
+		snd_soc_dapm_get_volsw, wm8995_put_class_w)
 
 struct wm8995_reg_access {
 	u16 read;
-- 
1.8.0
