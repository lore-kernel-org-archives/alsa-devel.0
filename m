From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ASoC: samsung - Don't setup i2s if already
	active.
Date: Thu,  8 Nov 2012 14:46:56 -0800
Message-ID: <1352414816-9157-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f201.google.com (mail-we0-f201.google.com
 [74.125.82.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B1AA2615EE
 for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2012 23:47:56 +0100 (CET)
Received: by mail-we0-f201.google.com with SMTP id u3so210575wey.2
 for <alsa-devel@alsa-project.org>; Thu, 08 Nov 2012 14:47:55 -0800 (PST)
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
Cc: padma.v@samsung.com, sbkim73@samsung.com, sangsu4u.park@samsung.com, broonie@opensource.wolfsonmicro.com, Dylan Reid <dgreid@chromium.org>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

If the dai is already running when setup is called, skip setup.  Setting
up again caused set_sysclk to set rclk_srcrate to other->rclk_srcrate,
other would often be set to the default of 44.1.  Playing a 48k stream
then adding a 48k capture stream would lead to both streams set to 44.1
(The value of other->rclk_srcrate).

Similarly in shutdown, if either playback or capture is still active,
return instead of turning off the clocks.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/samsung/i2s.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 40b00a1..b9935dd 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -637,6 +637,10 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
 	unsigned long flags;
 
+	/* Check not already running. */
+	if (dai->playback_active || dai->capture_active)
+		return 0;
+
 	spin_lock_irqsave(&lock, flags);
 
 	i2s->mode |= DAI_OPENED;
@@ -661,6 +665,10 @@ static void i2s_shutdown(struct snd_pcm_substream *substream,
 	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
 	unsigned long flags;
 
+	/* Check not still running. */
+	if (dai->playback_active || dai->capture_active)
+		return;
+
 	spin_lock_irqsave(&lock, flags);
 
 	i2s->mode &= ~DAI_OPENED;
-- 
1.7.12.146.g16d26b1
