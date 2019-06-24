From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 2/2] pcm_file: return errno
Date: Mon, 24 Jun 2019 13:23:24 +0200
Message-ID: <1561375404-25252-2-git-send-email-amiartus@de.adit-jv.com>
References: <1561375404-25252-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1561375404-25252-1-git-send-email-amiartus@de.adit-jv.com>
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
---
 src/pcm/pcm_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 11d0953..3712fd8 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -402,6 +402,7 @@ static int snd_pcm_file_write_bytes(snd_pcm_t *pcm, size_t bytes)
 			n = cont;
 		err = write(file->fd, file->wbuf + file->file_ptr_bytes, n);
 		if (err < 0) {
+			err = errno;
 			SYSERR("%s write failed, file data may be corrupt", file->fname);
 			return err;
 		}
-- 
2.7.4
