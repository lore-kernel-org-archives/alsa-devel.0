From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dapm: Ensure kcontrol list is initialised
Date: Tue, 13 Aug 2013 00:21:11 +0100
Message-ID: <1376349671-27655-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C1E6726510F
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 01:21:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Ensure that the recently added path kcontrol list is initialised otherwise
we may crash trying to delete routes that don't have kcontrols.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/soc-dapm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b78eaa1..1e0e4ce 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2357,6 +2357,7 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	path->sink = wsink;
 	path->connected = connected;
 	INIT_LIST_HEAD(&path->list);
+	INIT_LIST_HEAD(&path->list_kcontrol);
 	INIT_LIST_HEAD(&path->list_source);
 	INIT_LIST_HEAD(&path->list_sink);
 
-- 
1.8.4.rc1
