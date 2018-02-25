From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 20/32] ASoC: rt5651: Add
	rt5651_jack_inserted() helper
Date: Sun, 25 Feb 2018 11:47:01 +0100
Message-ID: <20180225104713.4745-21-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 71ACD267480
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:46 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Add rt5651_jack_inserted() helper to get the jack-detect switch status,
This is a preparation patch for rewriting the jack type-detection to
make it more reliable.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 2d0c5ec451cd..b88585d652ea 100644
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
@@ -1921,27 +1946,13 @@ static void rt5651_jack_detect_work(struct work_struct *work)
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
2.14.3
