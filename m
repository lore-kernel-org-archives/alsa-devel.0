From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 3/9] pcm: handle negative values from
	snd_pcm_mmap_hw_avail
Date: Sun, 14 Sep 2014 00:30:15 +0600
Message-ID: <1410633021-20395-4-git-send-email-patrakov@gmail.com>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 19C62261B02
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 20:30:53 +0200 (CEST)
Received: by mail-lb0-f179.google.com with SMTP id p9so2540507lbv.10
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 11:30:52 -0700 (PDT)
In-Reply-To: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Such negative values can happen when an underrun happens and xrun
detection is disabled. Another situation is if the device updated the
pointer before alsa-lib has a chance to detect the xrun.

The problem is that these negative values could propagate to the
snd_pcm_rewindable return value, where it is specified that negative
returns must be interpreted as error codes and not as negative amount of
samples.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/pcm/pcm_dmix.c   |  2 +-
 src/pcm/pcm_dshare.c |  4 +---
 src/pcm/pcm_hw.c     |  2 +-
 src/pcm/pcm_ioplug.c |  2 +-
 src/pcm/pcm_local.h  | 18 ++++++++++++++++++
 src/pcm/pcm_plugin.c |  2 +-
 6 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index ffde12a..babde6a 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -661,7 +661,7 @@ static int snd_pcm_dmix_pause(snd_pcm_t *pcm ATTRIBUTE_UNUSED, int enable ATTRIB
 
 static snd_pcm_sframes_t snd_pcm_dmix_rewindable(snd_pcm_t *pcm)
 {
-	return snd_pcm_mmap_hw_avail(pcm);
+	return snd_pcm_mmap_playback_hw_rewindable(pcm);
 }
 
 static snd_pcm_sframes_t snd_pcm_dmix_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index f1a1a1d..020e6f7 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -412,7 +412,7 @@ static int snd_pcm_dshare_pause(snd_pcm_t *pcm ATTRIBUTE_UNUSED, int enable ATTR
 
 static snd_pcm_sframes_t snd_pcm_dshare_rewindable(snd_pcm_t *pcm)
 {
-	return snd_pcm_mmap_playback_hw_avail(pcm);
+	return snd_pcm_mmap_playback_hw_rewindable(pcm);
 }
 
 static snd_pcm_sframes_t snd_pcm_dshare_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
@@ -420,8 +420,6 @@ static snd_pcm_sframes_t snd_pcm_dshare_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t
 	snd_pcm_sframes_t avail;
 
 	avail = snd_pcm_dshare_rewindable(pcm);
-	if (avail < 0)
-		return 0;
 	if (frames > (snd_pcm_uframes_t)avail)
 		frames = avail;
 	snd_pcm_mmap_appl_backward(pcm, frames);
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 74cff67..c34b766 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -659,7 +659,7 @@ static int snd_pcm_hw_pause(snd_pcm_t *pcm, int enable)
 
 static snd_pcm_sframes_t snd_pcm_hw_rewindable(snd_pcm_t *pcm)
 {
-	return snd_pcm_mmap_hw_avail(pcm);
+	return snd_pcm_mmap_hw_rewindable(pcm);
 }
 
 static snd_pcm_sframes_t snd_pcm_hw_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index 85a8891..fe9347c 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -503,7 +503,7 @@ static int snd_pcm_ioplug_pause(snd_pcm_t *pcm, int enable)
 
 static snd_pcm_sframes_t snd_pcm_ioplug_rewindable(snd_pcm_t *pcm)
 {
-	return snd_pcm_mmap_hw_avail(pcm);
+	return snd_pcm_mmap_hw_rewindable(pcm);
 }
 
 static snd_pcm_sframes_t snd_pcm_ioplug_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 74ebd60..394505f 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -464,6 +464,24 @@ static inline snd_pcm_sframes_t snd_pcm_mmap_hw_avail(snd_pcm_t *pcm)
 	return pcm->buffer_size - snd_pcm_mmap_avail(pcm);
 }
 
+static inline snd_pcm_sframes_t snd_pcm_mmap_playback_hw_rewindable(snd_pcm_t *pcm)
+{
+	snd_pcm_sframes_t ret = snd_pcm_mmap_playback_hw_avail(pcm);
+	return (ret >= 0) ? ret : 0;
+}
+
+static inline snd_pcm_sframes_t snd_pcm_mmap_capture_hw_rewindable(snd_pcm_t *pcm)
+{
+	snd_pcm_sframes_t ret = snd_pcm_mmap_capture_hw_avail(pcm);
+	return (ret >= 0) ? ret : 0;
+}
+
+static inline snd_pcm_uframes_t snd_pcm_mmap_hw_rewindable(snd_pcm_t *pcm)
+{
+	snd_pcm_sframes_t ret = snd_pcm_mmap_hw_avail(pcm);
+	return (ret >= 0) ? ret : 0;
+}
+
 static inline const snd_pcm_channel_area_t *snd_pcm_mmap_areas(snd_pcm_t *pcm)
 {
 	if (pcm->stopped_areas &&
diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index a607ccf..c19e2f1 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -198,7 +198,7 @@ static int snd_pcm_plugin_reset(snd_pcm_t *pcm)
 
 static snd_pcm_sframes_t snd_pcm_plugin_rewindable(snd_pcm_t *pcm)
 {
-	return snd_pcm_mmap_hw_avail(pcm);
+	return snd_pcm_mmap_hw_rewindable(pcm);
 }
 
 snd_pcm_sframes_t snd_pcm_plugin_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
-- 
2.1.0
