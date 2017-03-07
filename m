From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: The open brace is placed with the
	previous line" to the asoc tree
Date: Tue, 07 Mar 2017 14:33:43 +0100
Message-ID: <E1clFFH-0005e9-Bh@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85FA5266F3E
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 14:33:52 +0100 (CET)
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
To: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: The open brace is placed with the previous line

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

>From 05af0917aaf8a0755de8fbbf72153ad6ca1f5443 Mon Sep 17 00:00:00 2001
From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Date: Sat, 25 Feb 2017 23:54:16 +0200
Subject: [PATCH] ASoC: pxa: The open brace is placed with the previous line

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/raumfeld.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 552b763005ed..47c91730e93c 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -228,14 +228,12 @@ static struct snd_soc_ops raumfeld_ak4104_ops = {
 	.codec_name	= "spi0.0",			\
 }
 
-static struct snd_soc_dai_link snd_soc_raumfeld_connector_dai[] =
-{
+static struct snd_soc_dai_link snd_soc_raumfeld_connector_dai[] = {
 	DAI_LINK_CS4270,
 	DAI_LINK_AK4104,
 };
 
-static struct snd_soc_dai_link snd_soc_raumfeld_speaker_dai[] =
-{
+static struct snd_soc_dai_link snd_soc_raumfeld_speaker_dai[] = {
 	DAI_LINK_CS4270,
 };
 
-- 
2.11.0
