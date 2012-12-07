From: Paul Handrigan <Paul.Handrigan@cirrus.com>
Subject: [PATCH 1/3] ASoC: cs42l73: Add DMIC's as DAPM inputs.
Date: Fri, 7 Dec 2012 14:53:42 -0600
Message-ID: <1354913625-11350-1-git-send-email-Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 161EE26513F
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 22:13:43 +0100 (CET)
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
Cc: brian.austin@cirrus.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
---
 sound/soc/codecs/cs42l73.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 2c08c4c..4766795 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -589,6 +589,8 @@ static const struct snd_kcontrol_new cs42l73_snd_controls[] = {
 };
 
 static const struct snd_soc_dapm_widget cs42l73_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("DMICA"),
+	SND_SOC_DAPM_INPUT("DMICB"),
 	SND_SOC_DAPM_INPUT("LINEINA"),
 	SND_SOC_DAPM_INPUT("LINEINB"),
 	SND_SOC_DAPM_INPUT("MIC1"),
@@ -795,6 +797,8 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
 
 	{"ADC Left", NULL, "PGA Left"},
 	{"ADC Right", NULL, "PGA Right"},
+	{"DMIC Left", NULL, "DMICA"},
+	{"DMIC Right", NULL, "DMICB"},
 
 	{"Input Left Capture", "ADC Left Input", "ADC Left"},
 	{"Input Right Capture", "ADC Right Input", "ADC Right"},
-- 
1.7.0.4
