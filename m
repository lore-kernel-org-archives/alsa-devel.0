From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: fix regression on compress
	DAI" to the asoc tree
Date: Tue, 02 Feb 2016 19:41:57 +0000
Message-ID: <E1aQgpp-0007rY-5u@debutante>
References: <1454354716-17313-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0573485945344094271=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B02D126525F
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 20:42:06 +0100 (CET)
In-Reply-To: <1454354716-17313-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0573485945344094271==
Content-Type: text/plain

The patch

   ASoC: Intel: Atom: fix regression on compress DAI

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

>From 292d4200a90715ac29f3763df27adb38a243868c Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 2 Feb 2016 12:49:49 -0600
Subject: [PATCH] ASoC: Intel: Atom: fix regression on compress DAI
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit a106804 ("ASoC: compress: Fix compress device direction check")
added a dependency on the compress-cpu-dai channel_min field
which was removed earlier by commit 77095796
("ASoC: Intel: Atom: clean-up compressed DAI definition")
as part of the baytrail cleanups.

The net result was a regression at probe on all Atom platforms
with no sound card created.

Fix by adding explicit initialization for channel_min to 1
for the compress-cpu-dai.

Reported-by: Tobias Mädel <alsa-devel@tbspace.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 55c33dc76ce4..52ed434cbca6 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -528,6 +528,7 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 	.ops = &sst_compr_dai_ops,
 	.playback = {
 		.stream_name = "Compress Playback",
+		.channels_min = 1,
 	},
 },
 /* BE CPU  Dais */
-- 
2.7.0.rc3


--===============0573485945344094271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0573485945344094271==--
