From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/8] ALSA: x86: Stop the stream when buffer is
	processed after disconnection
Date: Wed, 15 Feb 2017 22:29:34 +0100
Message-ID: <20170215212936.697-7-tiwai@suse.de>
References: <20170215212936.697-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 37252266E55
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 22:29:44 +0100 (CET)
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

This shouldn't happen, but just to be sure...

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 97362233c326..2ed0a34bc19e 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -961,19 +961,22 @@ static void had_process_buffer_done(struct snd_intelhad *intelhaddata)
 {
 	struct snd_pcm_substream *substream;
 
-	if (!intelhaddata->connected)
-		return; /* disconnected? - bail out */
-
 	substream = had_substream_get(intelhaddata);
 	if (!substream)
 		return; /* no stream? - bail out */
 
+	if (!intelhaddata->connected) {
+		snd_pcm_stop_xrun(substream);
+		goto out; /* disconnected? - bail out */
+	}
+
 	/* process or stop the stream */
 	if (had_process_ringbuf(substream, intelhaddata) < 0)
 		snd_pcm_stop_xrun(substream);
 	else
 		snd_pcm_period_elapsed(substream);
 
+ out:
 	had_substream_put(intelhaddata);
 }
 
-- 
2.11.1
