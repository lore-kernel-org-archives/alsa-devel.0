From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 2/3] pcm_file: improve error checking in
	write_wav_header function
Date: Mon, 1 Jul 2019 15:25:17 +0200
Message-ID: <1561987518-2828-3-git-send-email-amiartus@de.adit-jv.com>
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

previously errno would be returned even for cases where it may have
not been populated, for example one of the write functions failing,
or writing only partial buffer,

now progress through write operations separately and report errno when
appropriate

Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
Reviewed-by: Timo Wischer <twischer@de.adit-jv.com>
---
 src/pcm/pcm_file.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index d83f97a..f800e51 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -327,6 +327,8 @@ static void setup_wav_header(snd_pcm_t *pcm, struct wav_fmt *fmt)
 static int write_wav_header(snd_pcm_t *pcm)
 {
 	snd_pcm_file_t *file = pcm->private_data;
+	ssize_t res;
+
 	static const char header[] = {
 		'R', 'I', 'F', 'F',
 		0x24, 0, 0, 0,
@@ -341,15 +343,36 @@ static int write_wav_header(snd_pcm_t *pcm)
 	
 	setup_wav_header(pcm, &file->wav_header);
 
-	if (write(file->fd, header, sizeof(header)) != sizeof(header) ||
-	    write(file->fd, &file->wav_header, sizeof(file->wav_header)) !=
-	    sizeof(file->wav_header) ||
-	    write(file->fd, header2, sizeof(header2)) != sizeof(header2)) {
-		int err = errno;
-		SYSERR("%s write header failed, file data may be corrupt", file->fname);
-		return -err;
+	res = write(file->fd, header, sizeof(header));
+	if (res != sizeof(header)) {
+		goto write_error;
+	}
+
+	res = write(file->fd, &file->wav_header, sizeof(file->wav_header));
+	if (res != sizeof(file->wav_header)) {
+		goto write_error;
 	}
+
+	res = write(file->fd, header2, sizeof(header2));
+	if (res != sizeof(header2)) {
+		goto write_error;
+	}
+
 	return 0;
+
+write_error:
+	// print real errno if available and return EIO, reason for this is to block possible
+	// EPIPE in case file->fd is a pipe. EPIPE from file->fd conflicts with EPIPE from
+	// playback stream which should be used to signal XRUN on playback device
+	if (res < 0) {
+		SYSERR("%s write header failed, file data may be corrupt", file->fname);
+	} else {
+		SNDERR("%s write header incomplete, file data may be corrupt", file->fname);
+	}
+
+	memset(&file->wav_header, 0, sizeof(struct wav_fmt));
+
+	return -EIO;
 }
 
 /* fix up the length fields in WAV header */
-- 
2.7.4
