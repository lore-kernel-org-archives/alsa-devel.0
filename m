From: Xing Zheng <zhengxing@rock-chips.com>
Subject: [PATCH v2] ASoC: rk3399_gru_sound: fix recording pop at first attempt
Date: Thu, 22 Sep 2016 21:50:06 +0800
Message-ID: <1474552206-31742-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-rockchip@lists.infradead.org, woojoo.lee@samsung.com
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de, Xing Zheng <zhengxing@rock-chips.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, dianders@google.com, Mark Brown <broonie@kernel.org>, smbarber@google.com, hychao@google.com, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

From: Wonjoon Lee <woojoo.lee@samsung.com>

Pop happens when mclk applied but dmic's own boot-time
Specify dmic delay times in dt to make sure
clocks are ready earlier than dmic working

Signed-off-by: Wonjoon Lee <woojoo.lee@samsung.com>
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v2:
- rename dmic-delay to dmic-wakeup-delay-ms

 .../bindings/sound/rockchip,rk3399-gru-sound.txt           |  7 +++++++
 sound/soc/rockchip/rk3399_gru_sound.c                      | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
index f19b6c8..eac91db 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
@@ -6,10 +6,17 @@ Required properties:
   connected to the codecs
 - rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
 
+Optional properties:
+- dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
+  If this option is specified, which means it's required dmic need
+  delay for DMIC to ready so that rt5514 can avoid recording before
+  DMIC send valid data
+
 Example:
 
 sound {
 	compatible = "rockchip,rk3399-gru-sound";
 	rockchip,cpu = <&i2s0>;
 	rockchip,codec = <&max98357a &rt5514 &da7219>;
+	dmic-wakeup-delay-ms = <20>;
 };
diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index ee06489..9ed735a 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -38,6 +38,8 @@
 
 #define SOUND_FS	256
 
+unsigned int rt5514_dmic_delay;
+
 static struct snd_soc_jack rockchip_sound_jack;
 
 static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
@@ -123,6 +125,9 @@ static int rockchip_sound_rt5514_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	/* Wait for DMIC stable */
+	msleep(rt5514_dmic_delay);
+
 	return 0;
 }
 
@@ -343,6 +348,15 @@ static int rockchip_sound_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* Set DMIC delay */
+	ret = device_property_read_u32(&pdev->dev, "dmic-delay",
+					&rt5514_dmic_delay);
+	if (ret) {
+		rt5514_dmic_delay = 0;
+		dev_dbg(&pdev->dev,
+			"no optional property 'dmic-delay' found, default: no delay\n");
+	}
+
 	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
 	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_dai_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
 	rockchip_dailinks[DAILINK_RT5514_DSP].platform_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-- 
1.9.1
