From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Add
	snd_soc_dapm_kcontrol_widget()" to the asoc tree
Date: Fri, 23 Oct 2015 08:09:06 +0900
Message-ID: <E1ZpOyo-0008La-Ff@finisterre>
References: <1445355532-28310-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 69A32266ABF
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:16 +0200 (CEST)
In-Reply-To: <1445355532-28310-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mythri P K <mythri.p.k@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Add snd_soc_dapm_kcontrol_widget()

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

>From 93e39a11520c000c9086215460bf27b35b09c724 Mon Sep 17 00:00:00 2001
From: Mythri P K <mythri.p.k@intel.com>
Date: Tue, 20 Oct 2015 22:30:08 +0530
Subject: [PATCH] ASoC: dapm: Add snd_soc_dapm_kcontrol_widget()

Given a kcontrol, we may want to access the parent widget
and it's associated data. So export function to return it.

Signed-off-by: Mythri P K <mythri.p.k@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dapm.h |  3 +++
 sound/soc/soc-dapm.c     | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 5abba03..7855cfe 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -451,6 +451,9 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 struct snd_soc_dapm_context *snd_soc_dapm_kcontrol_dapm(
 	struct snd_kcontrol *kcontrol);
 
+struct snd_soc_dapm_widget *snd_soc_dapm_kcontrol_widget(
+		struct snd_kcontrol *kcontrol);
+
 int snd_soc_dapm_force_bias_level(struct snd_soc_dapm_context *dapm,
 	enum snd_soc_bias_level level);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a28d6a1..38281c2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -509,6 +509,18 @@ static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
 }
 
 /**
+ * snd_soc_dapm_kcontrol_widget() - Returns the widget associated to a
+ *   kcontrol
+ * @kcontrol: The kcontrol
+ */
+struct snd_soc_dapm_widget *snd_soc_dapm_kcontrol_widget(
+				struct snd_kcontrol *kcontrol)
+{
+	return dapm_kcontrol_get_wlist(kcontrol)->widgets[0];
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_widget);
+
+/**
  * snd_soc_dapm_kcontrol_dapm() - Returns the dapm context associated to a
  *  kcontrol
  * @kcontrol: The kcontrol
-- 
2.6.1
