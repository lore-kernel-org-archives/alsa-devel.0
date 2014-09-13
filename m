From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 8/9] pcm: rewindable,
	forwardable: don't return stale data
Date: Sun, 14 Sep 2014 00:30:20 +0600
Message-ID: <1410633021-20395-9-git-send-email-patrakov@gmail.com>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BB922625CF
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 20:30:57 +0200 (CEST)
Received: by mail-la0-f53.google.com with SMTP id ge10so2727989lab.12
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 11:30:57 -0700 (PDT)
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

The current behavior of snd_pcm_rewindable and snd_pcm_forwardable means
that the returned value is only accurate to one period. Or maybe even
meaningless if period interrupts are off. Fetch the up-to-date position
of the hardware pointer, as that's what is wanted by callers.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/pcm/pcm_dmix.c   | 6 ++++++
 src/pcm/pcm_dshare.c | 6 ++++++
 src/pcm/pcm_dsnoop.c | 6 ++++++
 src/pcm/pcm_hw.c     | 6 ++++++
 src/pcm/pcm_ioplug.c | 2 ++
 src/pcm/pcm_plugin.c | 6 ++++++
 6 files changed, 32 insertions(+)

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index babde6a..d9565f9 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -661,6 +661,9 @@ static int snd_pcm_dmix_pause(snd_pcm_t *pcm ATTRIBUTE_UNUSED, int enable ATTRIB
 
 static snd_pcm_sframes_t snd_pcm_dmix_rewindable(snd_pcm_t *pcm)
 {
+	int err = snd_pcm_dmix_hwsync(pcm);
+	if (err < 0)
+		return err;
 	return snd_pcm_mmap_playback_hw_rewindable(pcm);
 }
 
@@ -744,6 +747,9 @@ static snd_pcm_sframes_t snd_pcm_dmix_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t f
 
 static snd_pcm_sframes_t snd_pcm_dmix_forwardable(snd_pcm_t *pcm)
 {
+	int err = snd_pcm_dmix_hwsync(pcm);
+	if (err < 0)
+		return err;
 	return snd_pcm_mmap_avail(pcm);
 }
 
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index 020e6f7..de0b242 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -412,6 +412,9 @@ static int snd_pcm_dshare_pause(snd_pcm_t *pcm ATTRIBUTE_UNUSED, int enable ATTR
 
 static snd_pcm_sframes_t snd_pcm_dshare_rewindable(snd_pcm_t *pcm)
 {
+	int err = snd_pcm_dshare_hwsync(pcm);
+	if (err < 0)
+		return err;
 	return snd_pcm_mmap_playback_hw_rewindable(pcm);
 }
 
@@ -428,6 +431,9 @@ static snd_pcm_sframes_t snd_pcm_dshare_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t
 
 static snd_pcm_sframes_t snd_pcm_dshare_forwardable(snd_pcm_t *pcm)
 {
+	int err = snd_pcm_dshare_hwsync(pcm);
+	if (err < 0)
+		return err;
 	return snd_pcm_mmap_playback_avail(pcm);
 }
 
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 8333eef..00cd461 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -335,6 +335,9 @@ static int snd_pcm_dsnoop_pause(snd_pcm_t *pcm ATTRIBUTE_UNUSED, int enable ATTR
 
 static snd_pcm_sframes_t snd_pcm_dsnoop_rewindable(snd_pcm_t *pcm)
 {
+	int err = snd_pcm_dsnoop_hwsync(pcm);
+	if (err < 0)
+		return err;
 	return snd_pcm_mmap_capture_hw_avail(pcm);
 }
 
@@ -351,6 +354,9 @@ static snd_pcm_sframes_t snd_pcm_dsnoop_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t
 
 static snd_pcm_sframes_t snd_pcm_dsnoop_forwardable(snd_pcm_t *pcm)
 {
+	int err = snd_pcm_dsnoop_hwsync(pcm);
+	if (err < 0)
+		return err;
 	return snd_pcm_mmap_capture_avail(pcm);
 }
 
diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index c34b766..4a52703 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -659,6 +659,9 @@ static int snd_pcm_hw_pause(snd_pcm_t *pcm, int enable)
 
 static snd_pcm_sframes_t snd_pcm_hw_rewindable(snd_pcm_t *pcm)
 {
+	int err = snd_pcm_hw_hwsync(pcm);
+	if (err < 0)
+		return err;
 	return snd_pcm_mmap_hw_rewindable(pcm);
 }
 
@@ -679,6 +682,9 @@ static snd_pcm_sframes_t snd_pcm_hw_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t fra
 
 static snd_pcm_sframes_t snd_pcm_hw_forwardable(snd_pcm_t *pcm)
 {
+	int err = snd_pcm_hw_hwsync(pcm);
+	if (err < 0)
+		return err;
 	return snd_pcm_mmap_avail(pcm);
 }
 
diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index fe9347c..3861bc2 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -503,6 +503,7 @@ static int snd_pcm_ioplug_pause(snd_pcm_t *pcm, int enable)
 
 static snd_pcm_sframes_t snd_pcm_ioplug_rewindable(snd_pcm_t *pcm)
 {
+	snd_pcm_ioplug_hw_ptr_update(pcm);
 	return snd_pcm_mmap_hw_rewindable(pcm);
 }
 
@@ -514,6 +515,7 @@ static snd_pcm_sframes_t snd_pcm_ioplug_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t
 
 static snd_pcm_sframes_t snd_pcm_ioplug_forwardable(snd_pcm_t *pcm)
 {
+	snd_pcm_ioplug_hw_ptr_update(pcm);
 	return snd_pcm_mmap_avail(pcm);
 }
 
diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index c19e2f1..57a1953 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -198,6 +198,9 @@ static int snd_pcm_plugin_reset(snd_pcm_t *pcm)
 
 static snd_pcm_sframes_t snd_pcm_plugin_rewindable(snd_pcm_t *pcm)
 {
+	int err = snd_pcm_generic_hwsync(pcm);
+	if (err < 0)
+		return err;
 	return snd_pcm_mmap_hw_rewindable(pcm);
 }
 
@@ -226,6 +229,9 @@ snd_pcm_sframes_t snd_pcm_plugin_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames
 
 static snd_pcm_sframes_t snd_pcm_plugin_forwardable(snd_pcm_t *pcm)
 {
+	int err = snd_pcm_generic_hwsync(pcm);
+	if (err < 0)
+		return err;
 	return snd_pcm_mmap_avail(pcm);
 }
 
-- 
2.1.0
