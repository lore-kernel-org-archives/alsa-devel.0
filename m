From: Marek Belisko <marek.belisko@gmail.com>
Subject: [PATCH v2 0/3] ASoC: Add devicetree support for spdif dummy codecs.
Date: Thu, 25 Apr 2013 15:13:11 +0200
Message-ID: <1366895594-19596-1-git-send-email-marek.belisko@streamunlimited.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, zonque@gmail.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Marek Belisko <marek.belisko@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org

changes from v1 (for patch 2 and 3):
- add prefix linux for compatible property (for both tx and rx)
- rename spdif_transceiver.c to spdif_transmitter.c
- add bindings documentation

Marek Belisko (3):
  ASoC: spdif_transceiver: Change driver filename to
    spdif_transmitter.c.
  ASoC: spdif_transmitter: Add DT support.
  ASoC: spdif_receiver: Add DT support.

 .../devicetree/bindings/sound/spdif-receiver.txt   |   10 ++++++++++
 .../bindings/sound/spdif-transmitter.txt           |   10 ++++++++++
 sound/soc/codecs/Makefile                          |    2 +-
 sound/soc/codecs/spdif_receiver.c                  |   10 ++++++++++
 .../{spdif_transciever.c => spdif_transmitter.c}   |   10 ++++++++++
 5 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/spdif-receiver.txt
 create mode 100644 Documentation/devicetree/bindings/sound/spdif-transmitter.txt
 rename sound/soc/codecs/{spdif_transciever.c => spdif_transmitter.c} (88%)

-- 
1.7.9.5
