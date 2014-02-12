From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v2 6/7] ARM: mvebu: enable S/PDIF audio in Armada 370 DB
 Device Tree
Date: Wed, 12 Feb 2014 18:21:01 +0100
Message-ID: <1392225662-20431-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Lior Amsalem <alior@marvell.com>, alsa-devel@alsa-project.org, Tawfik Bayouk <tawfik@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

In addition to the analog audio input and output, the Armada 370 DB
also has S/PDIF input and output optical connectors. This commit
improves the Device Tree description of the Armada 370 DB platform to
enable the S/PDIF support.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 7df1866..82f238a 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -163,7 +163,15 @@
 	sound {
 	      compatible = "marvell,a370db-audio";
 	      marvell,audio-controller = <&audio_controller>;
-	      marvell,audio-codec = <&audio_codec>;
+	      marvell,audio-codec = <&audio_codec &spdif_out &spdif_in>;
 	      status = "okay";
 	};
+
+	spdif_out: spdif-out {
+	      compatible = "linux,spdif-dit";
+	};
+
+	spdif_in: spdif-in {
+	      compatible = "linux,spdif-dir";
+	};
 };
-- 
1.8.3.2
