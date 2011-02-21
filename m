From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: omap: rx51: Add FM transmitter support
Date: Mon, 21 Feb 2011 14:57:22 +0200
Message-ID: <1298293042-13801-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f50.google.com (mail-ew0-f50.google.com
	[209.85.215.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 6342F1037E3
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 13:56:44 +0100 (CET)
Received: by ewy26 with SMTP id 26so933199ewy.23
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 04:56:43 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Si4713 FM transmitter on Nokia RX-51/N900 is connected to same Line out
signals of TLV320AIC34 than TPA6130 headphone amplifier.

This patch adds route to transmitter and "FM Transmitter" control to keep
route active when needed.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
- Liam: This goes on top of previous rx51 update (I didn't find those from
  your tree):
  http://mailman.alsa-project.org/pipermail/alsa-devel/2011-February/036972.html
- For those who are keen to try you need following patch in order to be able
  to activate the FM transmitter:
  http://marc.info/?l=linux-omap&m=129827572706543&w=2
  Otherwise there is no any build or runtime dependency to Si4713 driver.
---
 sound/soc/omap/rx51.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index e28f089..055e447 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -251,6 +251,7 @@ static const struct snd_soc_dapm_widget aic34_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("DMic", NULL),
 	SND_SOC_DAPM_HP("Headphone Jack", rx51_hp_event),
 	SND_SOC_DAPM_MIC("HS Mic", NULL),
+	SND_SOC_DAPM_LINE("FM Transmitter", NULL),
 };
 
 static const struct snd_soc_dapm_widget aic34_dapm_widgetsb[] = {
@@ -262,6 +263,8 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Ext Spk", NULL, "HPROUT"},
 	{"Headphone Jack", NULL, "LLOUT"},
 	{"Headphone Jack", NULL, "RLOUT"},
+	{"FM Transmitter", NULL, "LLOUT"},
+	{"FM Transmitter", NULL, "RLOUT"},
 
 	{"DMic Rate 64", NULL, "Mic Bias 2V"},
 	{"Mic Bias 2V", NULL, "DMic"},
@@ -292,6 +295,7 @@ static const struct snd_kcontrol_new aic34_rx51_controls[] = {
 		     rx51_get_input, rx51_set_input),
 	SOC_ENUM_EXT("Jack Function", rx51_enum[2],
 		     rx51_get_jack, rx51_set_jack),
+	SOC_DAPM_PIN_SWITCH("FM Transmitter"),
 };
 
 static const struct snd_kcontrol_new aic34_rx51_controlsb[] = {
-- 
1.7.2.3
