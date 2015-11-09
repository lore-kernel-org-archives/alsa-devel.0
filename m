From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/4] ASoC: core: Adds support for cpu loopback
	dai_link
Date: Mon,  9 Nov 2015 23:19:59 +0530
Message-ID: <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B0E2426155E
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 18:46:39 +0100 (CET)
In-Reply-To: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

soc_link_dai_widgets() creates codec-codec loopback link which
allows DPCM to trigger these links and program the parameters for
these links These links are:

	Codec1 Tx (Pb)  ----------> Rx Codec2 (Cap)
	Codec2 Tx (Cap) <---------- Tx Codec1 (Pb)

But as we try to model a CPU based loops for non host links like
modem to codec loop, the above mapping gets wrong as:

	CPU Tx (Pb)  -----------> Codec Tx (Pb)
	CPU Rx (Cap) <----------- Codec Rx (Cap)

So we add a new flag to handle above scenario and link widgets as
depecited above

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc.h  |  3 +++
 sound/soc/soc-core.c | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a8b4b9c8b1d2..e93927789d98 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -992,6 +992,9 @@ struct snd_soc_dai_link {
 	const struct snd_soc_pcm_stream *params;
 	unsigned int num_params;
 
+	/* flag to create cpu based loopback link */
+	unsigned int cpu_loopback:1;
+
 	unsigned int dai_fmt;           /* format to set on init */
 
 	enum snd_soc_dpcm_trigger trigger[2]; /* trigger type for DPCM */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d5e0bcbafb70..40077fbd2495 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1290,8 +1290,14 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
 		dev_warn(card->dev, "ASoC: Multiple codecs not supported yet\n");
 
 	/* link the DAI widgets */
-	sink = codec_dai->playback_widget;
-	source = cpu_dai->capture_widget;
+	if (!dai_link->cpu_loopback) {
+		sink = codec_dai->playback_widget;
+		source = cpu_dai->capture_widget;
+	} else {
+		sink = codec_dai->playback_widget;
+		source = cpu_dai->playback_widget;
+	}
+
 	if (sink && source) {
 		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
 					   dai_link->num_params,
@@ -1303,8 +1309,14 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
 		}
 	}
 
-	sink = cpu_dai->playback_widget;
-	source = codec_dai->capture_widget;
+	if (!dai_link->cpu_loopback) {
+		sink = cpu_dai->playback_widget;
+		source = codec_dai->capture_widget;
+	} else {
+		sink = cpu_dai->capture_widget;
+		source = codec_dai->capture_widget;
+	}
+
 	if (sink && source) {
 		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
 					   dai_link->num_params,
-- 
1.9.1
