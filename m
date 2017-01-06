From: sutar.mounesh@gmail.com
Subject: [PATCH 6/6 v3] alsa-lib:pcm: don't return bogus buffer
	levels in xrun state
Date: Fri,  6 Jan 2017 14:10:35 +0530
Message-ID: <1483692035-1470-1-git-send-email-sutar.mounesh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Andreas Pape <apape@de.adit-jv.com>, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Mounesh Sutar <mounesh_sutar@mentor.com>

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index 2e7d9d2..1948fa0 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -882,6 +882,9 @@ static snd_pcm_sframes_t snd_pcm_dmix_avail_update(snd_pcm_t *pcm)
 		if ((err = snd_pcm_dmix_sync_ptr(pcm)) < 0)
 			return err;
 	}
+	if (dmix->state == SND_PCM_STATE_XRUN)
+		return -EPIPE;
+
 	return snd_pcm_mmap_playback_avail(pcm);
 }
 
diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index 09d165d..cdd1521 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -570,6 +570,9 @@ static snd_pcm_sframes_t snd_pcm_dshare_avail_update(snd_pcm_t *pcm)
 		if ((err = snd_pcm_dshare_sync_ptr(pcm)) < 0)
 			return err;
 	}
+	if (dshare->state == SND_PCM_STATE_XRUN)
+		return -EPIPE;
+
 	return snd_pcm_mmap_playback_avail(pcm);
 }
 
diff --git a/src/pcm/pcm_dsnoop.c b/src/pcm/pcm_dsnoop.c
index 2b0df89..60a5843 100644
--- a/src/pcm/pcm_dsnoop.c
+++ b/src/pcm/pcm_dsnoop.c
@@ -454,6 +454,9 @@ static snd_pcm_sframes_t snd_pcm_dsnoop_avail_update(snd_pcm_t *pcm)
 		if (err < 0)
 			return err;
 	}
+	if (dsnoop->state == SND_PCM_STATE_XRUN)
+		return -EPIPE;
+
 	return snd_pcm_mmap_capture_avail(pcm);
 }
 
-- 
2.7.4
