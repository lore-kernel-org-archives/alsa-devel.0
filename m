From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH for -rc] i.MX updates
Date: Thu,  4 Nov 2010 17:05:38 +0100
Message-ID: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A456010386B
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 17:05:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

The following series has some multicomponent fixes for i.MX. Also, since
the SDMA driver is merged, we also switch the i.MX DMA driver to the new API.

Sascha

The following changes since commit c8ddb2713c624f432fa5fe3c7ecffcdda46ea0d4:

  Linux 2.6.37-rc1 (2010-11-01 07:54:12 -0400)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git asoc-rc-pu

Sascha Hauer (7):
      ASoC: i.MX31ads: initialize only on correct machine
      ASoC i.MX eukrea tlv320: Fix for multicomponent
      ASoC i.MX phycore ac97: remove unnecessary includes
      ASoC i.MX: register dma audio device
      ASoC i.MX: switch to new DMA api
      phycore-ac97: add ac97 to cardname
      ASoC: i.MX: we can do mono

 sound/soc/imx/eukrea-tlv320.c   |    8 +-
 sound/soc/imx/imx-pcm-dma-mx2.c |  221 +++++++++++++++++----------------------
 sound/soc/imx/imx-ssi.c         |   48 ++++++---
 sound/soc/imx/imx-ssi.h         |    4 +
 sound/soc/imx/phycore-ac97.c    |    5 +-
 sound/soc/imx/wm1133-ev1.c      |    4 +
 6 files changed, 142 insertions(+), 148 deletions(-)
