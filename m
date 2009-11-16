From: Dan Carpenter <error27@gmail.com>
Subject: [patch] move dereference after null check
Date: Mon, 16 Nov 2009 11:06:33 +0200 (SAST)
Message-ID: <alpine.DEB.2.00.0911151555010.12810@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id ECDEC103842
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 10:06:40 +0100 (CET)
Received: by bwz9 with SMTP id 9so15372894bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 01:06:40 -0800 (PST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The 'jack' variable was dereference before the NULL check so this patch 
moves the dereference later.

regards,
dan carpenter

Signed-off-by: Dan Carpenter <error27@gmail.com>

--- orig/sound/soc/soc-jack.c	2009-11-14 11:04:04.000000000 +0200
+++ devel/sound/soc/soc-jack.c	2009-11-14 11:05:01.000000000 +0200
@@ -58,7 +58,7 @@
  */
 void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 {
-	struct snd_soc_codec *codec = jack->card->codec;
+	struct snd_soc_codec *codec;
 	struct snd_soc_jack_pin *pin;
 	int enable;
 	int oldstatus;
@@ -67,6 +67,7 @@
 		WARN_ON_ONCE(!jack);
 		return;
 	}
+	codec = jack->card->codec;
 
 	mutex_lock(&codec->mutex);
