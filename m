From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: topology: avoid uninitialized kcontrol_type
Date: Fri,  9 Dec 2016 12:51:46 +0100
Message-ID: <20161209115207.3885433-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Mengdong Lin <mengdong.lin@linux.intel.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When num_kcontrols is zero, widget->dobj.widget.kcontrol_type
gets set to an uninitialized local variable:

sound/soc/soc-topology.c: In function 'soc_tplg_dapm_widget_create':
sound/soc/soc-topology.c:1566:36: error: 'kcontrol_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]

I could not figure out which of the valid types would be appropriate
here, so this sets it to '0', which is invalid but at least well-defined
here. There is probably a better way to address the issue.

Fixes: eea3dd4f1247 ("ASoC: topology: Only free TLV for volume mixers of a widget")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/soc-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 11feb19e9730..65670b2b408c 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1485,6 +1485,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	tplg->pos +=
 		(sizeof(struct snd_soc_tplg_dapm_widget) + w->priv.size);
 	if (w->num_kcontrols == 0) {
+		kcontrol_type = 0;
 		template.num_kcontrols = 0;
 		goto widget;
 	}
-- 
2.9.0
