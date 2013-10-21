From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: dont call dapm_sync while reporting jack
	always
Date: Mon, 21 Oct 2013 19:02:07 +0530
Message-ID: <1382362327-26057-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9028726510F
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 16:25:50 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

While reporting the jack status snd_soc_jack_report() invokes snd_soc_dapm_sync()
always. This should be required when we have pins associated with jack and
reporting enables or disables these.
So add a check for this case

Change-Id: I671cd444d1b6610dcb83b28f7339477556373e5c
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-jack.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index c9f7953..9fd4ed8 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -65,6 +65,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 	struct snd_soc_codec *codec;
 	struct snd_soc_dapm_context *dapm;
 	struct snd_soc_jack_pin *pin;
+	unsigned int sync = 0;
 	int enable;
 
 	trace_snd_soc_jack_report(jack, mask, status);
@@ -92,12 +93,16 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 			snd_soc_dapm_enable_pin(dapm, pin->pin);
 		else
 			snd_soc_dapm_disable_pin(dapm, pin->pin);
+
+		/* we need to sync for this case only */
+		sync = 1;
 	}
 
 	/* Report before the DAPM sync to help users updating micbias status */
 	blocking_notifier_call_chain(&jack->notifier, jack->status, jack);
 
-	snd_soc_dapm_sync(dapm);
+	if (sync)
+		snd_soc_dapm_sync(dapm);
 
 	snd_jack_report(jack->jack, jack->status);
 
-- 
1.7.0.4
