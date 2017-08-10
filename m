From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/5] ASoC: dapm: Use kcalloc() in
	snd_soc_dapm_new_widgets()
Date: Thu, 10 Aug 2017 15:03:19 +0200
Message-ID: <62be9e32-1b8d-3980-7998-72f82c62a6fe@users.sourceforge.net>
References: <e8013ddb-687d-ee56-8153-2791bb9f46fe@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id A95FB26754E
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 15:03:26 +0200 (CEST)
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
Date: Thu, 10 Aug 2017 14:30:48 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kcalloc".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/soc-dapm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e673961210e6..3fa9f023bff7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3027,9 +3027,9 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 			continue;
 
 		if (w->num_kcontrols) {
-			w->kcontrols = kzalloc(w->num_kcontrols *
-						sizeof(struct snd_kcontrol *),
-						GFP_KERNEL);
+			w->kcontrols = kcalloc(w->num_kcontrols,
+					       sizeof(*w->kcontrols),
+					       GFP_KERNEL);
 			if (!w->kcontrols) {
 				mutex_unlock(&card->dapm_mutex);
 				return -ENOMEM;
-- 
2.14.0
