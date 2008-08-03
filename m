From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] wss_lib: remove second mutexes initialization
Date: Sun, 3 Aug 2008 17:57:21 +0200
Message-ID: <20080803175721.c95f9cf1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id EFD6C1037F8
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Aug 2008 17:51:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove initializations of spinlock and mutexes which
are done earlier in snd_wss_new(). The snd_wss_new()
is called from snd_wss_create().

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-alsa/sound/isa/wss/wss_lib.c linux-2.6.26/sound/isa/wss/wss_lib.c
--- linux-alsa/sound/isa/wss/wss_lib.c	2008-07-31 20:39:59.000000000 +0200
+++ linux-2.6.26/sound/isa/wss/wss_lib.c	2008-08-03 16:54:01.293267081 +0200
@@ -1866,10 +1866,6 @@ int snd_wss_pcm(struct snd_wss *chip, in
 	if (err < 0)
 		return err;
 
-	spin_lock_init(&chip->reg_lock);
-	mutex_init(&chip->mce_mutex);
-	mutex_init(&chip->open_mutex);
-
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_wss_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_wss_capture_ops);
 




----------------------------------------------------------------------
Tylko dla detektywow! Konkurs na Smaker.pl
Kliknij >>> http://link.interia.pl/f1eb1
