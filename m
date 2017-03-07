From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add space around '='" to the asoc tree
Date: Tue, 07 Mar 2017 13:57:08 +0100
Message-ID: <E1clEfs-0004aY-7X@finisterre>
References: <1488021780-9424-1-git-send-email-adrian.dinu95@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D583D266F93
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 13:58:08 +0100 (CET)
In-Reply-To: <1488021780-9424-1-git-send-email-adrian.dinu95@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adrian Dinu <adrian.dinu95@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add space around '='

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

>From ec5a82d6c0b860bf4cba5c7ef8646ae5dad9f5a6 Mon Sep 17 00:00:00 2001
From: Adrian Dinu <adrian.dinu95@gmail.com>
Date: Sat, 25 Feb 2017 13:23:00 +0200
Subject: [PATCH] ASoC: Add space around '='

This was reported by checkpatch.pl

Signed-off-by: Adrian Dinu <adrian.dinu95@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6dca408faae3..d29fbc7195a0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3139,7 +3139,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->suspend = component->driver->suspend;
 	component->resume = component->driver->resume;
 	component->pcm_new = component->driver->pcm_new;
-	component->pcm_free= component->driver->pcm_free;
+	component->pcm_free = component->driver->pcm_free;
 
 	dapm = &component->dapm;
 	dapm->dev = dev;
-- 
2.11.0
