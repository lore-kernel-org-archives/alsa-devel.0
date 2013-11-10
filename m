From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 2/3] speaker-test: Always show chmap channel
	names if available
Date: Sun, 10 Nov 2013 20:29:18 +0200
Message-ID: <1384108159-3421-2-git-send-email-anssi.hannula@iki.fi>
References: <527F34D3.40209@iki.fi>
 <1384108159-3421-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id A2172261AD8
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

Currently speaker-test only uses channel names retrieved by
snd_pcm_chmap_long_name() when a channel map has been manually set.

However, the device may provide a default (or fixed) channel map that
differs from the traditional ALSA map, in which case wrong channel names
are shown.

Fix that by always using the name from the channel map when a channel
map is present.

Note that the names retrieved by snd_pcm_chmap_long_name() are not
currently localized via gettext.

Also note that Linux kernel HDMI driver reported wrong default channel
maps before 56cac413dd6d43af8355f5d1f90a199b540f73fc ("ALSA: hda - hdmi:
Fix reported channel map on common default layouts").

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 speaker-test/speaker-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 274007d..82cc3b1 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -254,7 +254,7 @@ static int get_speaker_channel(int chn)
 static const char *get_channel_name(int chn)
 {
 #ifdef CONFIG_SUPPORT_CHMAP
-  if (channel_map_set && chn < channel_map->channels) {
+  if (channel_map && chn < channel_map->channels) {
     const char *name = snd_pcm_chmap_long_name(channel_map->pos[chn]);
     return name ? name : "Unknown";
   }
-- 
1.8.1.5
