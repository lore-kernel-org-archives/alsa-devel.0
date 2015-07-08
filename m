From: Mark Brown <broonie@kernel.org>
Subject: Applied "mfd: wm5110: Add register patch for rev E and
	above" to the asoc tree
Date: Wed, 08 Jul 2015 20:23:37 +0100
Message-ID: <E1ZCuwT-0005tL-L3@debutante>
References: <1436279294-13672-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 967E3265A01
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 21:23:46 +0200 (CEST)
In-Reply-To: <1436279294-13672-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   mfd: wm5110: Add register patch for rev E and above

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

>From 81207880cef207cd89db863f9aa1d65f22b4f2a2 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 7 Jul 2015 15:28:13 +0100
Subject: [PATCH] mfd: wm5110: Add register patch for rev E and above

Add a register patch for rev E and above that configures the location of
some write sequences to assist with the headphone enables.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/wm5110-tables.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index 62a4aa13cb98..e08924261fef 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -249,6 +249,16 @@ static const struct reg_default wm5110_revd_patch[] = {
 	{ 0x80, 0x0 },
 };
 
+/* Add extra headphone write sequence locations */
+static const struct reg_default wm5110_reve_patch[] = {
+	{ 0x80, 0x3 },
+	{ 0x80, 0x3 },
+	{ 0x4b, 0x138 },
+	{ 0x4c, 0x13d },
+	{ 0x80, 0x0 },
+	{ 0x80, 0x0 },
+};
+
 /* We use a function so we can use ARRAY_SIZE() */
 int wm5110_patch(struct arizona *arizona)
 {
@@ -266,7 +276,9 @@ int wm5110_patch(struct arizona *arizona)
 					     wm5110_revd_patch,
 					     ARRAY_SIZE(wm5110_revd_patch));
 	default:
-		return 0;
+		return regmap_register_patch(arizona->regmap,
+					     wm5110_reve_patch,
+					     ARRAY_SIZE(wm5110_reve_patch));
 	}
 }
 EXPORT_SYMBOL_GPL(wm5110_patch);
-- 
2.1.4
