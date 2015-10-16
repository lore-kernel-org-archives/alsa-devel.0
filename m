From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt298: correct index default value" to
	the asoc tree
Date: Fri, 16 Oct 2015 17:41:10 +0100
Message-ID: <E1Zn846-00087d-Id@debutante>
References: <1444980092-8801-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 52485260453
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 18:41:18 +0200 (CEST)
In-Reply-To: <1444980092-8801-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt298: correct index default value

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

>From 7ba6e4ef76c7e43101bd5e0f8987c11a8ed0d325 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Fri, 16 Oct 2015 15:21:32 +0800
Subject: [PATCH] ASoC: rt298: correct index default value

Some of the default value on rt298_index_def are incorrect. Change
them to the correct value.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 3c2f0f8d6266..d3e30a645ae3 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -50,24 +50,24 @@ struct rt298_priv {
 };
 
 static struct reg_default rt298_index_def[] = {
-	{ 0x01, 0xaaaa },
-	{ 0x02, 0x8aaa },
+	{ 0x01, 0xa5a8 },
+	{ 0x02, 0x8e95 },
 	{ 0x03, 0x0002 },
-	{ 0x04, 0xaf01 },
-	{ 0x08, 0x000d },
-	{ 0x09, 0xd810 },
-	{ 0x0a, 0x0120 },
+	{ 0x04, 0xaf67 },
+	{ 0x08, 0x200f },
+	{ 0x09, 0xd010 },
+	{ 0x0a, 0x0100 },
 	{ 0x0b, 0x0000 },
 	{ 0x0d, 0x2800 },
-	{ 0x0f, 0x0000 },
-	{ 0x19, 0x0a17 },
+	{ 0x0f, 0x0022 },
+	{ 0x19, 0x0217 },
 	{ 0x20, 0x0020 },
 	{ 0x33, 0x0208 },
 	{ 0x46, 0x0300 },
-	{ 0x49, 0x0004 },
-	{ 0x4f, 0x50e9 },
-	{ 0x50, 0x2000 },
-	{ 0x63, 0x2902 },
+	{ 0x49, 0x4004 },
+	{ 0x4f, 0x50c9 },
+	{ 0x50, 0x3000 },
+	{ 0x63, 0x1b02 },
 	{ 0x67, 0x1111 },
 	{ 0x68, 0x1016 },
 	{ 0x69, 0x273f },
-- 
2.6.1
