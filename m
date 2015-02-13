From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v6 6/7] ALSA: core: remove .wall_clock
Date: Fri, 13 Feb 2015 15:14:08 -0600
Message-ID: <1423862049-4073-7-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1423862049-4073-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C17B260675
 for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2015 22:14:25 +0100 (CET)
In-Reply-To: <1423862049-4073-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

can be removed without breaking git-bisect now

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/pcm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 04f2d49..0cb7f3f 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -74,8 +74,6 @@ struct snd_pcm_ops {
 	int (*prepare)(struct snd_pcm_substream *substream);
 	int (*trigger)(struct snd_pcm_substream *substream, int cmd);
 	snd_pcm_uframes_t (*pointer)(struct snd_pcm_substream *substream);
-	int (*wall_clock)(struct snd_pcm_substream *substream,
-			  struct timespec *audio_ts);
 	int (*get_time_info)(struct snd_pcm_substream *substream,
 			struct timespec *system_ts, struct timespec *audio_ts,
 			struct snd_pcm_audio_tstamp_config *audio_tstamp_config,
-- 
1.9.1
