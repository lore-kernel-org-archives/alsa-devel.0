From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 0/4] Armada 38x and 370 audio
Date: Wed, 25 Feb 2015 22:57:58 +0100
Message-ID: <1424901482-3809-1-git-send-email-mw@semihalf.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <y>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@free-electrons.com, sebastian.hesselbarth@gmail.com
Cc: thomas.petazzoni@free-electrons.com, alior@marvell.com, alsa-devel@alsa-project.org, tawfik@marvell.com, jaz@semihalf.com, ezequiel.garcia@free-electrons.com, mw@semihalf.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

I send a series of patches adding I2S - S/PDIF support for Marvell Armada 38x
SoC. It is same controller as in Armada 370, however two quirks had to be taken
into consideration:

* new PLL frequency setting

* exceptive pinout of I2S and S/PDIF formats

Kirkwood-i2s driver was enhanced with obtaining mem resources by name. Sound
interface was enabled for Armada 385 DB board, using simple-card DT binding for
both I2S and S/PDIF. In addition to that minor fix was applied for Armada 370
audio DT description (stable-CC'ed).

Any comments and remarks are welcome.

Best regards,
Marcin

Marcin Wojtas (4):
  ASoC: kirkwood: enable Kirkwood driver for Armada 38x platforms
  ARM: mvebu: add audio I2S controller to Armada 38x Device Tree
  ARM: mvebu: add audio support to Armada 385 DB
  ARM: mvebu: fix routing for analog audio input of Armada 370 DB
    platform

 .../devicetree/bindings/sound/mvebu-audio.txt      |  14 ++-
 arch/arm/boot/dts/armada-370-db.dts                |   2 +-
 arch/arm/boot/dts/armada-388-db.dts                |  69 +++++++++++
 arch/arm/boot/dts/armada-38x.dtsi                  |  17 +++
 sound/soc/kirkwood/kirkwood-i2s.c                  | 132 ++++++++++++++++++++-
 sound/soc/kirkwood/kirkwood.h                      |   2 +
 6 files changed, 232 insertions(+), 4 deletions(-)

-- 
1.8.3.1
