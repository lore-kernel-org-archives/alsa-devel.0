From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v4] ASoC: soc-compress: Cancel delayed power
	down if needed
Date: Mon, 11 Mar 2013 09:25:26 +0000
Message-ID: <20130311092526.GA2141@opensource.wolfsonmicro.com>
References: <1359128299-17161-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130126085234.GB30594@opensource.wolfsonmicro.com>
 <20130308165252.GA22868@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E50F26086D
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 10:25:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130308165252.GA22868@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: vinod.koul@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

When a new stream is being opened it is necessary to cancel any delayed
power down of the audio.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index b5b3db7..44bad67 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -198,6 +198,7 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
@@ -220,6 +221,10 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 			goto out;
 	}
 
+	/* cancel any delayed stream shutdown that is pending */
+	rtd->pop_wait = 0;
+	cancel_delayed_work_sync(&rtd->delayed_work);
+
 	snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
 				SND_SOC_DAPM_STREAM_START);
 
-- 
1.7.2.5
