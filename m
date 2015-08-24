From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH (alsa-lib)] pcm: Fix doxygen for two enums
Date: Mon, 24 Aug 2015 20:37:29 +0200
Message-ID: <1440441449-6715-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DE442606D9
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 20:37:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The doxygen comments were wrong, making doxygen output weird.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/pcm.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/pcm.h b/include/pcm.h
index a1d14a9..0be1a32 100644
--- a/include/pcm.h
+++ b/include/pcm.h
@@ -324,9 +324,9 @@ typedef enum _snd_pcm_tstamp {
 } snd_pcm_tstamp_t;
 
 typedef enum _snd_pcm_tstamp_type {
-	SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/** gettimeofday equivalent */
-	SND_PCM_TSTAMP_TYPE_MONOTONIC,	/** posix_clock_monotonic equivalent */
-	SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW,	/** monotonic_raw (no NTP) */
+	SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/**< gettimeofday equivalent */
+	SND_PCM_TSTAMP_TYPE_MONOTONIC,	/**< posix_clock_monotonic equivalent */
+	SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW,	/**< monotonic_raw (no NTP) */
 	SND_PCM_TSTAMP_TYPE_LAST = SND_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 } snd_pcm_tstamp_type_t;
 
@@ -527,11 +527,11 @@ int snd_pcm_unlink(snd_pcm_t *pcm);
 
 /** channel map list type */
 enum snd_pcm_chmap_type {
-	SND_CHMAP_TYPE_NONE = 0,/** unspecified channel position */
-	SND_CHMAP_TYPE_FIXED,	/** fixed channel position */
-	SND_CHMAP_TYPE_VAR,	/** freely swappable channel position */
-	SND_CHMAP_TYPE_PAIRED,	/** pair-wise swappable channel position */
-	SND_CHMAP_TYPE_LAST = SND_CHMAP_TYPE_PAIRED, /** last entry */
+	SND_CHMAP_TYPE_NONE = 0,/**< unspecified channel position */
+	SND_CHMAP_TYPE_FIXED,	/**< fixed channel position */
+	SND_CHMAP_TYPE_VAR,	/**< freely swappable channel position */
+	SND_CHMAP_TYPE_PAIRED,	/**< pair-wise swappable channel position */
+	SND_CHMAP_TYPE_LAST = SND_CHMAP_TYPE_PAIRED, /**< last entry */
 };
 
 /** channel positions */
-- 
1.9.1
