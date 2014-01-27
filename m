From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH 0/4] add a TDA998x CODEC
Date: Mon, 27 Jan 2014 10:04:40 +0100
Message-ID: <cover.1390813480.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: alsa-devel@alsa-project.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The TDA998x HDMI transmitter accepts audio input from either I2S or S/PDIF.

Theses inputs have different intrinsic constraints and these constraints
may be modified by the audio parameters of the connected video device.

The choice of I2S or S/PDIF may be the done by the user or by automatic
processing (DPCM?) at each audio starting time. This asks for a dynamic
audio input switch in the HDMI driver.

This patch series implements the TDA998x specific CODEC.
A simple function call mechanism is used for exchanges between the
CODEC and the HDMI driver.

Jean-Francois Moine (4):
  drm/i2c: tda998x: add a function for dynamic audio input switch
  ASoC: tda998x: add a codec driver for TDA998x
  ASoC: tda998x: add DT documentation
  ASoC: tda998x: adjust the audio hw parameters from EDID

 .../devicetree/bindings/sound/tda998x.txt          |  14 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  |  58 +++-
 include/drm/i2c/tda998x.h                          |   8 +-
 sound/soc/codecs/Kconfig                           |   7 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tda998x.c                         | 304 +++++++++++++++++++++
 6 files changed, 390 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tda998x.txt
 create mode 100644 sound/soc/codecs/tda998x.c

-- 
1.8.5.3
