From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 3/3] pcm_file: in case of failed write clear
	file buffer variables
Date: Mon, 1 Jul 2019 15:25:18 +0200
Message-ID: <1561987518-2828-4-git-send-email-amiartus@de.adit-jv.com>
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

previously, in case of failed write to output file, error is returned
from snd_pcm_writei/read APIs, user could run pcm_drain as fallback and
encounter an assert, since drain would try to write remaining file
buffer to a file

if failed to write to output file in first place, it makes sense to clear
current internal pmc_file file buffer variables

Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
Reviewed-by: Timo Wischer <twischer@de.adit-jv.com>
---
 src/pcm/pcm_file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index f800e51..bf6e064 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -414,8 +414,11 @@ static int snd_pcm_file_write_bytes(snd_pcm_t *pcm, size_t bytes)
 	if (file->format == SND_PCM_FILE_FORMAT_WAV &&
 	    !file->wav_header.fmt) {
 		err = write_wav_header(pcm);
-		if (err < 0)
+		if (err < 0) {
+			file->wbuf_used_bytes = 0;
+			file->file_ptr_bytes = 0;
 			return err;
+		}
 	}
 
 	while (bytes > 0) {
@@ -426,6 +429,8 @@ static int snd_pcm_file_write_bytes(snd_pcm_t *pcm, size_t bytes)
 		err = write(file->fd, file->wbuf + file->file_ptr_bytes, n);
 		if (err < 0) {
 			err = -errno;
+			file->wbuf_used_bytes = 0;
+			file->file_ptr_bytes = 0;
 			SYSERR("%s write failed, file data may be corrupt", file->fname);
 			return err;
 		}
-- 
2.7.4
