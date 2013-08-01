From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: dapm: Check return value of
	snd_soc_cnew()
Date: Thu,  1 Aug 2013 14:08:06 +0200
Message-ID: <1375358887-9160-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-136.synserver.de (smtp-out-136.synserver.de
 [212.40.185.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E727260308
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 14:07:06 +0200 (CEST)
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

snd_soc_cnew() can return NULL, so we should check the result before trying to
use it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d74c356..b4fae87 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -671,8 +671,10 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 
 		kcontrol = snd_soc_cnew(&w->kcontrol_news[kci], NULL, name,
 					prefix);
-		kcontrol->private_free = dapm_kcontrol_free;
 		kfree(long_name);
+		if (!kcontrol)
+			return -ENOMEM;
+		kcontrol->private_free = dapm_kcontrol_free;
 
 		ret = dapm_kcontrol_data_alloc(w, kcontrol);
 		if (ret) {
-- 
1.8.0
