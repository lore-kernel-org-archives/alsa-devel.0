From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix DAPM sequence run for per-widget I/O
	methods
Date: Sun, 19 Jun 2011 13:49:50 +0100
Message-ID: <1308487790-13071-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C43BF247A7
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Jun 2011 14:49:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Previously we were using the DAPM context rather than a widget as the
argument for update_bits() so we didn't need to care that our list walk
of widgets left us one beyond the end of the list. Now we're using them
for the register update we need to make sure we're pointing at an actual
widget not the list_head.

Fix originally suggested by Liam on IM.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 605c225..ceb2ba4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -918,6 +918,12 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 	}
 
 	if (reg >= 0) {
+		/* Any widget will do, they should all be updating the
+		 * same register.
+		 */
+		w = list_first_entry(pending, struct snd_soc_dapm_widget,
+				     power_list);
+
 		pop_dbg(dapm->dev, card->pop_time,
 			"pop test : Applying 0x%x/0x%x to %x in %dms\n",
 			value, mask, reg, card->pop_time);
-- 
1.7.5.4
