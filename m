From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 00/11] Handle return value of clk_prepare_enable.
Date: Tue, 25 Jul 2017 15:44:27 +0530
Message-ID: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

clk_prepare_enable() can fail here and we must check its return value.

Arvind Yadav (11):
  [PATCH 01/11] ASoC: samsung: s3c2412: Handle return value of clk_prepare_enable.
  [PATCH 02/11] ASoC: samsung: s3c24xx: Handle return value of clk_prepare_enable.
  [PATCH 03/11] ASoC: samsung: pcm: Handle return value of clk_prepare_enable.
  [PATCH 04/11] ASoC: samsung: i2s: Handle return value of clk_prepare_enable.
  [PATCH 05/11] ASoC: samsung: spdif: Handle return value of clk_prepare_enable.
  [PATCH 06/11] ASoC: mxs-saif: Handle return value of clk_prepare_enable/clk_prepare.
  [PATCH 07/11] ASoC: jz4740: Handle return value of clk_prepare_enable.
  [PATCH 08/11] ASoC: sun4i-spdif: Handle return value of clk_prepare_enable.
  [PATCH 09/11] ASoC: atmel: ac97c: Handle return value of clk_prepare_enable.
  [PATCH 10/11] ASoC: pxa: Handle return value of clk_prepare_enable.
  [PATCH 11/11] ASoC: pxa-ssp: Handle return value of clk_prepare_enable.

 sound/atmel/ac97c.c             |  8 +++++---
 sound/soc/jz4740/jz4740-i2s.c   | 21 +++++++++++++++++----
 sound/soc/mxs/mxs-saif.c        | 13 ++++++++++---
 sound/soc/pxa/pxa-ssp.c         | 23 +++++++++++++++++------
 sound/soc/pxa/pxa2xx-i2s.c      |  6 +++++-
 sound/soc/samsung/i2s.c         | 19 +++++++++++++++----
 sound/soc/samsung/pcm.c         |  8 ++++++--
 sound/soc/samsung/s3c2412-i2s.c |  4 +++-
 sound/soc/samsung/s3c24xx-i2s.c | 11 +++++++++--
 sound/soc/samsung/spdif.c       |  8 ++++++--
 sound/soc/sunxi/sun4i-spdif.c   | 11 ++++++++---
 11 files changed, 101 insertions(+), 31 deletions(-)

-- 
1.9.1
