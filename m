From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Thu, 8 Sep 2011 11:22:42 -0700
Message-ID: <20110908182241.GF3591@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE50E24C56
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 20:22:45 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 18036b5866b5e407a28f444a80de186a5d7df767:

  ASoC: Correct element count for WM8996 sidetone HPF (2011-08-24 17:36:12 +0100)

are available in the git repository at:
  git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.1

You probably have some or all of these already but as your repository on
master is offline right now I'm going on the last thing I have synced.

Fabio Estevam (1):
      ASoC: imx: Fix build warning of unused 'card' variable

Lars-Peter Clausen (3):
      ASoC: snd_soc_codec_{readable,writable}_register change default to true
      ASoC: Fix register cache sync register_writable WARN_ONs
      ASoC: Blackfin: bf5xx-ad193x: Fix codec device name

Mark Brown (2):
      MAINTAINERS: Add some missed Wolfson files
      ASoC: Fix reporting of partial jack updates

Peter Ujfalusi (1):
      ASoC: soc-dapm: Fix parameter comment for snd_soc_dapm_free

Timur Tabi (1):
      ASoC: MPC5200: replace of_device with platform_device

 MAINTAINERS                       |    4 ++++
 sound/soc/blackfin/bf5xx-ad193x.c |    4 ++--
 sound/soc/fsl/mpc5200_dma.c       |    6 +++---
 sound/soc/imx/imx-pcm-fiq.c       |    1 -
 sound/soc/soc-cache.c             |   12 ++++++------
 sound/soc/soc-core.c              |    4 ++--
 sound/soc/soc-dapm.c              |    2 +-
 sound/soc/soc-jack.c              |    2 +-
 8 files changed, 19 insertions(+), 16 deletions(-)
