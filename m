From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: PATCH: alsa-plugins: a52: Fix build with older ffmpeg
	versions
Date: Tue, 26 Apr 2011 23:02:41 +0100
Message-ID: <ip7fe6$b16$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010302060304020104000209"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D46A103861
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 00:03:06 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1QEqLU-0000Dz-HG
	for alsa-devel@alsa-project.org; Wed, 27 Apr 2011 00:03:00 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2011 00:03:00 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2011 00:03:00 +0200
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010302060304020104000209
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

 This fixes a regression introduced in:


commit 40c129a160f37fe9488b2828d6299f99c269703e
Author: Joerg Reuter <jreuter@suse.de>
Date:   Wed Apr 6 16:36:11 2011 +0200

    a52 - Fix a52 codec with recent libavcodec updates

    The recent libavcodec is changed to accept only float input, but
    the old ac3 encoder is still somehow working with a different name.
    This patch makes it working again.

    Signed-off-by: Takashi Iwai <tiwai@suse.de>

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]

--------------010302060304020104000209
Content-Type: text/x-patch;
 name="0001-a52-Fix-build-with-older-ffmpeg-versions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-a52-Fix-build-with-older-ffmpeg-versions.patch"

>From 7d0fcca85d58fa38d595ab4362cf2db689db1c1c Mon Sep 17 00:00:00 2001
From: Colin Guthrie <colin@mageia.org>
Date: Tue, 26 Apr 2011 22:55:44 +0100
Subject: [PATCH] a52: Fix build with older ffmpeg versions.

This fixes a regression introduced in:
  40c129a160f37fe9488b2828d6299f99c269703e
---
 a52/pcm_a52.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index 76f21cd..00c7c59 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -436,7 +436,11 @@ static int a52_prepare(snd_pcm_ioplug_t *io)
 	rec->avctx->bit_rate = rec->bitrate * 1000;
 	rec->avctx->sample_rate = io->rate;
 	rec->avctx->channels = io->channels;
-	rec->avctx->sample_fmt = AV_SAMPLE_FMT_S16;
+#if LIBAVCODEC_VERSION_MAJOR > 52 || (LIBAVCODEC_VERSION_MAJOR == 52 && LIBAVCODEC_VERSION_MINOR >= 95)
+  rec->avctx->sample_fmt = AV_SAMPLE_FMT_S16;
+#else
+  rec->avctx->sample_fmt = SAMPLE_FMT_S16;
+#endif
 #if LIBAVCODEC_VERSION_MAJOR > 52 || (LIBAVCODEC_VERSION_MAJOR == 52 && LIBAVCODEC_VERSION_MINOR >= 3)
 	switch (io->channels) {
 	case 2:
-- 
1.7.4.4


--------------010302060304020104000209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010302060304020104000209--
