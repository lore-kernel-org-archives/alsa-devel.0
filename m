From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Add missing error checks in OSS
	emulation plugin builder
Date: Thu,  4 Jan 2018 18:03:49 +0100
Message-ID: <20180104170349.23697-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2882E267900
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 18:03:51 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C3245ACA6
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 17:03:51 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

In the OSS emulation plugin builder where the frame size is parsed in
the plugin chain, some places miss the possible errors returned from
the plugin src_ or dst_frames callback.

This patch papers over such places.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_plugin.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index cadc93792868..85a56af104bd 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -592,18 +592,26 @@ snd_pcm_sframes_t snd_pcm_plug_write_transfer(struct snd_pcm_substream *plug, st
 	snd_pcm_sframes_t frames = size;
 
 	plugin = snd_pcm_plug_first(plug);
-	while (plugin && frames > 0) {
+	while (plugin) {
+		if (frames <= 0)
+			return frames;
 		if ((next = plugin->next) != NULL) {
 			snd_pcm_sframes_t frames1 = frames;
-			if (plugin->dst_frames)
+			if (plugin->dst_frames) {
 				frames1 = plugin->dst_frames(plugin, frames);
+				if (frames1 <= 0)
+					return frames1;
+			}
 			if ((err = next->client_channels(next, frames1, &dst_channels)) < 0) {
 				return err;
 			}
 			if (err != frames1) {
 				frames = err;
-				if (plugin->src_frames)
+				if (plugin->src_frames) {
 					frames = plugin->src_frames(plugin, frames1);
+					if (frames <= 0)
+						return frames;
+				}
 			}
 		} else
 			dst_channels = NULL;
-- 
2.15.1
