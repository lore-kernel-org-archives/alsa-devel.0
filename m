From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH 1/2] ALSA: core: fix NULL checking in
	snd_pcm_plug_client_size()
Date: Tue, 13 Nov 2012 17:12:11 -0500
Message-ID: <1352844732-4764-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 48E382615FC
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 23:12:19 +0100 (CET)
Received: by mail-qc0-f179.google.com with SMTP id b14so4483793qcs.38
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 14:12:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Xi Wang <xi.wang@gmail.com>
List-Id: alsa-devel@alsa-project.org

The dereference snd_pcm_plug_stream(plug) should come after the NULL
check snd_BUG_ON(!plug).

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 sound/core/oss/pcm_plugin.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index 71cc3dd..f0d7b15 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -199,12 +199,13 @@ int snd_pcm_plugin_free(struct snd_pcm_plugin *plugin)
 snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *plug, snd_pcm_uframes_t drv_frames)
 {
 	struct snd_pcm_plugin *plugin, *plugin_prev, *plugin_next;
-	int stream = snd_pcm_plug_stream(plug);
+	int stream;
 
 	if (snd_BUG_ON(!plug))
 		return -ENXIO;
 	if (drv_frames == 0)
 		return 0;
+	stream = snd_pcm_plug_stream(plug);
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		plugin = snd_pcm_plug_last(plug);
 		while (plugin && drv_frames > 0) {
-- 
1.7.10.4
