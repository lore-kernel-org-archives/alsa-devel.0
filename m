From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 3/3] MAINTAINERS: Add an entry for the Xilinx logicPD-I2S block
Date: Fri, 30 Aug 2019 23:06:07 +0200
Message-ID: <20190830210607.22644-3-miquel.raynal@bootlin.com>
References: <20190830210607.22644-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190830210607.22644-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, alexandre@bootlin.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Reference the driver and and the bindings.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bf8f340e6a8..382c33a1adef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17136,6 +17136,12 @@ L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	drivers/tty/serial/uartlite.c
 
+XILINX LOGICPD I2S SOUND DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+S:	Maintained
+F:	sound/soc/xilinx/xlnx-logicpd-i2s.c
+F:	Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml
+
 XILINX VIDEO IP CORES
 M:	Hyun Kwon <hyun.kwon@xilinx.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
-- 
2.20.1
