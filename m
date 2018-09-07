From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: dapm: Fix a couple uninitialized ret
	variables
Date: Fri, 7 Sep 2018 22:40:33 +0300
Message-ID: <20180907194033.cmt4rdiwwznaeudq@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C12826781E
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2018 21:40:46 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Smatch complains that these variables could be uninitialized.  The first
one in snd_soc_dai_link_event() is probably a false positive, because
probably we know the lists are not empty.  I would normally ignore the
warning, but GCC complains here as well so I just silenced the warning.
The "ret" in snd_soc_dapm_new_dai() does need to be initialized or it
leads to a bogus dereference in the caller.

Fixes: 3bbf5d34fd4a ("ASoC: dapm: Move error handling to snd_soc_dapm_new_control_unlocked")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9f4edcd19e02..0dcdcc23dcfd 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3623,7 +3623,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	struct snd_pcm_hw_params *params = NULL;
 	struct snd_pcm_runtime *runtime = NULL;
 	unsigned int fmt;
-	int ret;
+	int ret = 0;
 
 	config = rtd->dai_link->params + rtd->params_select;
 
@@ -3938,8 +3938,10 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 	dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
 
 	w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
-	if (IS_ERR(w))
+	if (IS_ERR(w)) {
+		ret = PTR_ERR(w);
 		goto outfree_kcontrol_news;
+	}
 
 	w->priv = rtd;
 
