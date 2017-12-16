From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH for-4.15] ASoC: rt5514: don't assume rt5514
	component was "attached"
Date: Fri, 15 Dec 2017 17:12:30 -0800
Message-ID: <20171216011230.107527-1-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
 [209.85.214.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AEC7266DB1
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 02:12:42 +0100 (CET)
Received: by mail-it0-f65.google.com with SMTP id f143so22051404itb.0
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 17:12:42 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Brian Norris <briannorris@chromium.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

I've found that on Google's "Kevin" Chromebook, the rt5514 codec might
not be set up completely, yet its device is still present, and therefore
its PM suspend/resume is called. This hits a NULL pointer exception,
since we never had the chance to set our drvdata pointer.

This resolves crashes seen when trying to resume my system.

Fixes: e9c50aa6bd39 ("ASoC: rt5514-spi: check irq status to schedule data copy in resume function")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This is a v4.15-rc1 regression

 sound/soc/codecs/rt5514-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 2df91db765ac..9255afcf2c3a 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -482,7 +482,7 @@ static int __maybe_unused rt5514_resume(struct device *dev)
 	if (device_may_wakeup(dev))
 		disable_irq_wake(irq);
 
-	if (rt5514_dsp->substream) {
+	if (rt5514_dsp && rt5514_dsp->substream) {
 		rt5514_spi_burst_read(RT5514_IRQ_CTRL, (u8 *)&buf, sizeof(buf));
 		if (buf[0] & RT5514_IRQ_STATUS_BIT)
 			rt5514_schedule_copy(rt5514_dsp);
-- 
2.15.1.504.g5279b80103-goog
