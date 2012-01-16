From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm - Fix check for codec context in
	dapm_power_widgets().
Date: Mon, 16 Jan 2012 15:23:31 +0000
Message-ID: <1326727411-29737-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 10C4324733
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 16:24:21 +0100 (CET)
Received: by wicr5 with SMTP id r5so2782221wic.14
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 07:24:17 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Fixes a NULL pointer dereference in dapm_power_widgets() if the dapm context
has no codec.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3ad1f59..1f55ded 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1426,7 +1426,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			dapm->target_bias_level = SND_SOC_BIAS_ON;
 			break;
 		case SND_SOC_DAPM_STREAM_STOP:
-			if (dapm->codec->active)
+			if (dapm->codec && dapm->codec->active)
 				dapm->target_bias_level = SND_SOC_BIAS_ON;
 			else
 				dapm->target_bias_level = SND_SOC_BIAS_STANDBY;
-- 
1.7.5.4
