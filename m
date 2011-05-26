From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH for 2.6.40] ASoC: Fix power down for widgetless
	per-card DAPM context case
Date: Thu, 26 May 2011 16:32:18 +0300
Message-ID: <1306416738-8298-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AFA40103865
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 15:33:24 +0200 (CEST)
Received: by ewy6 with SMTP id 6so272299ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2011 06:33:21 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Commit 52ba67b ("ASoC: Force all DAPM contexts into the same bias state")
powers up all the DAPM contexts in a card if any DAPM context becomes
active. Unfortunately power down newer happens if per-card DAPM context
doesn't have any widgets.

Reason for this is that power state of per-card DAPM context without
widgets is never cleared and thus all the DAPM contexts remain permanently
active. Test for widgetless calling DAPM context in dapm_power_widgets()
doesn't work for per-card DAPM context since power change is never
originating from widgetless per-card DAPM context.

Fix this by pre-clearing power state flag of non-codec DAPM context at the
beginning of power sequence.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 456617e..999bb08 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1110,7 +1110,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	trace_snd_soc_dapm_start(card);
 
 	list_for_each_entry(d, &card->dapm_list, list)
-		if (d->n_widgets)
+		if (d->n_widgets || d->codec == NULL)
 			d->dev_power = 0;
 
 	/* Check which widgets we need to power and store them in
-- 
1.7.4.4
