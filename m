From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 1/3] pcm_file: use EIO instead of EPIPE when
	failing to write output file
Date: Mon, 1 Jul 2019 15:25:16 +0200
Message-ID: <1561987518-2828-2-git-send-email-amiartus@de.adit-jv.com>
References: <1561987518-2828-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1561987518-2828-1-git-send-email-amiartus@de.adit-jv.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

EPIPE is defined as XRUN which is not entirely correct in this condition

failing to write to a file in pcm_file plugin can not be simply recovered
by a retry as user of the api might be led to believe when receiving EPIPE

use EIO instead to indicate a different kid of error that may not be
recoverable by retry

Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
Reviewed-by: Timo Wischer <twischer@de.adit-jv.com>
---
 src/pcm/pcm_file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index ab47da8..d83f97a 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -575,7 +575,7 @@ static snd_pcm_sframes_t snd_pcm_file_writei(snd_pcm_t *pcm, const void *buffer,
 		__snd_pcm_lock(pcm);
 		if (snd_pcm_file_add_frames(pcm, areas, 0, n) < 0) {
 			__snd_pcm_unlock(pcm);
-			return -EPIPE;
+			return -EIO;
 		}
 		__snd_pcm_unlock(pcm);
 	}
@@ -593,7 +593,7 @@ static snd_pcm_sframes_t snd_pcm_file_writen(snd_pcm_t *pcm, void **bufs, snd_pc
 		__snd_pcm_lock(pcm);
 		if (snd_pcm_file_add_frames(pcm, areas, 0, n) < 0) {
 			__snd_pcm_unlock(pcm);
-			return -EPIPE;
+			return -EIO;
 		}
 		__snd_pcm_unlock(pcm);
 	}
@@ -616,7 +616,7 @@ static snd_pcm_sframes_t snd_pcm_file_readi(snd_pcm_t *pcm, void *buffer, snd_pc
 	__snd_pcm_lock(pcm);
 	if (snd_pcm_file_add_frames(pcm, areas, 0, frames) < 0) {
 		__snd_pcm_unlock(pcm);
-		return -EPIPE;
+		return -EIO;
 	}
 
 	__snd_pcm_unlock(pcm);
@@ -640,7 +640,7 @@ static snd_pcm_sframes_t snd_pcm_file_readn(snd_pcm_t *pcm, void **bufs, snd_pcm
 	__snd_pcm_lock(pcm);
 	if (snd_pcm_file_add_frames(pcm, areas, 0, frames) < 0) {
 		__snd_pcm_unlock(pcm);
-		return -EPIPE;
+		return -EIO;
 	}
 
 	__snd_pcm_unlock(pcm);
@@ -666,7 +666,7 @@ static snd_pcm_sframes_t snd_pcm_file_mmap_commit(snd_pcm_t *pcm,
 		result = snd_pcm_mmap_commit(file->gen.slave, ofs, siz);
 		if (result > 0) {
 			if (snd_pcm_file_add_frames(pcm, areas, ofs, result) < 0)
-				return -EPIPE;
+				return -EIO;
 		}
 	}
 	return result;
-- 
2.7.4
