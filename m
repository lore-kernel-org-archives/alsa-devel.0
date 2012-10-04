From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl6040: Fix Stream DAPM mapping
Date: Thu,  4 Oct 2012 14:15:02 +0300
Message-ID: <1349349302-8053-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog131.obsmtp.com (na3sys009aog131.obsmtp.com
 [74.125.149.247])
 by alsa0.perex.cz (Postfix) with ESMTP id A31AF264F25
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 13:14:01 +0200 (CEST)
Received: by mail-oa0-f51.google.com with SMTP id n12so300434oag.38
 for <alsa-devel@alsa-project.org>; Thu, 04 Oct 2012 04:13:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fixes commit: 805238b ASoC: twl6040: Convert to use DAI DAPM widgets
where the connection between the stream widgets and the ADC widgets was
reversed and because of this on capture the DAPM is not powering up the
codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi Mark, Liam,

in the mentioned commit I made a mistake and the DAPM route got reversed for
capture. I did the same change for twl4030 and twl6040 at the same time and only
tested twl4030 - since it was easier for me. Obviously I did it wrong for
twl6040 :(

Can you queue this as a fix for 3.7?

Thank you,
Peter

 sound/soc/codecs/twl6040.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index e8f97af..00b85cc 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -820,10 +820,10 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"VIBRA DAC", NULL, "Vibra Playback"},
 
 	/* ADC -> Stream mapping */
-	{"ADC Left", NULL, "Legacy Capture"},
-	{"ADC Left", NULL, "Capture"},
-	{"ADC Right", NULL, "Legacy Capture"},
-	{"ADC Right", NULL, "Capture"},
+	{"Legacy Capture" , NULL, "ADC Left"},
+	{"Capture", NULL, "ADC Left"},
+	{"Legacy Capture", NULL, "ADC Right"},
+	{"Capture" , NULL, "ADC Right"},
 
 	/* Capture path */
 	{"Analog Left Capture Route", "Headset Mic", "HSMIC"},
-- 
1.7.12
