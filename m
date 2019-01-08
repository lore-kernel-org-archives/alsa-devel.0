From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt274: Variable "buf" in function
	rt274_jack_detect() could be uninitialized" to the asoc tree
Date: Tue,  8 Jan 2019 16:17:07 +0000 (GMT)
Message-ID: <20190108161707.580AD112778C@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 05632266B98
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2019 17:17:15 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yizhuo <yzhai003@ucr.edu>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt274: Variable "buf" in function rt274_jack_detect() could be uninitialized

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4a8191aa9e057ea38279ef9e809265ba3966be40 Mon Sep 17 00:00:00 2001
From: Yizhuo <yzhai003@ucr.edu>
Date: Mon, 7 Jan 2019 12:12:32 -0800
Subject: [PATCH] ASoC: rt274: Variable "buf" in function rt274_jack_detect()
 could be uninitialized

In function rt274_jack_detect(), local variable "buf" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used to calculate "hp" and "mic" and
make their value unpredictable while those value are used
in the caller. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt274.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 9e88f7b25d38..adf59039a3b6 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -353,6 +353,7 @@ static void rt274_index_sync(struct snd_soc_component *component)
 static int rt274_jack_detect(struct rt274_priv *rt274, bool *hp, bool *mic)
 {
 	unsigned int buf;
+	int ret;
 
 	*hp = false;
 	*mic = false;
@@ -360,9 +361,15 @@ static int rt274_jack_detect(struct rt274_priv *rt274, bool *hp, bool *mic)
 	if (!rt274->component)
 		return -EINVAL;
 
-	regmap_read(rt274->regmap, RT274_GET_HP_SENSE, &buf);
+	ret = regmap_read(rt274->regmap, RT274_GET_HP_SENSE, &buf);
+	if (ret)
+		return ret;
+
 	*hp = buf & 0x80000000;
-	regmap_read(rt274->regmap, RT274_GET_MIC_SENSE, &buf);
+	ret = regmap_read(rt274->regmap, RT274_GET_MIC_SENSE, &buf);
+	if (ret)
+		return ret;
+
 	*mic = buf & 0x80000000;
 
 	pr_debug("*hp = %d *mic = %d\n", *hp, *mic);
-- 
2.20.1
