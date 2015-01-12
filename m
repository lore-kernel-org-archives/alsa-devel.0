From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: rme*: Use snd_pcm_format_t
Date: Mon, 12 Jan 2015 16:59:44 +0100
Message-ID: <1421078384-18202-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C4A6C260537
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 16:59:53 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AF32CAB09
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 15:59:49 +0000 (UTC)
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

Fix sparse warnings below by using snd_pcm_format_t properly:
   sound/pci/rme32.c:682:60: sparse: incorrect type in argument 2 (different base types)
  sound/pci/rme96.c:1006:69: sparse: incorrect type in argument 2 (different base types)
   .....

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme32.c | 2 +-
 sound/pci/rme96.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 6c60dcd2e5a1..1a7affad7164 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -632,7 +632,7 @@ snd_rme32_setframelog(struct rme32 * rme32, int n_channels, int is_playback)
 	}
 }
 
-static int snd_rme32_setformat(struct rme32 * rme32, int format)
+static int snd_rme32_setformat(struct rme32 *rme32, snd_pcm_format_t format)
 {
 	switch (format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index e33e79eadf83..236ac1d48184 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -922,8 +922,7 @@ snd_rme96_setframelog(struct rme96 *rme96,
 }
 
 static int
-snd_rme96_playback_setformat(struct rme96 *rme96,
-			     int format)
+snd_rme96_playback_setformat(struct rme96 *rme96, snd_pcm_format_t format)
 {
 	switch (format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -940,8 +939,7 @@ snd_rme96_playback_setformat(struct rme96 *rme96,
 }
 
 static int
-snd_rme96_capture_setformat(struct rme96 *rme96,
-			    int format)
+snd_rme96_capture_setformat(struct rme96 *rme96, snd_pcm_format_t format)
 {
 	switch (format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-- 
2.2.1
