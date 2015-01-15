From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/17] ASoC: mioa701_wm9713: Fix speaker event
Date: Thu, 15 Jan 2015 12:52:01 +0100
Message-ID: <1421322737-19077-2-git-send-email-lars@metafoo.de>
References: <1421322737-19077-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 622F326055F
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:52:23 +0100 (CET)
In-Reply-To: <1421322737-19077-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Commit f6b2a04590bb ("ASoC: pxa: mioa701_wm9713: Convert to table based DAPM
setup") converted the driver to register the board level DAPM elements with
the card's DAPM context rather than the CODEC's DAPM context. The change
overlooked that the speaker widget event callback accesses the widget's
codec field which is only valid if the widget has been registered in a CODEC
DAPM context. This patch modifies the callback to take an alternative route
to get the CODEC.

Fixes: f6b2a04590bb ("ASoC: pxa: mioa701_wm9713: Convert to table based DAPM
setup")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/mioa701_wm9713.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 396dbd5..a9615a57 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -81,7 +81,7 @@ static int rear_amp_power(struct snd_soc_codec *codec, int power)
 static int rear_amp_event(struct snd_soc_dapm_widget *widget,
 			  struct snd_kcontrol *kctl, int event)
 {
-	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_codec *codec = widget->dapm->card->rtd[0].codec;
 
 	return rear_amp_power(codec, SND_SOC_DAPM_EVENT_ON(event));
 }
-- 
1.8.0
