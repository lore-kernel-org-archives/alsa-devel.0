From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Check return value from
	wm_adsp_buffer_init" to the asoc tree
Date: Tue, 22 Nov 2016 19:13:42 +0000
Message-ID: <E1c9GVi-0000IX-Mj@debutante>
References: <1479829114-11579-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97534266E6C
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 20:13:50 +0100 (CET)
In-Reply-To: <1479829114-11579-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Check return value from wm_adsp_buffer_init

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

>From 48c2c99359044763b0cf21e59405638f9630fe06 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 22 Nov 2016 15:38:34 +0000
Subject: [PATCH] ASoC: wm_adsp: Check return value from wm_adsp_buffer_init

We are not checking the return value from a call to wm_adsp_buffer_init
it looks like this used to be returned at the bottom of the function but
probably got missed when more error paths were added. This patch adds
the appropriate error check.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 6e6b9d838332..ff111a82fa3f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2575,8 +2575,13 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 
 		mutex_lock(&dsp->pwr_lock);
 
-		if (wm_adsp_fw[dsp->fw].num_caps != 0)
+		if (wm_adsp_fw[dsp->fw].num_caps != 0) {
 			ret = wm_adsp_buffer_init(dsp);
+			if (ret < 0) {
+				mutex_unlock(&dsp->pwr_lock);
+				goto err;
+			}
+		}
 
 		mutex_unlock(&dsp->pwr_lock);
 
-- 
2.10.2
