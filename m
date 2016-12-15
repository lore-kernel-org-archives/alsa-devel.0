From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98090: remove superflous check for
	'micbias'" to the asoc tree
Date: Thu, 15 Dec 2016 12:21:40 +0000
Message-ID: <E1cHV2a-0000tL-S6@debutante>
References: <1481218297-17568-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6831233017848342199=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 435EE266A53
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 13:21:47 +0100 (CET)
In-Reply-To: <1481218297-17568-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

--===============6831233017848342199==
Content-Type: text/plain

The patch

   ASoC: max98090: remove superflous check for 'micbias'

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

>From 1c445a42c48754bb5f821478517ef1b9f861217a Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 8 Dec 2016 23:01:29 +0530
Subject: [PATCH] ASoC: max98090: remove superflous check for 'micbias'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In max98090_probe(), code checks for micbias being out of range. The
'micbias' variable in unsigned and checked against M98090_MBVSEL_2V2 which
is zero, so remove this check.

sound/soc/codecs/max98090.c: In function ‘max98090_probe’:
sound/soc/codecs/max98090.c:2459:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  } else if (micbias < M98090_MBVSEL_2V2 || micbias > M98090_MBVSEL_2V8) {

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 584aab83e478..66828480d484 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2456,7 +2456,7 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	if (err) {
 		micbias = M98090_MBVSEL_2V8;
 		dev_info(codec->dev, "use default 2.8v micbias\n");
-	} else if (micbias < M98090_MBVSEL_2V2 || micbias > M98090_MBVSEL_2V8) {
+	} else if (micbias > M98090_MBVSEL_2V8) {
 		dev_err(codec->dev, "micbias out of range 0x%x\n", micbias);
 		micbias = M98090_MBVSEL_2V8;
 	}
-- 
2.11.0


--===============6831233017848342199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6831233017848342199==--
