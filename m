From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 1/4] snd-usb-caiaq: Do not disable local
	interrupts
Date: Fri, 25 Sep 2009 16:22:15 +0100
Message-ID: <1253892138-10827-1-git-send-email-mark@pogo.org.uk>
References: <alpine.BSO.2.01.0909220805420.25926@zrgural.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 155A310390A
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 17:22:19 +0200 (CEST)
In-Reply-To: <alpine.BSO.2.01.0909220805420.25926@zrgural.vwaro.pbz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The driver documentation states that local interrupts are already
disabled when trigger() is called, so only a spinlock is required.
---
 sound/usb/caiaq/audio.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 121af06..ce193a5 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -72,15 +72,14 @@ static void
 deactivate_substream(struct snd_usb_caiaqdev *dev,
 		     struct snd_pcm_substream *sub)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&dev->spinlock, flags);
+	spin_lock(&dev->spinlock);
 
 	if (sub->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		dev->sub_playback[sub->number] = NULL;
 	else
 		dev->sub_capture[sub->number] = NULL;
 
-	spin_unlock_irqrestore(&dev->spinlock, flags);
+	spin_unlock(&dev->spinlock);
 }
 
 static int
-- 
1.6.4.4
