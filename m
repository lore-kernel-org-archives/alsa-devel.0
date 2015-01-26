From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH 0/4] sound:soc: jz4740: DT, dynamic sampling, enable clocks
Date: Mon, 26 Jan 2015 10:18:27 +0000
Message-ID: <1422267511-6649-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, perex@perex.cz
Cc: broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Zubair.Kakakhel@imgtec.com
List-Id: alsa-devel@alsa-project.org

Hi,

Here are a few simple patches for the jz4740.

First adds dynamic sampling support to jz4740-i2s.
Then two to add a simple binding and DT support.
Then a patch to enable the codec clock.

These are in preparation for jz4780 and ci20 later on.

These are based on 3.19-rc6. 

If you would like to have them rebased to a different tree, please tell.

Thank-you

Zubair Lutfullah Kakakhel (4):
  sound: soc: jz4740: Add dynamic sampling rate support to jz4740-i2s
  dt: sound: jz4740: Add binding documentation for jz4740-i2s
  sound: soc: jz4740: Add DT support to jz4740-i2s driver
  sound: jz4740: Enable codec clock during dai_probe

 .../bindings/sound/ingenic,jz4740-i2s.txt          | 18 ++++++++++++++++
 sound/soc/jz4740/jz4740-i2s.c                      | 24 +++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt

-- 
1.9.1
