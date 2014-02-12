From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 1/3] ASoC: binding: add tdm-slot.txt
Date: Wed, 12 Feb 2014 15:45:10 +0800
Message-ID: <1392191112-27028-2-git-send-email-Li.Xiubo@freescale.com>
References: <1392191112-27028-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392191112-27028-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, perex@perex.cz, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

TDM slot:

This specifies audio DAI's TDM slot.

Each entry is has four non-negative integer values in DT:
       <tx_mask, rx_mask, slots, slot_width>

For instance:
       simple-slot-info = <0xffffffc 0xffffffc 2 0>;

And this will be parsed into the following format:
       struct soc_slot_info {
              unsigned int tx_mask;
              unsigned int rx_mask;
              int slots;
              int slot_width;
       };

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 Documentation/devicetree/bindings/sound/tdm-slot.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tdm-slot.txt

diff --git a/Documentation/devicetree/bindings/sound/tdm-slot.txt b/Documentation/devicetree/bindings/sound/tdm-slot.txt
new file mode 100644
index 0000000..33dfb15
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tdm-slot.txt
@@ -0,0 +1,17 @@
+TDM slot:
+
+This specifies audio DAI's TDM slot.
+
+Each entry is has four non-negative integer values in DT:
+	<tx_mask, rx_mask, slots, slot_width>
+
+For instance:
+	simple-slot-info = <0xffffffc 0xffffffc 2 0>;
+
+And this will be parsed into the following format:
+	struct soc_slot_info {
+	       unsigned int tx_mask;
+	       unsigned int rx_mask;
+	       int slots;
+	       int slot_width;
+	};
-- 
1.8.4
