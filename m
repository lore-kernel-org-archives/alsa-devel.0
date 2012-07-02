From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 0/2]  ASoC: Move pcm writecombine dma buffer allocation to core
Date: Mon, 2 Jul 2012 14:24:31 +0530
Message-ID: <1341219273-7439-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, lrg@ti.com, broonie@opensource.wolfsonmicro.com, lars@metafoo.de, swarren@nvidia.com, perex@perex.cz, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Some of the ARM based soc allocate the writecombine dma buffer for
pcm substreams. They have the same codes for managing this buffer.
Moving this to the core/pcm memory librray so that they can use that
directly.

Remove the code from Tegra PCM and use these new feature from library
function.

This is enabled only for ARM specific and can be extended to other
architecture if they support the writecombine dma buffer.

This patch is based on detail discussion on patch:
[PATCH] ASoC: snd_dmaengine: add common api for pcm_mmap
And suggestion from Lars and Takashi.

Changes from V1:
Takashi had send the sample code to integrate the writecombine with
dma coherant and this is based on that code.
Also change the tegra-pcm driver accordingly.


Laxman Dewangan (2):
  ALSA: Support writecombine DMA buffer memory page alloc/free
  ASoC: tegra: use sound pcm library for substream dma buffer

 include/sound/memalloc.h    |    1 +
 sound/core/memalloc.c       |   70 ++++++++++++++++++++++++---
 sound/core/pcm_native.c     |   10 ++++
 sound/soc/tegra/tegra_pcm.c |  112 ++++++++++--------------------------------
 4 files changed, 100 insertions(+), 93 deletions(-)
