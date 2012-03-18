From: Alex Hornung <alex@alexhornung.com>
Subject: [PATCH 1/1] a52: set time_base to avoid crash in
	avcodec
Date: Sun, 18 Mar 2012 18:23:49 +0000
Message-ID: <1332095029-14579-1-git-send-email-alex@alexhornung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 822BC103A4E
	for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2012 19:24:18 +0100 (CET)
Received: by wibhm17 with SMTP id hm17so2673571wib.2
	for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2012 11:24:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Alex Hornung <alex@alexhornung.com>
List-Id: alsa-devel@alsa-project.org

 * Not setting the avctx->time_base properly results in a crash in
   avcodec_encode_audio() in more recent versions of it.

 * Fix it by setting the time_base according to the sampling rate.

Signed-off-by: Alex Hornung <alex@alexhornung.com>
---
 a52/pcm_a52.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index 00c7c59..560071d 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -436,6 +436,8 @@ static int a52_prepare(snd_pcm_ioplug_t *io)
 	rec->avctx->bit_rate = rec->bitrate * 1000;
 	rec->avctx->sample_rate = io->rate;
 	rec->avctx->channels = io->channels;
+	rec->avctx->time_base.num = 1;
+	rec->avctx->time_base.den = io->rate;
 #if LIBAVCODEC_VERSION_MAJOR > 52 || (LIBAVCODEC_VERSION_MAJOR == 52 && LIBAVCODEC_VERSION_MINOR >= 95)
   rec->avctx->sample_fmt = AV_SAMPLE_FMT_S16;
 #else
-- 
1.7.9.1
