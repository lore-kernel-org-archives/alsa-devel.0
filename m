From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 12/18] ASoC: Remove unused DAI format defines
Date: Tue,  5 May 2009 11:02:25 +0100
Message-ID: <1241517751-2634-12-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7BE124514
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 12:02:35 +0200 (CEST)
In-Reply-To: <20090505100123.GB2050@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The defines for TDM and synchronous clocks are not used - they are
mostly a legacy of the automatic clocking configuration.  TDM will
require configuration of the number of timeslots and which ones to use
so can't be fit into the DAI format and synchronous mode is handled by
symmetric_rates (and needs to be done by constraints rather than when
the DAI format is being configured).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index ea07b4b..a997c2c 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -45,24 +45,6 @@ struct snd_pcm_substream;
 #define SND_SOC_DAIFMT_GATED		(1 << 4) /* clock is gated */
 
 /*
- * DAI Left/Right Clocks.
- *
- * Specifies whether the DAI can support different samples for similtanious
- * playback and capture. This usually requires a seperate physical frame
- * clock for playback and capture.
- */
-#define SND_SOC_DAIFMT_SYNC		(0 << 5) /* Tx FRM = Rx FRM */
-#define SND_SOC_DAIFMT_ASYNC		(1 << 5) /* Tx FRM ~ Rx FRM */
-
-/*
- * TDM
- *
- * Time Division Multiplexing. Allows PCM data to be multplexed with other
- * data on the DAI.
- */
-#define SND_SOC_DAIFMT_TDM		(1 << 6)
-
-/*
  * DAI hardware signal inversions.
  *
  * Specifies whether the DAI can also support inverted clocks for the specified
-- 
1.6.2.4
