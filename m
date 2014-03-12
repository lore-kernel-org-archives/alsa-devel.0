From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 00/12] Cleanup card DAPM and control setup
Date: Wed, 12 Mar 2014 15:27:28 +0100
Message-ID: <1394634460-15889-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id 29858264ECA
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 15:27:12 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

This patch series converts all remaining machine drivers that still register
their controls and DAPM elements with the CODEC to registering them with the
card. The reason for doing this is to be able to remove the hack in the ASoC
core that un-sets the name_prefix of a CODEC before calling the init callback
for a DAI link. This comes from a time where it was not possible to register
controls or DAPM elements at a card level. And removing this hack makes going
forward with the componentisation easier and it also looks like the DAI
multi-CODEC patch could benefit from this as well.

The series depends on topic/pxa and topic/dapm

- Lars

Lars-Peter Clausen (12):
  ASoC: ams-delta: Fix compile error
  ASoC: ams-delta: Convert to table based DAPM and control setup
  ASoC: mfld_machine: Convert to table based DAPM and control setup
  ASoC: omap-abe-twl6040: Register machine level DMIC DAPM routes with
    the card
  ASoC: omap: rx51: Convert to table based control and DAPM setup
  ASoC: omap3pandora: Convert to table based DAPM setup
  ASoC: davinci-evm: Register machine level DAPM elements with the card
  ASoC: snappercl15: Convert to table based DAPM setup
  ASoC: s6105-ipcam: Convert to table based DAPM setup
  ASoC: pxa: magician: Convert to table based DAPM and control setup
  ASoC: pxa: tosa: Convert to table based DAPM and control setup
  ASoC: Remove name_prefix un-set during DAI link init hack

 sound/soc/cirrus/snappercl15.c    | 18 +++--------
 sound/soc/davinci/davinci-evm.c   | 22 +++++--------
 sound/soc/intel/mfld_machine.c    | 49 ++++++++++++-----------------
 sound/soc/omap/ams-delta.c        | 66 +++++++++++++--------------------------
 sound/soc/omap/omap-abe-twl6040.c |  3 +-
 sound/soc/omap/omap3pandora.c     | 31 ++++++------------
 sound/soc/omap/rx51.c             | 47 +++++-----------------------
 sound/soc/pxa/magician.c          | 34 +++++++-------------
 sound/soc/pxa/tosa.c              | 35 ++++++++-------------
 sound/soc/s6000/s6105-ipcam.c     | 28 ++++++-----------
 sound/soc/soc-core.c              |  7 +----
 11 files changed, 108 insertions(+), 232 deletions(-)

-- 
1.8.0
