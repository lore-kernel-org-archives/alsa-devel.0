From: Dong Aisheng <b29396@freescale.com>
Subject: [RFC PATCH 1/1] ASoC: soc-dapm: warn if no avaiable
	path found for widget kcontrol
Date: Fri, 27 Jul 2012 19:19:01 +0800
Message-ID: <1343387941-25266-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id A8E81264F8F
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 13:31:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

From: Dong Aisheng <dong.aisheng@linaro.org>

This could help people know what's wrong going on if the required
path is not registered.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 sound/soc/soc-dapm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4d181df..b9b94c5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1879,6 +1879,9 @@ static int soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 		}
 	}
 
+	WARN(!found, "did not find dapm widget path associated with kcontrol %s\n",
+		kcontrol->id.name);
+
 	if (found) {
 		dapm_mark_dirty(widget, "mux change");
 		dapm_power_widgets(widget->dapm, SND_SOC_DAPM_STREAM_NOP);
-- 
1.7.0.4
