From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: Add missing comma to
	SND_SOC_DAPM_SWITCH_E in soc-dapm.h
Date: Fri, 23 Jan 2009 10:08:35 +0200
Message-ID: <1232698115-22270-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B5761037E3
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 09:09:19 +0100 (CET)
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Typo fix.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/soc-dapm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 0accdba..bb3a863 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -118,7 +118,7 @@
 #define SND_SOC_DAPM_SWITCH_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
 {	.id = snd_soc_dapm_switch, .name = wname, .reg = wreg, .shift = wshift, \
-	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1 \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
 #define SND_SOC_DAPM_MUX_E(wname, wreg, wshift, winvert, wcontrols, \
 	wevent, wflags) \
-- 
1.6.1
