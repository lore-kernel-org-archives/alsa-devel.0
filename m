From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 2/9] pcm: express the rewind size limitation
	logic better
Date: Sun, 14 Sep 2014 00:30:14 +0600
Message-ID: <1410633021-20395-3-git-send-email-patrakov@gmail.com>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id ED678261ACB
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 20:30:51 +0200 (CEST)
Received: by mail-lb0-f171.google.com with SMTP id 10so2558580lbg.16
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 11:30:51 -0700 (PDT)
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

There are a few places where the argument of the .rewind or .forward
callback is checked against the same value as returned by .rewindable or
.forwardable. Express this "don't rewind more than rewindable" logic
explicitly, so that the future fixes to the rewindable size can go to
one function instead of two.

While at it, take advantage of the fact that snd_pcm_mmap_avail() cannot
return negative values (except due to integer overflow, which is AFAICS
impossible given the current boundary choice).

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/pcm/pcm_dmix.c   | 4 +---
 src/pcm/pcm_dshare.c | 6 ++----
 src/pcm/pcm_dsnoop.c | 6 ++----
 src/pcm/pcm_plugin.c | 4 ++--
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 73cbe3f..ffde12a 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -751,9 +751,7 @@ static snd_pcm_sframes_t snd_pcm_dmix_forward(snd_pcm_t *pcm, snd_pcm_uframes_t
 {
 	snd_pcm_sframes_t avail;
 
-	avail = snd_pcm_mmap_playback_avail(pcm);
-	if (avail < 0)
-		return 0;
+	avail = snd_pcm_dmix_forwardable(pcm);
 	if (frames > (snd_pcm_uframes_t)avail)
 		frames = avail;
 	snd_pcm_mmap_appl_forward(pcm, frames);
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index b985172..f1a1a1d 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -419,7 +419,7 @@ static snd_pcm_sframes_t snd_pcm_dshare_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t
 {
 	snd_pcm_sframes_t avail;
 
-	avail = snd_pcm_mmap_playback_hw_avail(pcm);
+	avail = snd_pcm_dshare_rewindable(pcm);
 	if (avail < 0)
 		return 0;
 	if (frames > (snd_pcm_uframes_t)avail)
@@ -437,9 +437,7 @@ static snd_pcm_sframes_t snd_pcm_dshare_forward(snd_pcm_t *pcm, snd_pcm_uframes_
 {
 	snd_pcm_sframes_t avail;
 
-	avail = snd_pcm_mmap_playback_avail(pcm);
-	if (avail < 0)
-		return 0;
+	avail = snd_pcm_dshare_forwardable(pcm);
 	if (frames > (snd_pcm_uframes_t)avail)
 		frames = avail;
 	snd_pcm_mmap_appl_forward(pcm, frames);
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 0f9c9df..e56e402 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -342,9 +342,7 @@ static snd_pcm_sframes_t snd_pcm_dsnoop_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t
 {
 	snd_pcm_sframes_t avail;
 
-	avail = snd_pcm_mmap_capture_avail(pcm);
-	if (avail < 0)
-		return 0;
+	avail = snd_pcm_dsnoop_rewindable(pcm);
 	if (frames > (snd_pcm_uframes_t)avail)
 		frames = avail;
 	snd_pcm_mmap_appl_backward(pcm, frames);
@@ -360,7 +358,7 @@ static snd_pcm_sframes_t snd_pcm_dsnoop_forward(snd_pcm_t *pcm, snd_pcm_uframes_
 {
 	snd_pcm_sframes_t avail;
 
-	avail = snd_pcm_mmap_capture_hw_avail(pcm);
+	avail = snd_pcm_dsnoop_forwardable(pcm);
 	if (avail < 0)
 		return 0;
 	if (frames > (snd_pcm_uframes_t)avail)
diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index 4ddf10c..a607ccf 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -204,7 +204,7 @@ static snd_pcm_sframes_t snd_pcm_plugin_rewindable(snd_pcm_t *pcm)
 snd_pcm_sframes_t snd_pcm_plugin_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
-	snd_pcm_sframes_t n = snd_pcm_mmap_hw_avail(pcm);
+	snd_pcm_sframes_t n = snd_pcm_plugin_rewindable(pcm);
 	snd_pcm_sframes_t sframes;
 
 	if ((snd_pcm_uframes_t)n < frames)
@@ -232,7 +232,7 @@ static snd_pcm_sframes_t snd_pcm_plugin_forwardable(snd_pcm_t *pcm)
 snd_pcm_sframes_t snd_pcm_plugin_forward(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
-	snd_pcm_sframes_t n = snd_pcm_mmap_avail(pcm);
+	snd_pcm_sframes_t n = snd_pcm_plugin_forwardable(pcm);
 	snd_pcm_sframes_t sframes;
 
 	if ((snd_pcm_uframes_t)n < frames)
-- 
2.1.0
