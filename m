From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 17/17] sound: Add missing spin_unlock
Date: Wed, 26 May 2010 17:59:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005261759110.23743@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

Add a spin_unlock missing on the error path.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression E1;
@@

* spin_lock(E1,...);
  <+... when != E1
  if (...) {
    ... when != E1
*   return ...;
  }
  ...+>
* spin_unlock(E1,...);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/mips/au1x00.c                 |    1 +
 sound/oss/dmasound/dmasound_atari.c |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index 3e763d6..446cf97 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -516,6 +516,7 @@ get the interrupt driven case to work efficiently */
 			break;
 	if (i == 0x5000) {
 		printk(KERN_ERR "au1000 AC97: AC97 command read timeout\n");
+		spin_unlock(&au1000->ac97_lock);
 		return 0;
 	}
 
diff --git a/sound/oss/dmasound/dmasound_atari.c b/sound/oss/dmasound/dmasound_atari.c
index 1f47741..13c2144 100644
--- a/sound/oss/dmasound/dmasound_atari.c
+++ b/sound/oss/dmasound/dmasound_atari.c
@@ -1277,7 +1277,7 @@ static irqreturn_t AtaInterrupt(int irq, void *dummy)
 		 * (almost) like on the TT.
 		 */
 		write_sq_ignore_int = 0;
-		return IRQ_HANDLED;
+		goto out;
 	}
 
 	if (!write_sq.active) {
@@ -1285,7 +1285,7 @@ static irqreturn_t AtaInterrupt(int irq, void *dummy)
 		 * the sq variables, so better don't do anything here.
 		 */
 		WAKE_UP(write_sq.sync_queue);
-		return IRQ_HANDLED;
+		goto out;
 	}
 
 	/* Probably ;) one frame is finished. Well, in fact it may be that a
@@ -1322,6 +1322,7 @@ static irqreturn_t AtaInterrupt(int irq, void *dummy)
 	/* We are not playing after AtaPlay(), so there
 	   is nothing to play any more. Wake up a process
 	   waiting for audio output to drain. */
+out:
 	spin_unlock(&dmasound.lock);
 	return IRQ_HANDLED;
 }
