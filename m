From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/2] ALSA: sound/pci: add const to snd_ratnum structures
Date: Tue, 20 Jun 2017 00:11:54 +0530
Message-ID: <1497897714-27522-3-git-send-email-bhumirks@gmail.com>
References: <1497897714-27522-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497897714-27522-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, clemens@ladisch.de, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_ratnum structures as const as their reference is only
stored in the rate field of a snd_pcm_hw_constraint_ratnums structure.
This field is of type const, so snd_ratnum structures can be made const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/bt87x.c   | 2 +-
 sound/pci/ens1370.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index 099efb0..cbff975 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -401,7 +401,7 @@ static int snd_bt87x_set_digital_hw(struct snd_bt87x *chip, struct snd_pcm_runti
 
 static int snd_bt87x_set_analog_hw(struct snd_bt87x *chip, struct snd_pcm_runtime *runtime)
 {
-	static struct snd_ratnum analog_clock = {
+	static const struct snd_ratnum analog_clock = {
 		.num = ANALOG_CLOCK,
 		.den_min = CLOCK_DIV_MIN,
 		.den_max = CLOCK_DIV_MAX,
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 09a63ef..f023076 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -474,7 +474,7 @@ static struct snd_pcm_hw_constraint_list snd_es1370_hw_constraints_rates = {
 	.list = snd_es1370_fixed_rates,
 	.mask = 0,
 };
-static struct snd_ratnum es1370_clock = {
+static const struct snd_ratnum es1370_clock = {
 	.num = ES_1370_SRCLOCK,
 	.den_min = 29, 
 	.den_max = 353,
@@ -495,7 +495,7 @@ static struct snd_pcm_hw_constraint_ratdens snd_es1371_hw_constraints_dac_clock
 	.nrats = 1,
 	.rats = &es1371_dac_clock,
 };
-static struct snd_ratnum es1371_adc_clock = {
+static const struct snd_ratnum es1371_adc_clock = {
 	.num = 48000 << 15,
 	.den_min = 32768, 
 	.den_max = 393216,
-- 
2.7.4
