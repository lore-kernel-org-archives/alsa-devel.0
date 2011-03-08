From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Warn rather than set a silly
	constraint when we can't do symmetry
Date: Tue,  8 Mar 2011 13:56:20 +0000
Message-ID: <1299592580-3759-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299592580-3759-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B9AD10391D
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 14:56:01 +0100 (CET)
In-Reply-To: <1299592580-3759-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Symmetric rate configuration can fail if the second stream starting tries
to apply the symmetric constraint before the first stream has got far
enough to pick a rate. Rather than try to enforce a nonsensical rate of
0Hz log a warning and allow the application to carry on. Things might go
wrong later on but the user will know about it and there's unlikely to be
lasting damage.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 65ff612..db3075d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -505,6 +505,16 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
 	    !rtd->dai_link->symmetric_rates)
 		return 0;
 
+	/* This can happen if multiple streams are starting simultaneously -
+	 * the second can need to get its constraints before the first has
+	 * picked a rate.  Complain and allow the application to carry on.
+	 */
+	if (!rtd->rate) {
+		dev_warn(&rtd->dev,
+			 "Not enforcing symmetric_rates due to race\n");
+		return 0;
+	}
+
 	dev_dbg(&rtd->dev, "Symmetry forces %dHz rate\n", rtd->rate);
 
 	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
-- 
1.7.2.3
