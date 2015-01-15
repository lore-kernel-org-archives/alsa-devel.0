From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 17/17] ASoC: Remove codec field from
	snd_soc_dapm_widget
Date: Thu, 15 Jan 2015 12:52:17 +0100
Message-ID: <1421322737-19077-18-git-send-email-lars@metafoo.de>
References: <1421322737-19077-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 70A0126046F
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:52:30 +0100 (CET)
In-Reply-To: <1421322737-19077-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

There are no more users of this field left so it can finally be removed.
New users should use snd_soc_dapm_to_codec(w->dapm);

The reason why it is removed is because it doesn't fit to well anymore in
the componentized ASoC hierarchy, where DAPM works on the snd_soc_component
level. And the alternative of snd_soc_dapm_to_codec(w->dapm) typically
generates the same amount of code, so there is really no reason to keep it.

For automatic conversion the following coccinelle semantic patch can be used:
// <smpl>
@@
struct snd_soc_dapm_widget *w;
@@
-w->codec
+snd_soc_dapm_to_codec(w->dapm)
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h | 1 -
 sound/soc/soc-dapm.c     | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index ecffecc..5c0a798 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -525,7 +525,6 @@ struct snd_soc_dapm_widget {
 	enum snd_soc_dapm_type id;
 	const char *name;		/* widget name */
 	const char *sname;	/* stream name */
-	struct snd_soc_codec *codec;
 	struct list_head list;
 	struct snd_soc_dapm_context *dapm;
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0be3ca5..bc2d7a0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3144,8 +3144,6 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	}
 
 	w->dapm = dapm;
-	if (dapm->component)
-		w->codec = dapm->component->codec;
 	INIT_LIST_HEAD(&w->sources);
 	INIT_LIST_HEAD(&w->sinks);
 	INIT_LIST_HEAD(&w->list);
-- 
1.8.0
