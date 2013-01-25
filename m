From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: soc-compress: Cancel delayed power
	down if needed
Date: Fri, 25 Jan 2013 16:56:28 +0000
Message-ID: <20130125165628.GA14418@opensource.wolfsonmicro.com>
References: <1359128299-17161-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 114A1265094
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2013 17:56:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1359128299-17161-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: vinod.koul@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

When a new stream is being opened it is necessary to cancel any delayed
power down of the audio.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Apologies the last version was incorrectly generated from the
wrong tree and used codec_dai instead of rtd for the pop_wait.


 sound/soc/soc-compress.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index f9fb112..a3cc6f7 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -216,6 +216,12 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 			goto out;
 	}
 
+	/* cancel any delayed stream shutdown that is pending */
+	if (rtd->pop_wait) {
+		rtd->pop_wait = 0;
+		cancel_delayed_work(&rtd->delayed_work);
+	}
+
 	snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
 				SND_SOC_DAPM_STREAM_START);
 
-- 
1.7.2.5
