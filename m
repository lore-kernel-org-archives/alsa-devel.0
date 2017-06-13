From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l34: Constify hw_constraints" to
	the asoc tree
Date: Tue, 13 Jun 2017 22:08:30 +0100
Message-ID: <E1dKt38-0000TO-8n@debutante>
References: <20170608213725.5378-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA367267099
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 23:08:38 +0200 (CEST)
In-Reply-To: <20170608213725.5378-2-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Brian Austin <brian.austin@cirrus.com>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l34: Constify hw_constraints

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

>From e8fa1a4929849b71936f30e88c0b17c3a641509d Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 8 Jun 2017 23:37:19 +0200
Subject: [PATCH] ASoC: cs35l34: Constify hw_constraints

snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
const pointers.  Constify the corresponding static objects for better
hardening.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l34.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index 7c5d1510cf2c..0a747c66cc6c 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -567,12 +567,12 @@ static int cs35l34_pcm_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static unsigned int cs35l34_src_rates[] = {
+static const unsigned int cs35l34_src_rates[] = {
 	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
 };
 
 
-static struct snd_pcm_hw_constraint_list cs35l34_constraints = {
+static const struct snd_pcm_hw_constraint_list cs35l34_constraints = {
 	.count  = ARRAY_SIZE(cs35l34_src_rates),
 	.list   = cs35l34_src_rates,
 };
-- 
2.11.0
