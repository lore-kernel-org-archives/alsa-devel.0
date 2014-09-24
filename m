From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v6 0/2] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Wed, 24 Sep 2014 10:23:34 +0200
Message-ID: <cover.1411547014.git.moinejf@free.fr>
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

This patch set adds an interface between the HDMI transmitter and
the HDMI CODEC.

The interface is used by the TDA998x driver to update the audio
constraints from the display characteristics (EDID) and by the audio
subsystem to connect the chosen audio source to the HDMI link.

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
  ASoC:codecs: Add a transmitter interface to the HDMI CODEC
  drm/i2c:tda998x: Use the HDMI audio CODEC

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  18 ++
 drivers/gpu/drm/i2c/Kconfig                        |   1 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 299 +++++++++++++++++++--
 include/sound/hdmi.h                               |  20 ++
 sound/soc/codecs/hdmi.c                            | 174 +++++++++++-
 5 files changed, 488 insertions(+), 24 deletions(-)
 create mode 100644 include/sound/hdmi.h

-- 
2.1.1
