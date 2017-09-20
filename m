From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-pcm: check symmetry after
	hw_params" to the asoc tree
Date: Wed, 20 Sep 2017 04:41:47 -0700 (PDT)
Message-ID: <20170920114147.D7A0D4400D3@finisterre.ee.mobilebroadband>
References: <20170920062530.12252-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F89E266B21
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 13:41:49 +0200 (CEST)
In-Reply-To: <20170920062530.12252-1-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, jiada_wang@mentor.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-pcm: check symmetry after hw_params

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

>From 957ce0c6b8a1f26559864507ae0bfcba29d924ad Mon Sep 17 00:00:00 2001
From: jiada wang <jiada_wang@mentor.com>
Date: Wed, 20 Sep 2017 15:25:30 +0900
Subject: [PATCH] ASoC: soc-pcm: check symmetry after hw_params

hw_params may be fixup by be_hw_params_fixup, calling
soc_pcm_params_symmetry() before hw_params will have issue
if there is hw_params changes in be_hw_params_fixup.

For example, with following use case
1. a dai-link which is able to convert sample rate on BE side
2. set BE playback and capture sample rate to 44100Hz
3. play a 48000Hz audio stream with this dai-link
4. record from this dai-link with 44100Hz sample rate

Got following error message when record starts
[  495.013527]  be_link_ak4613: ASoC: unmatched rate symmetry: 48000 - 44100
[  495.021729]  be_link_ak4613: ASoC: hw_params BE failed -22
[  495.028589]  rsnd_link0: ASoC: hw_params BE failed -22

Because in soc_pcm_hw_params(), FE rate is still having value before
it is fixup by be_hw_params_fixup(), when soc_pcm_params_symmetry() checks
symmetry, thus soc_pcm_params_symmetry() complains about the unmatched rate
between the active stream and the new stream tries to start.

This patch moves soc_pcm_params_symmetry() after hw_params to resolve the
above issue.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 94b88b897c3b..f11421f08065 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -855,11 +855,6 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
-
-	ret = soc_pcm_params_symmetry(substream, params);
-	if (ret)
-		goto out;
-
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_params) {
 		ret = rtd->dai_link->ops->hw_params(substream, params);
 		if (ret < 0) {
@@ -930,6 +925,10 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	cpu_dai->sample_bits =
 		snd_pcm_format_physical_width(params_format(params));
 
+
+	ret = soc_pcm_params_symmetry(substream, params);
+        if (ret)
+                goto platform_err;
 out:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
-- 
2.13.2
