From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 0/3] ASoC: Move pcm writecombine dma buffer allocation to core
Date: Fri, 29 Jun 2012 15:53:15 +0530
Message-ID: <1340965398-20872-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, lrg@ti.com, broonie@opensource.wolfsonmicro.com, lars@metafoo.de, swarren@nvidia.com, perex@perex.cz, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Some of the ARM based soc allocate the writecombine dma buffer for
pcm substreams. They have the same codes for managing this buffer.
Moving this to the core/pcm files so that they can use that directly.

Remove the code from Tegra PCM and use these new library function.

This is enabled only for ARM specific and can be extended to other
architecture if they support the writecombine dma buffer.

This patch is based on detail discussion on patch:
[PATCH] ASoC: snd_dmaengine: add common api for pcm_mmap
And suggestion from Lars and Takashi.


Laxman Dewangan (3):
  ALSA: pcm: add apis for writecombine dma buffer allocation
  ASoC: add apis for creating/free pcm dma buffer
  ASoC: tegra: use core/pcm library for pcm buffer allocation

 include/sound/pcm.h         |   17 ++++++++
 include/sound/soc.h         |   13 ++++++
 sound/core/pcm_native.c     |   53 +++++++++++++++++++++++++
 sound/soc/soc-core.c        |   50 +++++++++++++++++++++++
 sound/soc/tegra/tegra_pcm.c |   92 ++-----------------------------------------
 5 files changed, 137 insertions(+), 88 deletions(-)
