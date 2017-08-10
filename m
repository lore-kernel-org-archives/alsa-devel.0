From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/5] ASoC: dapm: Improve a size determination
	in two functions
Date: Thu, 10 Aug 2017 15:02:35 +0200
Message-ID: <16fbe262-3b6b-2395-be43-285dc2ff5420@users.sourceforge.net>
References: <e8013ddb-687d-ee56-8153-2791bb9f46fe@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id DCEE5267572
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 15:02:42 +0200 (CEST)
In-Reply-To: <e8013ddb-687d-ee56-8153-2791bb9f46fe@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 10 Aug 2017 14:15:47 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/soc-dapm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3adb914bc009..e673961210e6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2651,7 +2651,7 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	if (ret)
 		return ret;
 
-	path = kzalloc(sizeof(struct snd_soc_dapm_path), GFP_KERNEL);
+	path = kzalloc(sizeof(*path), GFP_KERNEL);
 	if (!path)
 		return -ENOMEM;
 
@@ -3859,10 +3859,9 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	}
 	kcontrol_dai_link[0].private_value = private_value;
 	/* duplicate kcontrol_dai_link on heap so that memory persists */
-	template.kcontrol_news =
-				devm_kmemdup(card->dev, &kcontrol_dai_link[0],
-					sizeof(struct snd_kcontrol_new),
-					GFP_KERNEL);
+	template.kcontrol_news = devm_kmemdup(card->dev, &kcontrol_dai_link[0],
+					      sizeof(*template.kcontrol_news),
+					      GFP_KERNEL);
 	if (!template.kcontrol_news) {
 		ret = -ENOMEM;
 		goto outfree_private_value;
-- 
2.14.0
