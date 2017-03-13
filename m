From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l35: trivial fix to indentation" to
	the asoc tree
Date: Mon, 13 Mar 2017 16:57:55 +0000
Message-ID: <E1cnTIB-00052K-AK@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 131D1266D09
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:58:10 +0100 (CET)
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
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: trivial fix to indentation

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 03ff570c6b45b27e233f5cb1fd04404374fd883f Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sat, 11 Mar 2017 19:19:22 +0000
Subject: [PATCH] ASoC: cs35l35: trivial fix to indentation

Remove extraneous tab to correct the nesting level indentation

Detected by CoverityScan, CID#1416584 ("Nesting level does
not match indentation")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l35.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index a9e45dea309e..a5da1d511a8a 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1375,7 +1375,8 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 
 	for (i = 0; i < ARRAY_SIZE(cs35l35_supplies); i++)
 		cs35l35->supplies[i].supply = cs35l35_supplies[i];
-		cs35l35->num_supplies = ARRAY_SIZE(cs35l35_supplies);
+
+	cs35l35->num_supplies = ARRAY_SIZE(cs35l35_supplies);
 
 	ret = devm_regulator_bulk_get(dev, cs35l35->num_supplies,
 				      cs35l35->supplies);
-- 
2.11.0
