From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 0/5] ASoC: remove dmaengine
	compat_request_channel
Date: Mon,  9 Dec 2013 13:24:11 -0700
Message-ID: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B7CEE2650C5
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 21:24:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

This series removes almost all users of the ASoC dmaengine
compat_request_channel() function, and its implementation.

The ux500 driver still uses compat_request_channel. I believe that
Lars-Peter is working on removing its use from that driver. That patch
or series would need to be inserted between 4/5 and 5/5 in this series.

This series is based on ASoC's topic/dma branch.

I have only compile-tested these patches.

Stephen Warren (5):
  ASoC: ep93xx: get rid of ep93xx-pcm-audio struct device
  ASoC: ep93xx: remove custom DMA alloc compat function
  ASoC: SPEAr: get rid of spear-pcm-audio struct device
  ASoC: SPEAr: remove custom DMA alloc compat function
  ASoC: dmaengine: remove compat_request_channel

 include/sound/dmaengine_pcm.h         |  3 ---
 include/sound/spear_dma.h             |  1 -
 sound/soc/cirrus/edb93xx.c            |  2 +-
 sound/soc/cirrus/ep93xx-ac97.c        | 21 ++++++++++++++++--
 sound/soc/cirrus/ep93xx-i2s.c         | 23 +++++++++++++++++--
 sound/soc/cirrus/ep93xx-pcm.c         | 39 +++++++-------------------------
 sound/soc/cirrus/ep93xx-pcm.h         | 24 ++++++++++++++++++++
 sound/soc/cirrus/simone.c             |  2 +-
 sound/soc/cirrus/snappercl15.c        |  2 +-
 sound/soc/soc-generic-dmaengine-pcm.c |  3 ---
 sound/soc/spear/spdif_in.c            | 25 +++++++++++++++++----
 sound/soc/spear/spdif_out.c           | 26 ++++++++++++++++++----
 sound/soc/spear/spear_pcm.c           | 42 ++++++++++-------------------------
 sound/soc/spear/spear_pcm.h           | 26 ++++++++++++++++++++++
 14 files changed, 156 insertions(+), 83 deletions(-)
 create mode 100644 sound/soc/cirrus/ep93xx-pcm.h
 create mode 100644 sound/soc/spear/spear_pcm.h

-- 
1.8.1.5
