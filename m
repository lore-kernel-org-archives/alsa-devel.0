From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] ASoC: dapm: Fix marking widgets dirty when
	a route is added
Date: Tue, 27 Aug 2013 15:50:54 +0200
Message-ID: <1377611461-3638-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-185.synserver.de (smtp-out-185.synserver.de
 [212.40.185.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 258C32607D7
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 15:49:36 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The current calls to dapm_mark_dirty() in snd_soc_dapm_add_path() are on a path
that is only reached if the sink widget is either a mixer or a mux. Move the
calls further up so they are called for all widget types.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d84bd0f..7e9afbc4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2374,6 +2374,9 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 			wsource->ext = 1;
 	}
 
+	dapm_mark_dirty(wsource, "Route added");
+	dapm_mark_dirty(wsink, "Route added");
+
 	/* connect static paths */
 	if (control == NULL) {
 		list_add(&path->list, &dapm->card->paths);
@@ -2436,9 +2439,6 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 		return 0;
 	}
 
-	dapm_mark_dirty(wsource, "Route added");
-	dapm_mark_dirty(wsink, "Route added");
-
 	return 0;
 err:
 	kfree(path);
-- 
1.8.0
