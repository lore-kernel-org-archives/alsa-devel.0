From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/3] ASoC: TWL4030: Add missing Carkit output
Date: Wed, 10 Dec 2008 12:51:46 +0200
Message-ID: <1228906308-17374-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1228906308-17374-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 413602440E
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 11:51:58 +0100 (CET)
In-Reply-To: <1228906308-17374-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

SND_SOC_DAPM_OUTPUT definition for carkitL/R was missing.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 373daa4..df9f2ce 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -761,6 +761,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("PREDRIVER"),
 	SND_SOC_DAPM_OUTPUT("HSOL"),
 	SND_SOC_DAPM_OUTPUT("HSOR"),
+	SND_SOC_DAPM_OUTPUT("CARKITL"),
+	SND_SOC_DAPM_OUTPUT("CARKITR"),
 	SND_SOC_DAPM_OUTPUT("HFL"),
 	SND_SOC_DAPM_OUTPUT("HFR"),
 
-- 
1.6.0.4
