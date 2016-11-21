From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Only write shutdown controls
	for active firmwares
Date: Mon, 21 Nov 2016 18:00:02 +0000
Message-ID: <1479751202-17749-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D764261A1A
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2016 18:59:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The control list may contain shutdown controls for firmwares that are
not currently active, attempting to write this will at best fail. To
avoid this issue we skip any control that is not active.

Fixes: commit f4f0c4c60c39 ("ASoC: wm_adsp: Signal firmware shutdown
                             through event control")
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 4fb6e2f..6ccb731 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1194,6 +1194,9 @@ static void wm_adsp_signal_event_controls(struct wm_adsp *dsp,
 		if (ctl->type != WMFW_CTL_TYPE_HOSTEVENT)
 			continue;
 
+		if (!ctl->enabled)
+			continue;
+
 		ret = wm_coeff_write_acked_control(ctl, event);
 		if (ret)
 			adsp_warn(dsp,
-- 
2.1.4
