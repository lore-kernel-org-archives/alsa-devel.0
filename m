From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v8 0/2] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Thu, 23 Oct 2014 10:32:49 +0200
Message-ID: <cover.1414053169.git.moinejf@free.fr>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Andrew Jackson <Andrew.Jackson@arm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

The NXP TDA998x HDMI transmitter may transmit audio to the HDMI link
from 2 different sources, I2S and S/PDIF.

This patch set first adds an interface between a HDMI transmitter and
the HDMI CODEC.

The interface is then used by the TDA998x driver to describe its audio
capabilities (DAIs), to give the audio constraints of the HDMI
device (EDID) to the audio subsystem, and to connect the chosen audio
source to the HDMI link.

v8:
	- change some comments about the patches
v7:
	- remove the change of the K predivider (Jyri Sarha)
	- add S24_3LE and S32_LE as possible audio formats (Jyri Sarha)
	- don't move the struct priv2 definition and use the
	  slave encoder private data as the device private data
	  (Russell King)
	- remove the useless request_module (Russell King/Mark Brown)
	- don't lock the HDMI module (Russell King)
	- use platform_device_unregister to remove the codec
	  (Russell King)
v6:
	- extend the HDMI CODEC instead of using a specific CODEC
v5:
	- use the TDA998x private data instead of a specific area
	  for the CODEC interface
	- the CODEC is TDA998x specific (Mark Brown)
v4:
	- remove all the TDA998x specific stuff from the CODEC
	- move the EDID scan from the CODEC to the TDA998x
	- move the CODEC to sound/soc (Mark Brown)
	- update the audio_sample_rate from the EDID (Andrew Jackson)
v3: fix bad rate (Andrew Jackson)
v2: check double stream start (Mark Brown)

Jean-Francois Moine (2):
  ASoC: hdmi: Add a transmitter interface to the HDMI CODEC
  drm/i2c: tda998x: Use the HDMI audio CODEC interface

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  18 ++
 drivers/gpu/drm/i2c/Kconfig                        |   1 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 264 ++++++++++++++++++++-
 include/sound/hdmi.h                               |  20 ++
 sound/soc/codecs/hdmi.c                            | 176 +++++++++++++-
 5 files changed, 460 insertions(+), 19 deletions(-)
 create mode 100644 include/sound/hdmi.h

-- 
2.1.1
