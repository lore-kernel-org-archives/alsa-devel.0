From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/5] ASoC: dapm: Adjust one function call
 together with a variable assignment
Date: Thu, 10 Aug 2017 15:04:05 +0200
Message-ID: <38a6abaa-8b6c-509d-468e-fa34cf81069d@users.sourceforge.net>
References: <e8013ddb-687d-ee56-8153-2791bb9f46fe@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id A399F2665D5
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 15:04:43 +0200 (CEST)
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
Date: Thu, 10 Aug 2017 14:34:35 +0200

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code place.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/soc-dapm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3fa9f023bff7..4eea84d821c4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3441,7 +3441,8 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 	const char *prefix;
 	int ret;
 
-	if ((w = dapm_cnew_widget(widget)) == NULL)
+	w = dapm_cnew_widget(widget);
+	if (!w)
 		return NULL;
 
 	switch (w->id) {
-- 
2.14.0
