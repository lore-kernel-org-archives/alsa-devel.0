From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v4 0/2] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Sun, 31 Aug 2014 15:02:02 +0200
Message-ID: <cover.1409490122.git.moinejf@free.fr>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Andrew Jackson <Andrew.Jackson@arm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

The NXP TDA998x HDMI transmitter may transmit audio to the HDMI link
from 2 different sources, I2S and S/PDIF.

This patch set adds a generic HDMI CODEC module which is used by
the TDA998x driver to update the audio constraints from the display
characteristics (EDID) and by the audio subsystem to connect the chosen
audio source to the HDMI link.

v4:
	- remove all the TDA998x specific stuff from the CODEC
	- move the EDID scan from the CODEC to the TDA998x
	- move the CODEC to sound/soc (Mark Brown)
	- update the audio_sample_rate from the EDID (Andrew Jackson)
v3: fix bad rate (Andrew Jackson)
v2: check double stream start (Mark Brown)

Jean-Francois Moine (2):
  ASoC:codecs: Add a generic HDMI audio CODEC
  drm/i2c:tda998x: Use the HDMI2  audio CODEC

 Documentation/devicetree/bindings/sound/hdmi2.txt |  32 ++++
 drivers/gpu/drm/i2c/Kconfig                       |   1 +
 drivers/gpu/drm/i2c/tda998x_drv.c                 | 142 ++++++++++++++-
 include/sound/hdmi2.h                             |  24 +++
 sound/soc/codecs/Kconfig                          |   3 +
 sound/soc/codecs/Makefile                         |   2 +
 sound/soc/codecs/hdmi2.c                          | 204 ++++++++++++++++++++++
 7 files changed, 400 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/hdmi2.txt
 create mode 100644 include/sound/hdmi2.h
 create mode 100644 sound/soc/codecs/hdmi2.c

-- 
2.1.0
