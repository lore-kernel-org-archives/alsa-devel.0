From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm: allow delayed suspending request
	by users" to the asoc tree
Date: Tue, 05 Jan 2016 17:49:09 +0000
Message-ID: <E1aGVjJ-00033d-7c@debutante>
References: <1451994289-29256-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3699556990446124520=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79C532615F7
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 18:49:24 +0100 (CET)
In-Reply-To: <1451994289-29256-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sanyog Kale <sanyog.r.kale@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============3699556990446124520==
Content-Type: text/plain

The patch

   ASoC: pcm: allow delayed suspending request by users

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

>From 3f80978397f447973d278198e8bbde82826cb9c1 Mon Sep 17 00:00:00 2001
From: Sanyog Kale <sanyog.r.kale@intel.com>
Date: Tue, 5 Jan 2016 17:14:49 +0530
Subject: [PATCH] ASoC: pcm: allow delayed suspending request by users
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If a device would like to use delayed suspending then PM
recommendation is to set ‘power.use_autosuspend’ flag. To allow
users to do so we need to change runtime calls in core to use
autosuspend counterparts.

For user who do not wish to use delayed suspend not setting the
device's ‘power.use_autosuspend’ flag will result in non-delayed
suspend even with these APIs which incidentally is also the default
behaviour, so only users will be impacted who opt in for this.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index c86dc96e8986..efad248efd4f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -599,10 +599,15 @@ platform_err:
 out:
 	mutex_unlock(&rtd->pcm_mutex);
 
-	pm_runtime_put(platform->dev);
-	for (i = 0; i < rtd->num_codecs; i++)
-		pm_runtime_put(rtd->codec_dais[i]->dev);
-	pm_runtime_put(cpu_dai->dev);
+	pm_runtime_mark_last_busy(platform->dev);
+	pm_runtime_put_autosuspend(platform->dev);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		pm_runtime_mark_last_busy(rtd->codec_dais[i]->dev);
+		pm_runtime_put_autosuspend(rtd->codec_dais[i]->dev);
+	}
+
+	pm_runtime_mark_last_busy(cpu_dai->dev);
+	pm_runtime_put_autosuspend(cpu_dai->dev);
 	for (i = 0; i < rtd->num_codecs; i++) {
 		if (!rtd->codec_dais[i]->active)
 			pinctrl_pm_select_sleep_state(rtd->codec_dais[i]->dev);
@@ -706,10 +711,17 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 
 	mutex_unlock(&rtd->pcm_mutex);
 
-	pm_runtime_put(platform->dev);
-	for (i = 0; i < rtd->num_codecs; i++)
-		pm_runtime_put(rtd->codec_dais[i]->dev);
-	pm_runtime_put(cpu_dai->dev);
+	pm_runtime_mark_last_busy(platform->dev);
+	pm_runtime_put_autosuspend(platform->dev);
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		pm_runtime_mark_last_busy(rtd->codec_dais[i]->dev);
+		pm_runtime_put_autosuspend(rtd->codec_dais[i]->dev);
+	}
+
+	pm_runtime_mark_last_busy(cpu_dai->dev);
+	pm_runtime_put_autosuspend(cpu_dai->dev);
+
 	for (i = 0; i < rtd->num_codecs; i++) {
 		if (!rtd->codec_dais[i]->active)
 			pinctrl_pm_select_sleep_state(rtd->codec_dais[i]->dev);
-- 
2.7.0.rc3


--===============3699556990446124520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3699556990446124520==--
