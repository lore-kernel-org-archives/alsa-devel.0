From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Fix deadlock on auto-disable mux
	controls
Date: Fri, 26 Jun 2015 10:39:43 +0100
Message-ID: <1435311583-18695-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 43A002614D3
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 11:54:23 +0200 (CEST)
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

The commit 02aa78abec6e ("ASoC: DAPM: Add APIs to create individual DAPM
controls.") added locking to the snd_soc_dapm_new_control function but
did not update the call to snd_soc_dapm_new_control in the auto-disable
mux code, this appears to be because the patches were sent at fairly
similar times.

This patch change the call in the auto-disable mux code to use the new
snd_soc_dapm_new_control_unlocked function instead.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index aa327c9..a47a8ce 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -389,8 +389,8 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 
 			data->value = template.on_val;
 
-			data->widget = snd_soc_dapm_new_control(widget->dapm,
-					&template);
+			data->widget = snd_soc_dapm_new_control_unlocked(
+						widget->dapm, &template);
 			if (!data->widget) {
 				ret = -ENOMEM;
 				goto err_name;
-- 
1.7.2.5
