From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH - alsa-lib 1/1] pcm_file: add missing unlock on
	early return
Date: Thu, 23 May 2019 11:44:30 +0200
Message-ID: <1558604670-4180-2-git-send-email-amiartus@de.adit-jv.com>
References: <1558604670-4180-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1558604670-4180-1-git-send-email-amiartus@de.adit-jv.com>
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

Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index dcaa41d..8e2c70b 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -584,8 +584,10 @@ static snd_pcm_sframes_t snd_pcm_file_readi(snd_pcm_t *pcm, void *buffer, snd_pc
 	__snd_pcm_lock(pcm);
 
 	frames = _snd_pcm_readi(file->gen.slave, buffer, size);
-	if (frames <= 0)
+	if (frames <= 0) {
+		__snd_pcm_unlock(pcm);
 		return frames;
+	}
 
 	snd_pcm_areas_from_buf(pcm, areas, buffer);
 	snd_pcm_file_areas_read_infile(pcm, areas, 0, frames);
@@ -605,8 +607,10 @@ static snd_pcm_sframes_t snd_pcm_file_readn(snd_pcm_t *pcm, void **bufs, snd_pcm
 
 	__snd_pcm_lock(pcm);
 	frames = _snd_pcm_readn(file->gen.slave, bufs, size);
-	if (frames <= 0)
+	if (frames <= 0) {
+		__snd_pcm_unlock(pcm);
 		return frames;
+	}
 
 	snd_pcm_areas_from_bufs(pcm, areas, bufs);
 	snd_pcm_file_areas_read_infile(pcm, areas, 0, frames);
-- 
2.7.4
