From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-pcm: Use delay set in component
	pointer function" to the asoc tree
Date: Wed,  1 Aug 2018 14:31:36 +0100 (BST)
Message-ID: <20180801133136.25CCB1124241@debutante.sirena.org.uk>
References: <1533118054-14509-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B94C2676E2
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 15:31:40 +0200 (CEST)
In-Reply-To: <1533118054-14509-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-pcm: Use delay set in component pointer function

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 9fb4c2bf130b922c77c16a8368732699799c40de Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Wed, 1 Aug 2018 15:37:33 +0530
Subject: [PATCH] ASoC: soc-pcm: Use delay set in component pointer function

Take into account the base delay set in pointer callback.

There are cases where a pointer function populates
runtime->delay, such as:
./sound/pci/hda/hda_controller.c
./sound/soc/intel/atom/sst-mfld-platform-pcm.c

This delay was getting lost and was overwritten by delays
from codec or cpu dai delay function if exposed.

Now,
Total delay = base delay + cpu_dai delay + codec_dai delay

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 4019bc10897c..9833e53754cb 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1179,6 +1179,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_sframes_t codec_delay = 0;
 	int i;
 
+	/* clearing the previous total delay */
+	runtime->delay = 0;
+
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
@@ -1190,6 +1193,8 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 		offset = component->driver->ops->pointer(substream);
 		break;
 	}
+	/* base delay if assigned in pointer callback */
+	delay = runtime->delay;
 
 	if (cpu_dai->driver->ops->delay)
 		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
-- 
2.18.0
