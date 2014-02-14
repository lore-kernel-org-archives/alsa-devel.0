From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v3 1/3] ASoC: binding: add tdm-slot.txt
Date: Fri, 14 Feb 2014 09:34:34 +0800
Message-ID: <1392341676-4143-2-git-send-email-Li.Xiubo@freescale.com>
References: <1392341676-4143-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392341676-4143-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, b47053@freescale.com, Xiubo Li <Li.Xiubo@freescale.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@linaro.org>
---
 Documentation/devicetree/bindings/sound/tdm-slot.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tdm-slot.txt

diff --git a/Documentation/devicetree/bindings/sound/tdm-slot.txt b/Documentation/devicetree/bindings/sound/tdm-slot.txt
new file mode 100644
index 0000000..6a2c842
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tdm-slot.txt
@@ -0,0 +1,20 @@
+TDM slot:
+
+This specifies audio DAI's TDM slot.
+
+TDM slot properties:
+dai-tdm-slot-num : Number of slots in use.
+dai-tdm-slot-width :  Width in bits for each slot.
+
+For instance:
+	dai-tdm-slot-num = <2>;
+	dai-tdm-slot-width = <8>;
+
+And for each spcified driver, there could be one .of_xlate_tdm_slot_mask()
+to specify a explicit mapping of the channels and the slots. If it's absent
+the default snd_soc_of_xlate_tdm_slot_mask() will be used to generating the
+tx and rx masks.
+
+For snd_soc_of_xlate_tdm_slot_mask(), the tx and rx masks will use a 1 bit
+for an active slot as default, and the default active bits are at the LSB of
+the masks.
-- 
1.8.4
