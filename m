From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/8] ALSA: x86: Use snd_pcm_stop_xrun() for
	connection / disconnection paths
Date: Wed, 15 Feb 2017 22:29:30 +0100
Message-ID: <20170215212936.697-3-tiwai@suse.de>
References: <20170215212936.697-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E9FCF266E4C
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 22:29:42 +0100 (CET)
In-Reply-To: <20170215212936.697-1-tiwai@suse.de>
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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

This seems more friendly to user-space, as it's notified at least as
an error, instead of forcibly moving the PCM state to SETUP out of
sudden.

Moreover, snd_pcm_stop() needs an extra PCM spinlock I forgot, while
snd_pcm_stop_xrun() takes the spinlock by itself.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index a30ca03e49ae..a7343f2d2730 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1378,7 +1378,7 @@ static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 		dev_dbg(intelhaddata->dev,
 			"Force to stop the active stream by disconnection\n");
 		/* Set runtime->state to hw_params done */
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
+		snd_pcm_stop_xrun(substream);
 		had_substream_put(intelhaddata);
 	}
 
@@ -1414,7 +1414,7 @@ static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 
 	/* Report to above ALSA layer */
 	if (substream)
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
+		snd_pcm_stop_xrun(substream);
 
  out:
 	snd_jack_report(intelhaddata->jack, 0);
-- 
2.11.1
