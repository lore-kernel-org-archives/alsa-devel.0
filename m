From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Make return type of dpcm_state_string()
	const char *" to the asoc tree
Date: Tue, 22 Nov 2016 17:26:37 +0000
Message-ID: <E1c9Eq5-0005pm-DT@debutante>
References: <1479810554-24289-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E0452659AA
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 18:26:47 +0100 (CET)
In-Reply-To: <1479810554-24289-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Make return type of dpcm_state_string() const char *

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

>From 852801417a89375c0df4285e60d90c7821a1d730 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 22 Nov 2016 11:29:14 +0100
Subject: [PATCH] ASoC: Make return type of dpcm_state_string() const char *

dpcm_state_string() returns a pointer to a string literal. Modifying a
string literal causes undefined behaviour. So make the return type of the
function const char * to make it explicit that the returned value should
not be modified.

This patch is purely cosmetic, none of the users of dpcm_state_string()
attempt to modify the returned content.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d56a16a0f6fa..e7a1eaa2772f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2882,7 +2882,7 @@ int snd_soc_platform_trigger(struct snd_pcm_substream *substream,
 EXPORT_SYMBOL_GPL(snd_soc_platform_trigger);
 
 #ifdef CONFIG_DEBUG_FS
-static char *dpcm_state_string(enum snd_soc_dpcm_state state)
+static const char *dpcm_state_string(enum snd_soc_dpcm_state state)
 {
 	switch (state) {
 	case SND_SOC_DPCM_STATE_NEW:
-- 
2.10.2
