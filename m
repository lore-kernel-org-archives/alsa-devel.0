From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Use snd_soc_kcontrol_codec()"
	to the asoc tree
Date: Fri, 21 Jul 2017 17:46:06 +0100
Message-ID: <E1dYb42-0005nu-F2@debutante>
References: <1500572177-14939-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60C9526753D
 for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2017 18:46:18 +0200 (CEST)
In-Reply-To: <1500572177-14939-1-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, richard.leitner@skidata.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: Use snd_soc_kcontrol_codec()

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

>From 364e93ca5dd6f4d266c3a5ff169961d2caac19fb Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Thu, 20 Jul 2017 14:36:17 -0300
Subject: [PATCH] ASoC: sgtl5000: Use snd_soc_kcontrol_codec()

Since commit a72952672005 ("ASoC: sgtl5000: add avc support") the
following kernel crash happens after running a 'reboot' command:

ALSA: Storing mixer settings...
[   20.031604] Unable to handle kernel paging request at virtual address fffffffe
[   20.039268] pgd = de2a0000
[   20.041999] [fffffffe] *pgd=8fffd861, *pte=00000000, *ppte=00000000
[   20.048387] Internal error: Oops: 80000007 [#1] SMP ARM

The function that takes a kcontrol parameter and returns the
codec that registered the control is snd_soc_kcontrol_codec(),
so use the correct function to fix the problem.

Fixes: a72952672005 ("ASoC: sgtl5000: add avc support")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Richard Leitner <richard.leitner@skidata.com>
Reviewed-by: Richard Leitner <richard.leitner@skidata.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 8f6814c1eb6b..80f6d1da7095 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -409,7 +409,7 @@ static int dac_put_volsw(struct snd_kcontrol *kcontrol,
 static int avc_get_threshold(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	int db, i;
 	u16 reg = snd_soc_read(codec, SGTL5000_DAP_AVC_THRESHOLD);
 
@@ -442,7 +442,7 @@ static int avc_get_threshold(struct snd_kcontrol *kcontrol,
 static int avc_put_threshold(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	int db;
 	u16 reg;
 
-- 
2.13.2
