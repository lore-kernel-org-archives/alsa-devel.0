From: Graeme Gregory <dp@xora.org.uk>
Subject: [PATCH] [PATCH] [ASOC] pxa-ssp increase max_channels
	to 8
Date: Fri, 25 Sep 2009 13:30:26 +0100
Message-ID: <1253881826-7954-1-git-send-email-dp@xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225])
	by alsa0.perex.cz (Postfix) with ESMTP id A36F01037F7
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 14:31:01 +0200 (CEST)
Received: by ewy25 with SMTP id 25so2511862ewy.45
	for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2009 05:30:59 -0700 (PDT)
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
Cc: Graeme Gregory <dp@xora.org.uk>
List-Id: alsa-devel@alsa-project.org

When running in TDM mode there can be more than 2 channels used. Datasheet has
figures for upto 8 channels so increase max_channels on all SSP interfaces to
this figure.

Signed-off-by: Graeme Gregory <dp@xora.org.uk>
---
 sound/soc/pxa/pxa-ssp.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 19c4540..e8a5629 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -767,13 +767,13 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 		.resume = pxa_ssp_resume,
 		.playback = {
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 8,
 			.rates = PXA_SSP_RATES,
 			.formats = PXA_SSP_FORMATS,
 		},
 		.capture = {
 			 .channels_min = 1,
-			 .channels_max = 2,
+			 .channels_max = 8,
 			.rates = PXA_SSP_RATES,
 			.formats = PXA_SSP_FORMATS,
 		 },
@@ -787,13 +787,13 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 		.resume = pxa_ssp_resume,
 		.playback = {
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 8,
 			.rates = PXA_SSP_RATES,
 			.formats = PXA_SSP_FORMATS,
 		},
 		.capture = {
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 8,
 			.rates = PXA_SSP_RATES,
 			.formats = PXA_SSP_FORMATS,
 		 },
@@ -808,13 +808,13 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 		.resume = pxa_ssp_resume,
 		.playback = {
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 8,
 			.rates = PXA_SSP_RATES,
 			.formats = PXA_SSP_FORMATS,
 		},
 		.capture = {
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 8,
 			.rates = PXA_SSP_RATES,
 			.formats = PXA_SSP_FORMATS,
 		 },
@@ -829,13 +829,13 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 		.resume = pxa_ssp_resume,
 		.playback = {
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 8,
 			.rates = PXA_SSP_RATES,
 			.formats = PXA_SSP_FORMATS,
 		},
 		.capture = {
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 8,
 			.rates = PXA_SSP_RATES,
 			.formats = PXA_SSP_FORMATS,
 		 },
-- 
1.6.3.3
