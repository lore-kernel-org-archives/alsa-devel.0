From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: [PATCH] Dreamcast AICA sound - Get rid of annoying
	compiler warning
Date: Sun, 28 Oct 2007 14:27:04 +0000
Message-ID: <8b67d60710280727k651ddea7sebaf3f4b995241eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B9702490C
	for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2007 15:27:06 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id u77so2334028pyb
	for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2007 07:27:04 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: linuxsh-dev@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This patch supresses an annoying compiler warning that the variable
err may be used uninitialised.

Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>


diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 88dc840..8861d2f 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -237,6 +237,7 @@ static int aica_dma_transfer(int channels, int buffer_size,
 	struct snd_card_aica *dreamcastcard;
 	struct snd_pcm_runtime *runtime;
 	unsigned long flags;
+	err = 0;
 	dreamcastcard = substream->pcm->private_data;
 	period_offset = dreamcastcard->clicks;
 	period_offset %= (AICA_PERIOD_NUMBER / channels);
