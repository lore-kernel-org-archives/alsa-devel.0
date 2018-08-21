From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 3/3] ASoC: Intel: cht-bsw-rt5672: Add
	key-mappings for the headset buttons
Date: Tue, 21 Aug 2018 13:43:37 +0200
Message-ID: <20180821114337.11361-3-hdegoede@redhat.com>
References: <20180821114337.11361-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 60BBD26766C
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 13:43:44 +0200 (CEST)
In-Reply-To: <20180821114337.11361-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Having the headset buttons send BTN_0, BTN_1 and BTN_2 events is not
really useful. Add mappings to PLAYPAUSE VOLUME_UP and VOLUME_DOWN like
we do in other Intel machine drivers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index e5aa13058dd7..e054318185ea 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -16,6 +16,7 @@
  *  General Public License for more details.
  */
 
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -212,6 +213,10 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
         if (ret)
                 return ret;
 
+	snd_jack_set_key(ctx->headset.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(ctx->headset.jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+	snd_jack_set_key(ctx->headset.jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+
 	rt5670_set_jack_detect(component, &ctx->headset);
 	if (ctx->mclk) {
 		/*
-- 
2.18.0
