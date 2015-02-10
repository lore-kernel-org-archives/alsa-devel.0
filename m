From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v4] ASoC: rt286: add jack detection disable
	with NULL jack passed
Date: Tue, 10 Feb 2015 17:01:56 +0800
Message-ID: <1423558916-19084-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 480802606BA
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 09:59:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Some platforms, e.g. WSB, don't need jack detection when
system is in Suspend, for power save reason.

Here add headphone/mic jack detection disable feature with NULL
jack passed in, when disabled, it will disable interrupt, and
disable LDO1, which is used for jack detection when headphone
is plugged in.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Reviewed-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index d5cc1bc..c778028 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -394,9 +394,20 @@ int rt286_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 
 	rt286->jack = jack;
 
-	/* Send an initial empty report */
-	snd_soc_jack_report(rt286->jack, 0,
-		SND_JACK_MICROPHONE | SND_JACK_HEADPHONE);
+	if (jack) {
+		/* enable IRQ */
+		if (rt286->jack->status | SND_JACK_HEADPHONE)
+			snd_soc_dapm_force_enable_pin(&codec->dapm, "LDO1");
+		regmap_update_bits(rt286->regmap, RT286_IRQ_CTRL, 0x2, 0x2);
+		/* Send an initial empty report */
+		snd_soc_jack_report(rt286->jack, rt286->jack->status,
+			SND_JACK_MICROPHONE | SND_JACK_HEADPHONE);
+	} else {
+		/* disable IRQ */
+		regmap_update_bits(rt286->regmap, RT286_IRQ_CTRL, 0x2, 0x0);
+		snd_soc_dapm_disable_pin(&codec->dapm, "LDO1");
+	}
+	snd_soc_dapm_sync(&codec->dapm);
 
 	return 0;
 }
-- 
1.9.1
