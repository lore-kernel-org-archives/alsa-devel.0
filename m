From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: dapm: Fix empty list check in
	dapm_new_mux()
Date: Thu,  1 Aug 2013 18:30:38 +0200
Message-ID: <1375374638-28305-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-139.synserver.de (smtp-out-139.synserver.de
 [212.40.185.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 07C2D260895
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 18:29:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

list_first_entry() will always return a valid pointer, even if the list is
empty. So the check whether path is NULL will always be false. So we end up
calling dapm_create_or_share_mixmux_kcontrol() with a path struct that points
right in the middle of the widget struct and by trying to modify the path the
widgets memory will become corrupted. Fix this by using list_emtpy() to check if
the widget doesn't have any paths.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
This is the real fix for the rt5640 crash.
---
 sound/soc/soc-dapm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5f64c16..196cea7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -747,13 +747,14 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 		return -EINVAL;
 	}
 
-	path = list_first_entry(&w->sources, struct snd_soc_dapm_path,
-				list_sink);
-	if (!path) {
+	if (list_empty(&w->sources)) {
 		dev_err(dapm->dev, "ASoC: mux %s has no paths\n", w->name);
 		return -EINVAL;
 	}
 
+	path = list_first_entry(&w->sources, struct snd_soc_dapm_path,
+				list_sink);
+
 	ret = dapm_create_or_share_mixmux_kcontrol(w, 0, path);
 	if (ret < 0)
 		return ret;
-- 
1.8.0
