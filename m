From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: [PATCH] salsa-lib: Rename _sndrv_pcm_format to
	_snd_pcm_format
Date: Sun, 17 Mar 2013 15:01:04 +0000
Message-ID: <CAD-m0i-o0qfzZ4PeC7ObH3Ee7SEhQpV6QXSbxt-m7K=Yn2kOzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 2286F261647
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2013 16:01:05 +0100 (CET)
Received: by mail-pd0-f179.google.com with SMTP id x10so602433pdj.24
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2013 08:01:05 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Rename _sndrv_pcm_format to _snd_pcm_format for compatible with alsa-lib.

--- salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884/src/asound.h
+++ salsa-lib-a55ce0c348cd16e7853dae11e8e0e1b5a101d884-1/src/asound.h
@@ -133,7 +133,7 @@
 	SND_PCM_ACCESS_LAST = SND_PCM_ACCESS_RW_NONINTERLEAVED,
 } snd_pcm_access_t;

-typedef enum _sndrv_pcm_format {
+typedef enum _snd_pcm_format {
 	SND_PCM_FORMAT_UNKNOWN = -1,
 	SND_PCM_FORMAT_S8 = 0,	/* signed */
 	SND_PCM_FORMAT_U8,	/* unsigned */
