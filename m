From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 05/10] ALSA: core: add info_ext field in
	hw_params and pcm_hardware
Date: Fri, 19 Dec 2014 11:25:08 -0600
Message-ID: <1419009913-3686-6-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1419009913-3686-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E2CE264F52
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 18:25:46 +0100 (CET)
In-Reply-To: <1419009913-3686-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

reclaim 4 bytes from reserved bytes to store new info flags related to
hardware setup and capabilities.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/pcm.h         | 1 +
 include/uapi/sound/asound.h | 3 ++-
 sound/core/pcm_compat.c     | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2641d86..05df271 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -44,6 +44,7 @@
 
 struct snd_pcm_hardware {
 	unsigned int info;		/* SNDRV_PCM_INFO_* */
+	unsigned int info_ext;		/* SNDRV_PCM_INFO_EXT* */
 	u64 formats;			/* SNDRV_PCM_FMTBIT_* */
 	unsigned int rates;		/* SNDRV_PCM_RATE_* */
 	unsigned int rate_min;		/* min rate */
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 1f23cd6..43e26af 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -375,7 +375,8 @@ struct snd_pcm_hw_params {
 	unsigned int rate_num;		/* R: rate numerator */
 	unsigned int rate_den;		/* R: rate denominator */
 	snd_pcm_uframes_t fifo_size;	/* R: chip FIFO size in frames */
-	unsigned char reserved[64];	/* reserved for future */
+	unsigned int info_ext;          /* R: additional Info flags for setup */
+	unsigned char reserved[60];	/* reserved for future */
 };
 
 enum {
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 2d957ba..d7c5669 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -87,7 +87,8 @@ struct snd_pcm_hw_params32 {
 	u32 rate_num;
 	u32 rate_den;
 	u32 fifo_size;
-	unsigned char reserved[64];
+	u32 info_ext;
+	unsigned char reserved[60];
 };
 
 struct snd_pcm_sw_params32 {
-- 
1.9.1
