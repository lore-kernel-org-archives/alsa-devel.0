From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Add rt5651_jack_inserted()
	helper" to the asoc tree
Date: Wed, 07 Mar 2018 14:13:46 +0000
Message-ID: <E1etZpC-0001NU-Hf@debutante>
References: <20180225104713.4745-21-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 71E11267380
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:13:51 +0100 (CET)
In-Reply-To: <20180225104713.4745-21-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Add rt5651_jack_inserted() helper

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

>From 0fe9474598890b4bd8a7228c9b1872ed7fe3c2c5 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:35:56 +0100
Subject: [PATCH] ASoC: rt5651: Add rt5651_jack_inserted() helper

Add rt5651_jack_inserted() helper to get the jack-detect switch status,
This is a preparation patch for rewriting the jack type-detection to
make it more reliable.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 873af6798d7a..41fc574dbc3d 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1597,6 +1597,31 @@ static bool rt5651_micbias1_ovcd(struct snd_soc_component *component)
 	return (val & RT5651_MB1_OC_CLR);
 }
 
+static bool rt5651_jack_inserted(struct snd_soc_component *component)
+{
+	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
+	int val;
+
+	val = snd_soc_component_read32(component, RT5651_INT_IRQ_ST);
+	dev_dbg(component->dev, "irq status %#04x\n", val);
+
+	switch (rt5651->jd_src) {
+	case RT5651_JD1_1:
+		val &= 0x1000;
+		break;
+	case RT5651_JD1_2:
+		val &= 0x2000;
+		break;
+	case RT5651_JD2:
+		val &= 0x4000;
+		break;
+	default:
+		break;
+	}
+
+	return val == 0;
+}
+
 static irqreturn_t rt5651_irq(int irq, void *data)
 {
 	struct rt5651_priv *rt5651 = data;
@@ -1927,27 +1952,13 @@ static void rt5651_jack_detect_work(struct work_struct *work)
 {
 	struct rt5651_priv *rt5651 =
 		container_of(work, struct rt5651_priv, jack_detect_work.work);
-
-	int report, val = 0;
+	int report, jack_inserted;
 
 	if (!rt5651->component)
 		return;
 
-	switch (rt5651->jd_src) {
-	case RT5651_JD1_1:
-		val = snd_soc_component_read32(rt5651->component, RT5651_INT_IRQ_ST) & 0x1000;
-		break;
-	case RT5651_JD1_2:
-		val = snd_soc_component_read32(rt5651->component, RT5651_INT_IRQ_ST) & 0x2000;
-		break;
-	case RT5651_JD2:
-		val = snd_soc_component_read32(rt5651->component, RT5651_INT_IRQ_ST) & 0x4000;
-		break;
-	default:
-		break;
-	}
-
-	report = rt5651_jack_detect(rt5651->component, !val);
+	jack_inserted = rt5651_jack_inserted(rt5651->component);
+	report = rt5651_jack_detect(rt5651->component, jack_inserted);
 
 	snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
 }
-- 
2.16.2
