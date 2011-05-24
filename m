From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: Fix dapm_is_shared_kcontrol so
	everything isn't shared
Date: Tue, 24 May 2011 17:12:01 -0600
Message-ID: <1306278721-32742-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id B91A11037F5
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 01:12:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Commit af46800 ("ASoC: Implement mux control sharing") introduced
function dapm_is_shared_kcontrol.

When this function returns true, the naming of DAPM controls is derived
from the kcontrol_new. Otherwise, the name comes from the widget (and
possibly a widget's naming prefix).

A bug in the implementation of dapm_is_shared_kcontrol made it return 1
in all cases. Hence, that commit caused a change in control naming for
all controls instead of just shared controls.

Specifically, a control is always considered shared because it is always
compared against itself. Solve this by never comparing against the widget
containing the control being created.

I tested that with the Tegra WM8903 driver:
* Shared is now mostly 0 as expected, and sometimes 1.
* The expected controls are still generated after this change.

Howwever, I don't have any systems that have a widget/control naming
prefix, so I can't test that aspect.

Reported-by: Liam Girdwood <lrg@ti.com>
Root-caused-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-dapm.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 456617e..5397699 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -325,6 +325,7 @@ static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
 }
 
 static int dapm_is_shared_kcontrol(struct snd_soc_dapm_context *dapm,
+	struct snd_soc_dapm_widget *kcontrolw,
 	const struct snd_kcontrol_new *kcontrol_new,
 	struct snd_kcontrol **kcontrol)
 {
@@ -334,6 +335,8 @@ static int dapm_is_shared_kcontrol(struct snd_soc_dapm_context *dapm,
 	*kcontrol = NULL;
 
 	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (w == kcontrolw)
+			continue;
 		for (i = 0; i < w->num_kcontrols; i++) {
 			if (&w->kcontrol_news[i] == kcontrol_new) {
 				if (w->kcontrols)
@@ -468,7 +471,7 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 		return -EINVAL;
 	}
 
-	shared = dapm_is_shared_kcontrol(dapm, &w->kcontrol_news[0],
+	shared = dapm_is_shared_kcontrol(dapm, w, &w->kcontrol_news[0],
 					 &kcontrol);
 	if (kcontrol) {
 		wlist = kcontrol->private_data;
-- 
1.7.0.4
nvpublic
