From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add SOC_DOUBLE_STS macro" to the asoc
	tree
Date: Sat, 12 Dec 2015 23:07:37 +0000
Message-ID: <E1a7tGL-0002gg-7j@finisterre>
References: <1449590340-14682-2-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACB0426581E
 for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2015 00:07:44 +0100 (CET)
In-Reply-To: <1449590340-14682-2-git-send-email-Damien.Horsley@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Damien.Horsley" <Damien.Horsley@imgtec.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add SOC_DOUBLE_STS macro

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

>From d13871b3531b05fdf5b8ca92c98779e574fe06f1 Mon Sep 17 00:00:00 2001
From: "Damien.Horsley" <Damien.Horsley@imgtec.com>
Date: Tue, 8 Dec 2015 15:58:58 +0000
Subject: [PATCH] ASoC: Add SOC_DOUBLE_STS macro

Add SOC_DOUBLE_STS macro for read-only volatile status controls

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a8b4b9c..2b399b0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -110,6 +110,14 @@
 	.put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_VALUE(reg, shift_left, shift_right, \
 					  max, invert, 0) }
+#define SOC_DOUBLE_STS(xname, reg, shift_left, shift_right, max, invert) \
+{									\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),		\
+	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,		\
+	.access = SNDRV_CTL_ELEM_ACCESS_READ |				\
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,				\
+	.private_value = SOC_DOUBLE_VALUE(reg, shift_left, shift_right,	\
+					  max, invert, 0) }
 #define SOC_DOUBLE_R(xname, reg_left, reg_right, xshift, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw, \
-- 
2.6.4
