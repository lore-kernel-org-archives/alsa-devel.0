From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] ASoC: Add a sanity check before using dai
	driver name
Date: Tue, 22 Aug 2017 22:45:12 +0800
Message-ID: <20170822144512.12976-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D57AB266812
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 16:45:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, Jeffy Chen <jeffy.chen@rock-chips.com>, Takashi Iwai <tiwai@suse.com>, dolinux.peng@gmail.com
List-Id: alsa-devel@alsa-project.org

The dai driver's name is allowed to be NULL. So add a sanity check for
that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reported-by: Donglin Peng <dolinux.peng@gmail.com>
---

 sound/soc/soc-core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 77e7e2a11af0..8ab9ee2b460a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -978,11 +978,13 @@ struct snd_soc_dai *snd_soc_find_dai(
 		if (dlc->name && strcmp(component->name, dlc->name))
 			continue;
 		list_for_each_entry(dai, &component->dai_list, list) {
-			if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
-			    && strcmp(dai->driver->name, dlc->dai_name))
-				continue;
-
-			return dai;
+			if (!dlc->dai_name)
+				return dai;
+			if (!strcmp(dai->name, dlc->dai_name))
+				return dai;
+			if (dai->driver->name &&
+			    !strcmp(dai->driver->name, dlc->dai_name))
+				return dai;
 		}
 	}
 
-- 
2.11.0
