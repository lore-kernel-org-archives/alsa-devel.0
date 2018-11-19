From: Jenny TC <jenny.tc@intel.com>
Subject: [PATCH 2/2] ASoC: dmic: introduce module_param
	wakeup_delay
Date: Mon, 19 Nov 2018 22:23:06 +0530
Message-ID: <1542646386-9225-3-git-send-email-jenny.tc@intel.com>
References: <1542646386-9225-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 551A026792F
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2018 17:53:24 +0100 (CET)
In-Reply-To: <1542646386-9225-1-git-send-email-jenny.tc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jairaj Arava <jairaj.arava@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harshapriya N <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Jenny TC <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

Introducing a module param for wakeup_delay in order to
align with modeswitch_delay parameter. With this change, both
wakeup_delay and modeswitch_delay parameters can be passed
as module parameters.

Signed-off-by: Jenny TC <jenny.tc@intel.com>
---
 sound/soc/codecs/dmic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index d8b7da7..b007ec6 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -33,6 +33,9 @@
 static int modeswitch_delay;
 module_param(modeswitch_delay, uint, 0644);
 
+static int wakeup_delay;
+module_param(wakeup_delay, uint, 0644);
+
 struct dmic {
 	struct gpio_desc *gpio_en;
 	int wakeup_delay;
@@ -114,6 +117,8 @@ static int dmic_component_probe(struct snd_soc_component *component)
 				 &dmic->wakeup_delay);
 	device_property_read_u32(component->dev, "modeswitch-delay-ms",
 				 &dmic->modeswitch_delay);
+	if (wakeup_delay)
+		dmic->wakeup_delay  = wakeup_delay;
 	if (modeswitch_delay)
 		dmic->modeswitch_delay  = modeswitch_delay;
 
-- 
1.9.1
