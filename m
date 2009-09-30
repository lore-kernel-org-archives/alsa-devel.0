From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: Fix SND_SOC_DAPM_LINE handling
Date: Wed, 30 Sep 2009 09:27:24 +0300
Message-ID: <1254292044-26634-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1254292044-26634-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id C5F2B10380F
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 08:27:40 +0200 (CEST)
In-Reply-To: <1254292044-26634-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Since the SND_SOC_DAPM_LINE can be input or output, additional check is
needed in order to determine if the widget is connected as input or
output.
When checking for connected outputs, if the widget is line, than check
if the sources list is not empty (line is connected as output)
For input endpoint check, when the widget is line, also check if the
sinks list is not empty (line is connected as input).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/soc-dapm.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9babda5..8eaf1b6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -524,7 +524,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 
 		/* connected jack or spk ? */
 		if (widget->id == snd_soc_dapm_hp || widget->id == snd_soc_dapm_spk ||
-			widget->id == snd_soc_dapm_line)
+		    (widget->id == snd_soc_dapm_line && !list_empty(&widget->sources)))
 			return 1;
 	}
 
@@ -573,7 +573,8 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 			return 1;
 
 		/* connected jack ? */
-		if (widget->id == snd_soc_dapm_mic || widget->id == snd_soc_dapm_line)
+		if (widget->id == snd_soc_dapm_mic ||
+		    (widget->id == snd_soc_dapm_line && !list_empty(&widget->sinks)))
 			return 1;
 	}
 
-- 
1.6.5.rc1
