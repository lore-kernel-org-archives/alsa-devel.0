From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: lx6464es: Fix pointer cast compile
	warnings
Date: Wed,  6 Nov 2013 17:58:06 +0100
Message-ID: <1383757086-21220-2-git-send-email-tiwai@suse.de>
References: <1383757086-21220-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 68BBE26516A
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 17:58:06 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 45686A6F06
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 17:58:06 +0100 (CET)
In-Reply-To: <1383757086-21220-1-git-send-email-tiwai@suse.de>
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

The warnings are really harmless but annoying.  Since they are only
about debug prints, and it's at most 32bit DMA, let's just cast to
unsigned long.

  sound/pci/lx6464es/lx6464es.c:457:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  sound/pci/lx6464es/lx_core.c:1195:21: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/lx6464es/lx6464es.c | 4 ++--
 sound/pci/lx6464es/lx_core.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 3230e57f246c..3e9d3a863049 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -453,8 +453,8 @@ static void lx_trigger_start(struct lx6464es *chip, struct lx_stream *lx_stream)
 				     lower_32_bits(buf), upper_32_bits(buf),
 				     &buffer_index);
 
-		snd_printdd(LXP "starting: buffer index %x on %p (%d bytes)\n",
-			    buffer_index, (void *)buf, period_bytes);
+		snd_printdd(LXP "starting: buffer index %x on %lx (%d bytes)\n",
+			    buffer_index, (unsigned long)buf, period_bytes);
 		buf += period_bytes;
 	}
 
diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 633c8607d053..626ecad4dae7 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -1191,8 +1191,8 @@ static int lx_interrupt_request_new_buffer(struct lx6464es *chip,
 	unpack_pointer(buf, &buf_lo, &buf_hi);
 	err = lx_buffer_give(chip, 0, is_capture, period_bytes, buf_lo, buf_hi,
 			     &buffer_index);
-	snd_printdd(LXP "interrupt: gave buffer index %x on %p (%d bytes)\n",
-		    buffer_index, (void *)buf, period_bytes);
+	snd_printdd(LXP "interrupt: gave buffer index %x on 0x%lx (%d bytes)\n",
+		    buffer_index, (unsigned long)buf, period_bytes);
 
 	lx_stream->frame_pos = next_pos;
 	spin_unlock_irqrestore(&chip->lock, flags);
-- 
1.8.4.2
