From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/11] ASoC: max98090: Remove unnecessary
	snd_soc_dapm_sync()
Date: Thu, 14 May 2015 11:20:00 +0200
Message-ID: <1431595203-12851-8-git-send-email-lars@metafoo.de>
References: <1431595203-12851-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-163.synserver.de (smtp-out-163.synserver.de
 [212.40.185.163])
 by alsa0.perex.cz (Postfix) with ESMTP id AF6992606BF
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 11:20:21 +0200 (CEST)
In-Reply-To: <1431595203-12851-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>, Sven Brandau <brandau@gmx.de>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Jerry Wong <jerry.wong@maximintegrated.com>, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
List-Id: alsa-devel@alsa-project.org

max98090_jack_work() doesn't modify the DAPM graph other than what's done
in snd_soc_jack_report(). snd_soc_jack_report() already calls
snd_soc_dapm_sync() internally, so there is no need to call it manually
and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max98090.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index c5736b2..5a0bd8a 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2186,7 +2186,6 @@ static void max98090_jack_work(struct work_struct *work)
 		struct max98090_priv,
 		jack_work.work);
 	struct snd_soc_codec *codec = max98090->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int status = 0;
 	int reg;
 
@@ -2265,8 +2264,6 @@ static void max98090_jack_work(struct work_struct *work)
 
 	snd_soc_jack_report(max98090->jack, status,
 			    SND_JACK_HEADSET | SND_JACK_BTN_0);
-
-	snd_soc_dapm_sync(dapm);
 }
 
 static irqreturn_t max98090_interrupt(int irq, void *data)
-- 
1.8.0
