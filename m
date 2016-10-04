From: sathyanarayana.nujella@intel.com
Subject: [PATCH] ASoC: Intel: report JACK_LINEOUT event
Date: Tue,  4 Oct 2016 10:33:20 -0700
Message-ID: <20161004173320.1556-1-sathyanarayana.nujella@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B8ACB261B36
 for <alsa-devel@alsa-project.org>; Tue,  4 Oct 2016 19:33:27 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, yang.a.fang@intel.com, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, harshapriya.n@intel.com
List-Id: alsa-devel@alsa-project.org

From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

This patch updates Jack type bitmask to include SND_JACK_LINEOUT while
creating a new jack, so that LINEOUT events are reported properly.

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 6532b8f..865a21e 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -130,8 +130,8 @@ static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 	 */
 	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
 			SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-			SND_JACK_BTN_2 | SND_JACK_BTN_3, &broxton_headset,
-			NULL, 0);
+			SND_JACK_BTN_2 | SND_JACK_BTN_3 | SND_JACK_LINEOUT,
+			&broxton_headset, NULL, 0);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
-- 
2.8.4
