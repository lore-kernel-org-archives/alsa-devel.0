From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v3 0/5] add a TDA998x CODEC
Date: Sat, 1 Feb 2014 18:10:27 +0100
Message-ID: <cover.1391274627.git.moinejf@free.fr>
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

The TDA998x HDMI transmitter accepts audio input from either I2S or
S/PDIF.
Theses inputs have different intrinsic constraints and these constraints
may be modified by the audio parameters of the connected video device.

The choice of I2S or S/PDIF may be the done by the user or by automatic
processing (DPCM?) at each audio starting time. This asks for a dynamic
audio input switch in the HDMI driver.

This patch series implements the TDA998x specific CODEC.

A simple function call mechanism is used for exchanges between the
CODEC and the HDMI driver.

Note: the changes in the TDA998x I2C driver are based on my previous
patch series:
http://lists.freedesktop.org/archives/dri-devel/2014-January/052837.html

- v3
	- move the DT description of the CODEC as a subnode of the
	  TDA998x I2C (Mark Brown remark - is this the right way?)
		- change CODEC loading mechanism
		- simplify tda998x i2c reference search
		- CODEC DT documentation in drm/i2c/tda998x.txt

- v2
	- add ACLK setting and code optimization in patch 1
	- from Mark Brown's remarks in patch 2:
		- don't compile the codec when CONFIG_ALL_CODECS
		- simplify the code about start/stop audio
		- fix coding style errors
		- add audio-port-names associated to audio-ports
	- add audio-port-names in patch 4
	- add patch 5 'adjust the audio CTS_N pre-divider from audio format'
		for the Beaglebone-Black board (Jyri Sarha)

Jean-Francois Moine (5):
  drm/i2c: tda998x: add a function for dynamic audio input switch
  ASoC: tda998x: add a codec driver for the TDA998x
  ASoC: tda998x: add DT documentation of the tda998x CODEC
  ASoC: tda998x: adjust the audio hw parameters from EDID
  ASoC: tda998x: adjust the audio CTS_N pre-divider from audio format

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  17 ++
 drivers/gpu/drm/i2c/tda998x_drv.c                  |  86 +++++-
 include/drm/i2c/tda998x.h                          |  11 +-
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tda998x.c                         | 303 +++++++++++++++++++++
 6 files changed, 419 insertions(+), 6 deletions(-)
 create mode 100644 sound/soc/codecs/tda998x.c

-- 
1.9.rc1
