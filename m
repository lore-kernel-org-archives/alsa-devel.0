From: Caleb Crome <caleb@crome.org>
Subject: [PATCH 1/2] BAT: eliminate compiler warnings due to
	printf type mismatch
Date: Fri, 23 Oct 2015 22:29:15 +0000
Message-ID: <1445639356-20343-1-git-send-email-caleb@crome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AA7F264F30
 for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2015 00:29:20 +0200 (CEST)
Received: by pabrc13 with SMTP id rc13so128932445pab.0
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 15:29:19 -0700 (PDT)
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
Cc: Caleb Crome <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org

Explict type cast to (size_t) to eliminate compiler warnings.

Signed-off-by: Caleb Crome <caleb@crome.org>
---
 bat/alsa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bat/alsa.c b/bat/alsa.c
index 582c604..b2aa34b 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -161,7 +161,7 @@ static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
 	if (err < 0) {
 		fprintf(bat->err, _("Get parameter from device error: "));
 		fprintf(bat->err, _("period size: %zd %s: %s(%d)\n"),
-				sndpcm->period_size,
+				(size_t) sndpcm->period_size,
 				device_name, snd_strerror(err), err);
 		return err;
 	}
@@ -170,7 +170,7 @@ static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
 	if (err < 0) {
 		fprintf(bat->err, _("Get parameter from device error: "));
 		fprintf(bat->err, _("buffer size: %zd %s: %s(%d)\n"),
-				sndpcm->buffer_size,
+				(size_t) sndpcm->buffer_size,
 				device_name, snd_strerror(err), err);
 		return err;
 	}
@@ -178,7 +178,7 @@ static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
 	if (sndpcm->period_size == sndpcm->buffer_size) {
 		fprintf(bat->err, _("Invalid parameters: can't use period "));
 		fprintf(bat->err, _("equal to buffer size (%zd)\n"),
-				sndpcm->period_size);
+				(size_t) sndpcm->period_size);
 		return -EINVAL;
 	}
 
-- 
2.6.1
