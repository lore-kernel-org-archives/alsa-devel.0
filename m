From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: ssm2602: Re-enable oscillator after
	suspend
Date: Tue, 27 Sep 2011 11:08:46 +0200
Message-ID: <1317114528-16736-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-133.synserver.de (smtp-out-134.synserver.de
	[212.40.185.134])
	by alsa0.perex.cz (Postfix) with ESMTP id AF923243DD
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 11:09:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, stable@kernel.org, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Currently the the internal oscillator is powered down when entering BIAS_OFF
state, but not re-enabled when going back to BIAS_STANDBY. As a result the
CODEC will stop working after suspend if the internal oscillator is used to
generate the sysclock signal. This patch fixes it by clearing the appropriate
bit in the power down register when the CODEC is re-enabled.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: stable@kernel.org
---
 sound/soc/codecs/ssm2602.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index cceb002..32d6c51 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -430,7 +430,8 @@ static int ssm2602_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 reg = snd_soc_read(codec, SSM2602_PWR) & 0xff7f;
+	u16 reg = snd_soc_read(codec, SSM2602_PWR);
+	reg &= ~(PWR_POWER_OFF | PWR_OSC_PDN);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-- 
1.7.2.5
