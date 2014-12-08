From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: wm8750: Make VREF a VMID instead of
	OUTPUT widget
Date: Mon,  8 Dec 2014 11:23:11 +0100
Message-ID: <1418034191-28010-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-152.synserver.de (smtp-out-152.synserver.de
 [212.40.185.152])
 by alsa0.perex.cz (Postfix) with ESMTP id A39D426043B
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 11:23:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit 04489eeb02a4 ("ALSA: wm8750: add missing VREF output") added the
previously missing VREF widget. And while adding the widget as OUTPUT widget
silences the error of the missing widget it should have rather been a VMID
widget.

The VREF widget is only used internally as a source for the VREF input of
the Out3 Mux. Selecting that input means that the path should be kept
powered up at the VREF/VMID voltage, but that there is no actual audio
signal. Using a VMID widget will do this, whereas using a OUTPUT widget will
simply cause the path to completely power down.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index f6847fd..eb0a164 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -323,7 +323,7 @@ static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("ROUT2"),
 	SND_SOC_DAPM_OUTPUT("MONO1"),
 	SND_SOC_DAPM_OUTPUT("OUT3"),
-	SND_SOC_DAPM_OUTPUT("VREF"),
+	SND_SOC_DAPM_VMID("VREF"),
 
 	SND_SOC_DAPM_INPUT("LINPUT1"),
 	SND_SOC_DAPM_INPUT("LINPUT2"),
-- 
1.8.0
