From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 3/3] speaker-test: Show out-of-chmap channels
	as Unknown
Date: Sun, 10 Nov 2013 20:29:19 +0200
Message-ID: <1384108159-3421-3-git-send-email-anssi.hannula@iki.fi>
References: <527F34D3.40209@iki.fi>
 <1384108159-3421-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id A1D1A261A0C
 for <alsa-devel@alsa-project.org>; Sun, 10 Nov 2013 19:29:40 +0100 (CET)
In-Reply-To: <1384108159-3421-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Olivier Langlois <olivier@trillion01.com>, =?UTF-8?q?Peter=20Fr=C3=BChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

Currently speaker-test falls back to ALSA default channel names for
channels out-of-chmap.

This causes e.g. the 4th channel of
$ speaker-test -c4 -Dhdmi -m "FR,FL,FC"
to be shown as "Rear Right".

Change the code to show such channels as Unknown instead, similar to
when snd_pcm_chmap_long_name() does not know the name.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 speaker-test/speaker-test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 82cc3b1..8ab5011 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -254,8 +254,10 @@ static int get_speaker_channel(int chn)
 static const char *get_channel_name(int chn)
 {
 #ifdef CONFIG_SUPPORT_CHMAP
-  if (channel_map && chn < channel_map->channels) {
-    const char *name = snd_pcm_chmap_long_name(channel_map->pos[chn]);
+  if (channel_map) {
+    const char *name = NULL;
+    if (chn < channel_map->channels)
+      name = snd_pcm_chmap_long_name(channel_map->pos[chn]);
     return name ? name : "Unknown";
   }
 #endif
-- 
1.8.1.5
