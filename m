From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: Consider the codec->active also when
	changing bias level
Date: Mon, 28 Sep 2009 12:38:08 +0300
Message-ID: <1254130688-6183-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id ADEB424481
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Sep 2009 11:38:37 +0200 (CEST)
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

Take into account the codec->active (playback/capture activity)
when changing the bias level.

Fixes the following scenario: if during active playback/capture the DAPM
routes has been modified in a way, that there will be no complete route
(for example muting the output) DAPM would set the codec into
BIAS_STANDBY, which could disable the clocks from the codec (codec is
master), which breaks the playback with error since the clocks are
missing from the serial bus and no data is shifted out/in.

With this patch during active use (playback/capture) the DAPM will not
set the bias to STANDBY, thus keeping the playback/capture running.
When no playback/capture is running, the DAPM will handle the complete
paths in a same way it used to: setting the bias to ON/STANDBY based on
complete paths.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9babda5..567be82 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -977,7 +977,7 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 				continue;
 
 			power = w->power_check(w);
-			if (power)
+			if (power || codec->active)
 				sys_power = 1;
 
 			if (w->power == power)
-- 
1.6.5.rc1
