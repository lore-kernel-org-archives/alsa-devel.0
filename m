From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 0/5] ASoC: codecs: ad193x:  Several fixes and imprevements
Date: Mon, 18 Feb 2019 16:10:26 +0000
Message-ID: <20190218160954.13929-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Codrin.Ciubotariu@microchip.com
List-Id: alsa-devel@alsa-project.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

This patch set contains some changes I needed to make I2S and TDM=20
(DSP_A) formats work. I tested only with ad1936, but the patches
should work fine for all the codecs that use this driver. Although I
checked the DS for all of them (I hope) to assure that the patches
apply, I would really appreciate if someone else can test them on
another codec.

Codrin Ciubotariu (5):
  ASoC: codecs: ad193x: Remove capture support for codecs without ADC
  ASoC: codecs: ad193x: Set constraint to always have 32 sample bits
  ASoC: codecs: ad193x: Fix frame polarity for DSP_A format
  ASoC: codecs: ad193x: Add runtime support for DSP_A and I2S modes
  ASoC: codecs: ad193x: Add support to disable on-chip PLL

 sound/soc/codecs/ad193x.c | 76 ++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/ad193x.h |  8 +++++
 2 files changed, 80 insertions(+), 4 deletions(-)

--=20
2.17.1
