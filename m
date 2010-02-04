From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ASoC: pandora: Add APLL supply to fix audio
	output
Date: Fri,  5 Feb 2010 00:55:33 +0200
Message-ID: <1265324133-23607-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 90718103807
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 23:56:06 +0100 (CET)
Received: by ewy23 with SMTP id 23so9004ewy.4
	for <alsa-devel@alsa-project.org>; Thu, 04 Feb 2010 14:56:04 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

Pandora's external DAC is using 256*Fs output from the TWL4030
codec, and TWL4030 needs to have APLL enabled for it's 256*Fs
output to function.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
I noticed this a bit late because TWL4030 codec used to have APLL
enable hardcoded until that was clean up by not-so-old patch.
Would be nice to see this in next -rc, as without this audio
won't work completely on pandora (again)..

 sound/soc/omap/omap3pandora.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 71b2c16..68980c1 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -145,6 +145,7 @@ static const struct snd_soc_dapm_widget omap3pandora_in_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route omap3pandora_out_map[] = {
+	{"PCM DAC", NULL, "APLL Enable"},
 	{"Headphone Amplifier", NULL, "PCM DAC"},
 	{"Line Out", NULL, "PCM DAC"},
 	{"Headphone Jack", NULL, "Headphone Amplifier"},
-- 
1.6.3.3
