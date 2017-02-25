From: Camelia Moise <camelia.moise21@gmail.com>
Subject: [PATCH] ASoC: mxs-saif: Removing whitespace before a
	pointer and its name
Date: Sat, 25 Feb 2017 12:37:18 +0200
Message-ID: <1488019038-11409-1-git-send-email-camelia.moise21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DE9A26683E
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 11:37:30 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id v77so6384294wmv.0
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 02:37:30 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, jk@lintech.de, broonie@kernel.org, Camelia Moise <camelia.moise21@gmail.com>, khoroshilov@ispras.ru
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Camelia Moise <camelia.moise21@gmail.com>
---
 sound/soc/mxs/mxs-saif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index b42f301..729249a 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -78,7 +78,7 @@ static int mxs_saif_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
  * from its master_id.
  * Note that the master could be itself.
  */
-static inline struct mxs_saif *mxs_saif_get_master(struct mxs_saif * saif)
+static inline struct mxs_saif *mxs_saif_get_master(struct mxs_saif *saif)
 {
 	return mxs_saif[saif->master_id];
 }
-- 
2.7.4
