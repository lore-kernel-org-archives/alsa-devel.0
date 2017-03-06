From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/3] ASoC: add dio2125 amplifier support
Date: Mon,  6 Mar 2017 18:44:48 +0100
Message-ID: <20170306174451.24406-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E02D26699F
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 18:45:00 +0100 (CET)
Received: by mail-wm0-f50.google.com with SMTP id n11so70325555wma.1
 for <alsa-devel@alsa-project.org>; Mon, 06 Mar 2017 09:45:00 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

This patchset adds the support for the dio2125 from Dioo microcircuits.
The dio2125 is audio driver with adjustable gain. The EN pad allows to
enable or disable the outputs of the driver.

The link to the datasheet is not provided as part of the commit. It is not
provided the manufacturer and it is doubtful it will still be available a
few years from now. Still provided here in case anyone is interested [0].

This patchset has been tested on Amlogic's meson-gxbb-p200 board.

[0]: http://www.winine.com/Line%E9%9F%B3/DIO2125XM10%20V1.0.pdf

Jerome Brunet (3):
  dt-bindings: add vendor prefix for Dioo
  ASoC: dio2125: add dio2125 amp driver
  ASoC: dio2125: add dt-bindings

 .../devicetree/bindings/sound/dioo,dio2125.txt     |  12 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/dio2125.c                         | 120 +++++++++++++++++++++
 5 files changed, 140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/dioo,dio2125.txt
 create mode 100644 sound/soc/codecs/dio2125.c

-- 
2.9.3
