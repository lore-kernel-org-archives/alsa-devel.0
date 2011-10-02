From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/3] ASoC: tegra: Staticise tegra_i2s_dai and
 tegra_spdif_dai
Date: Sun, 02 Oct 2011 17:41:40 +0800
Message-ID: <1317548500.16362.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 2368124468
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 11:41:50 +0200 (CEST)
Received: by pzd13 with SMTP id 13so8989030pzd.2
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 02:41:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/tegra/tegra_i2s.c   |    2 +-
 sound/soc/tegra/tegra_spdif.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra_i2s.c b/sound/soc/tegra/tegra_i2s.c
index f36b996..6728fab 100644
--- a/sound/soc/tegra/tegra_i2s.c
+++ b/sound/soc/tegra/tegra_i2s.c
@@ -312,7 +312,7 @@ static struct snd_soc_dai_ops tegra_i2s_dai_ops = {
 	.trigger	= tegra_i2s_trigger,
 };
 
-struct snd_soc_dai_driver tegra_i2s_dai[] = {
+static struct snd_soc_dai_driver tegra_i2s_dai[] = {
 	{
 		.name = DRV_NAME ".0",
 		.probe = tegra_i2s_probe,
diff --git a/sound/soc/tegra/tegra_spdif.c b/sound/soc/tegra/tegra_spdif.c
index abe606b..1bd07d1 100644
--- a/sound/soc/tegra/tegra_spdif.c
+++ b/sound/soc/tegra/tegra_spdif.c
@@ -232,7 +232,7 @@ static struct snd_soc_dai_ops tegra_spdif_dai_ops = {
 	.trigger	= tegra_spdif_trigger,
 };
 
-struct snd_soc_dai_driver tegra_spdif_dai = {
+static struct snd_soc_dai_driver tegra_spdif_dai = {
 	.name = DRV_NAME,
 	.probe = tegra_spdif_probe,
 	.playback = {
-- 
1.7.4.1
