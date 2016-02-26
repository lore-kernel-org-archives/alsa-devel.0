From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: add regmap_field_force_xxx() macros"
	to the asoc tree
Date: Fri, 26 Feb 2016 12:17:29 +0900
Message-ID: <E1aZ8uH-00089f-3Z@finisterre>
References: <87vb5qh7ko.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B1BE2265148
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 04:17:30 +0100 (CET)
In-Reply-To: <87vb5qh7ko.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   regmap: add regmap_field_force_xxx() macros

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

>From 489061bba6c655a2f98d39be17df118c0fd09d57 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Feb 2016 05:25:54 +0000
Subject: [PATCH] regmap: add regmap_field_force_xxx() macros

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regmap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 7d3d498fd3e8..d36ea89adc50 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -76,8 +76,12 @@ struct reg_sequence {
 
 #define	regmap_field_write(field, val) \
 	regmap_field_update_bits_base(field, ~0, val, NULL, false, false)
+#define	regmap_field_force_write(field, val) \
+	regmap_field_update_bits_base(field, ~0, val, NULL, false, true)
 #define	regmap_field_update_bits(field, mask, val)\
 	regmap_field_update_bits_base(field, mask, val, NULL, false, false)
+#define	regmap_field_force_update_bits(field, mask, val) \
+	regmap_field_update_bits_base(field, mask, val, NULL, false, true)
 
 #define	regmap_fields_write(field, id, val) \
 	regmap_fields_update_bits_base(field, id, ~0, val, NULL, false, false)
-- 
2.7.0
