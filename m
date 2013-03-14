From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: dapm: Fix pointer dereference in
	is_connected_output_ep()
Date: Thu, 14 Mar 2013 21:26:24 +0100
Message-ID: <1363292784-20537-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EAD82615E8
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2013 21:26:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

*path is not yet initialized when we check if the widget is connected.

The compiler also warns about this:
sound/soc/soc-dapm.c: In function 'is_connected_output_ep':
sound/soc/soc-dapm.c:824:18: warning: 'path' may be used uninitialized in this function

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Mark, Liam,

This patch is for the for-next branch.
I got NULL pointer dereference because of this depending on the used toolchain.

Regards,
Peter

 sound/soc/soc-dapm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index eaf9b74..33acd8b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -821,7 +821,6 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 		    (widget->id == snd_soc_dapm_line &&
 		     !list_empty(&widget->sources))) {
 			widget->outputs = snd_soc_dapm_suspend_check(widget);
-			path->walking = 0;
 			return widget->outputs;
 		}
 	}
-- 
1.8.1.5
