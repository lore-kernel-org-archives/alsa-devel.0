From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 2/2] pcm_file: report write output file error
	to api user
Date: Wed, 12 Jun 2019 08:48:28 +0200
Message-ID: <1560322108-17074-3-git-send-email-amiartus@de.adit-jv.com>
References: <1560322108-17074-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1560322108-17074-1-git-send-email-amiartus@de.adit-jv.com>
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

when writing to output file fails, api user is notified and can handle
recovery

Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
Reviewed-by: Timo Wischer <twischer@de.adit-jv.com>
---
 src/pcm/pcm_file.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 0a8d98d..ca8e0c8 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -572,7 +572,10 @@ static snd_pcm_sframes_t snd_pcm_file_writei(snd_pcm_t *pcm, const void *buffer,
 	if (n > 0) {
 		snd_pcm_areas_from_buf(pcm, areas, (void*) buffer);
 		__snd_pcm_lock(pcm);
-		snd_pcm_file_add_frames(pcm, areas, 0, n);
+		if (snd_pcm_file_add_frames(pcm, areas, 0, n) < 0) {
+			__snd_pcm_unlock(pcm);
+			return -EPIPE;
+		}
 		__snd_pcm_unlock(pcm);
 	}
 	return n;
@@ -587,7 +590,10 @@ static snd_pcm_sframes_t snd_pcm_file_writen(snd_pcm_t *pcm, void **bufs, snd_pc
 	if (n > 0) {
 		snd_pcm_areas_from_bufs(pcm, areas, bufs);
 		__snd_pcm_lock(pcm);
-		snd_pcm_file_add_frames(pcm, areas, 0, n);
+		if (snd_pcm_file_add_frames(pcm, areas, 0, n) < 0) {
+			__snd_pcm_unlock(pcm);
+			return -EPIPE;
+		}
 		__snd_pcm_unlock(pcm);
 	}
 	return n;
@@ -608,6 +614,11 @@ static snd_pcm_sframes_t snd_pcm_file_readi(snd_pcm_t *pcm, void *buffer, snd_pc
 	snd_pcm_file_areas_read_infile(pcm, areas, 0, frames);
 	__snd_pcm_lock(pcm);
 	snd_pcm_file_add_frames(pcm, areas, 0, frames);
+	if (snd_pcm_file_add_frames(pcm, areas, 0, frames) < 0) {
+		__snd_pcm_unlock(pcm);
+		return -EPIPE;
+	}
+
 	__snd_pcm_unlock(pcm);
 
 	return frames;
@@ -627,7 +638,11 @@ static snd_pcm_sframes_t snd_pcm_file_readn(snd_pcm_t *pcm, void **bufs, snd_pcm
 	snd_pcm_areas_from_bufs(pcm, areas, bufs);
 	snd_pcm_file_areas_read_infile(pcm, areas, 0, frames);
 	__snd_pcm_lock(pcm);
-	snd_pcm_file_add_frames(pcm, areas, 0, frames);
+	if (snd_pcm_file_add_frames(pcm, areas, 0, frames) < 0) {
+		__snd_pcm_unlock(pcm);
+		return -EPIPE;
+	}
+
 	__snd_pcm_unlock(pcm);
 
 	return frames;
@@ -649,8 +664,10 @@ static snd_pcm_sframes_t snd_pcm_file_mmap_commit(snd_pcm_t *pcm,
 	if (result >= 0) {
 		assert(ofs == offset && siz == size);
 		result = snd_pcm_mmap_commit(file->gen.slave, ofs, siz);
-		if (result > 0)
-			snd_pcm_file_add_frames(pcm, areas, ofs, result);
+		if (result > 0) {
+			if (snd_pcm_file_add_frames(pcm, areas, ofs, result) < 0)
+				return -EPIPE;
+		}
 	}
 	return result;
 }
-- 
2.7.4
