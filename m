From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Remove redundant extern
	declarations" to the asoc tree
Date: Tue, 29 Nov 2016 11:45:15 +0000
Message-ID: <E1cBgqZ-0004OC-1d@debutante>
References: <1480416382-8655-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 28E7C267098
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 12:45:21 +0100 (CET)
In-Reply-To: <1480416382-8655-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: arizona: Remove redundant extern declarations

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

>From 739507159e4e135a0a21df5a947753f44b0789b8 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 29 Nov 2016 10:46:22 +0000
Subject: [PATCH] ASoC: arizona: Remove redundant extern declarations

Functions are given external linkage by default making the extern's
unnecessary, as such remove them.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.h | 80 ++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 813f1cdb565d..56707860657c 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -256,28 +256,24 @@ extern const struct soc_enum arizona_output_anc_src[];
 
 extern const struct snd_kcontrol_new arizona_voice_trigger_switch[];
 
-extern int arizona_in_ev(struct snd_soc_dapm_widget *w,
-			 struct snd_kcontrol *kcontrol,
-			 int event);
-extern int arizona_out_ev(struct snd_soc_dapm_widget *w,
-			  struct snd_kcontrol *kcontrol,
-			  int event);
-extern int arizona_hp_ev(struct snd_soc_dapm_widget *w,
-			 struct snd_kcontrol *kcontrol,
-			 int event);
-extern int arizona_anc_ev(struct snd_soc_dapm_widget *w,
-			  struct snd_kcontrol *kcontrol,
-			  int event);
-
-extern int arizona_eq_coeff_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol);
-extern int arizona_lhpf_coeff_put(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol);
-
-extern int arizona_clk_ev(struct snd_soc_dapm_widget *w,
-			  struct snd_kcontrol *kcontrol, int event);
-extern int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
-			      int source, unsigned int freq, int dir);
+int arizona_in_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
+		  int event);
+int arizona_out_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
+		   int event);
+int arizona_hp_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
+		  int event);
+int arizona_anc_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
+		   int event);
+
+int arizona_eq_coeff_put(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol);
+int arizona_lhpf_coeff_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol);
+
+int arizona_clk_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
+		   int event);
+int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id, int source,
+		       unsigned int freq, int dir);
 
 extern const struct snd_soc_dai_ops arizona_dai_ops;
 extern const struct snd_soc_dai_ops arizona_simple_dai_ops;
@@ -300,35 +296,35 @@ struct arizona_fll {
 	char clock_ok_name[ARIZONA_FLL_NAME_LEN];
 };
 
-extern int arizona_dvfs_up(struct snd_soc_codec *codec, unsigned int flags);
-extern int arizona_dvfs_down(struct snd_soc_codec *codec, unsigned int flags);
-extern int arizona_dvfs_sysclk_ev(struct snd_soc_dapm_widget *w,
-				  struct snd_kcontrol *kcontrol, int event);
-extern void arizona_init_dvfs(struct arizona_priv *priv);
-
-extern int arizona_init_fll(struct arizona *arizona, int id, int base,
-			    int lock_irq, int ok_irq, struct arizona_fll *fll);
-extern int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
-				  unsigned int Fref, unsigned int Fout);
-extern int arizona_set_fll(struct arizona_fll *fll, int source,
+int arizona_dvfs_up(struct snd_soc_codec *codec, unsigned int flags);
+int arizona_dvfs_down(struct snd_soc_codec *codec, unsigned int flags);
+int arizona_dvfs_sysclk_ev(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event);
+void arizona_init_dvfs(struct arizona_priv *priv);
+
+int arizona_init_fll(struct arizona *arizona, int id, int base,
+		     int lock_irq, int ok_irq, struct arizona_fll *fll);
+int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
 			   unsigned int Fref, unsigned int Fout);
+int arizona_set_fll(struct arizona_fll *fll, int source,
+		    unsigned int Fref, unsigned int Fout);
 
-extern int arizona_init_spk(struct snd_soc_codec *codec);
-extern int arizona_init_gpio(struct snd_soc_codec *codec);
-extern int arizona_init_mono(struct snd_soc_codec *codec);
-extern int arizona_init_notifiers(struct snd_soc_codec *codec);
+int arizona_init_spk(struct snd_soc_codec *codec);
+int arizona_init_gpio(struct snd_soc_codec *codec);
+int arizona_init_mono(struct snd_soc_codec *codec);
+int arizona_init_notifiers(struct snd_soc_codec *codec);
 
-extern int arizona_init_spk_irqs(struct arizona *arizona);
-extern int arizona_free_spk_irqs(struct arizona *arizona);
+int arizona_init_spk_irqs(struct arizona *arizona);
+int arizona_free_spk_irqs(struct arizona *arizona);
 
-extern int arizona_init_dai(struct arizona_priv *priv, int dai);
+int arizona_init_dai(struct arizona_priv *priv, int dai);
 
 int arizona_set_output_mode(struct snd_soc_codec *codec, int output,
 			    bool diff);
 
-extern bool arizona_input_analog(struct snd_soc_codec *codec, int shift);
+bool arizona_input_analog(struct snd_soc_codec *codec, int shift);
 
-extern const char *arizona_sample_rate_val_to_name(unsigned int rate_val);
+const char *arizona_sample_rate_val_to_name(unsigned int rate_val);
 
 static inline int arizona_register_notifier(struct snd_soc_codec *codec,
 					    struct notifier_block *nb,
-- 
2.10.2
