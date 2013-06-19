From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/11] ASoC: wm_hubs: Use SOC_SINGLE_EXT()
	instead of open-coding it
Date: Wed, 19 Jun 2013 19:34:01 +0200
Message-ID: <1371663243-10032-9-git-send-email-lars@metafoo.de>
References: <1371663243-10032-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-226.synserver.de (smtp-out-227.synserver.de
 [212.40.185.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 8221D261B2F
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
 sound/soc/codecs/wm_hubs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index f5d81b9..2d9e099 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -693,10 +693,8 @@ void wm_hubs_update_class_w(struct snd_soc_codec *codec)
 EXPORT_SYMBOL_GPL(wm_hubs_update_class_w);
 
 #define WM_HUBS_SINGLE_W(xname, reg, shift, max, invert) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_dapm_get_volsw, .put = class_w_put_volsw, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+	SOC_SINGLE_EXT(xname, reg, shift, max, invert, \
+		snd_soc_dapm_get_volsw, class_w_put_volsw)
 
 static int class_w_put_volsw(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
-- 
1.8.0
