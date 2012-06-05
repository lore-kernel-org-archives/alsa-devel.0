From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm: Fix input list to use source
	widgets.
Date: Tue,  5 Jun 2012 19:27:15 +0100
Message-ID: <1338920835-5281-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog130.obsmtp.com (na3sys009aog130.obsmtp.com
	[74.125.149.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 33BED1043B9
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 20:27:27 +0200 (CEST)
Received: by wgbds1 with SMTP id ds1so3389366wgb.0
	for <alsa-devel@alsa-project.org>; Tue, 05 Jun 2012 11:27:20 -0700 (PDT)
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

We should only add source widgets to the input list.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9a67a75..20b3402 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -928,7 +928,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 			/* do we need to add this widget to the list ? */
 			if (list) {
 				int err;
-				err = dapm_list_add_widget(list, path->sink);
+				err = dapm_list_add_widget(list, path->source);
 				if (err < 0) {
 					dev_err(widget->dapm->dev, "could not add widget %s\n",
 						widget->name);
-- 
1.7.9.5
