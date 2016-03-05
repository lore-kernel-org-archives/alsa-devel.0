From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: remove unused variable" to
	the asoc tree
Date: Sat, 05 Mar 2016 21:25:09 +0900
Message-ID: <E1acBGf-0003LQ-1l@finisterre>
References: <1457012269-30481-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E9F4266A08
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:25:15 +0100 (CET)
In-Reply-To: <1457012269-30481-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3168a: remove unused variable

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

>From e7a508f2b137092500fbad09d9713d3a1c5d4826 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Date: Fri, 4 Mar 2016 16:27:14 +0530
Subject: [PATCH] ASoC: pcm3168a: remove unused variable

While building we were getting build warning about:
sound/soc/codecs/pcm3168a.c:403:21: warning: variable 'channels' set but
not used

The variable channels were being assigned some value but that was never
reused.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 0c7248ab6a37..992a77edcd5d 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -400,13 +400,12 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	struct pcm3168a_priv *pcm3168a = snd_soc_codec_get_drvdata(codec);
 	bool tx, master_mode;
 	u32 val, mask, shift, reg;
-	unsigned int rate, channels, fmt, ratio, max_ratio;
+	unsigned int rate, fmt, ratio, max_ratio;
 	int i, min_frame_size;
 	snd_pcm_format_t format;
 
 	rate = params_rate(params);
 	format = params_format(params);
-	channels = params_channels(params);
 
 	ratio = pcm3168a->sysclk / rate;
 
-- 
2.7.0
