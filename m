From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/4] ASoC: sst-haswell-pcm: Move controls and
	DAPM elements to component
Date: Wed, 20 Aug 2014 13:08:45 +0200
Message-ID: <1408532929-26978-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-032.synserver.de (smtp-out-036.synserver.de
 [212.40.185.36])
 by alsa0.perex.cz (Postfix) with ESMTP id D709F2656DC
 for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2014 13:08:51 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The sst-haswell-pcm driver is the only one that registers controls and DAPM
elements for a snd_soc_platform_driver. Moving them over to the component that
is registered by the same driver make it possible to remove the
steal_silbling_dai_hack in the core as well as the extra indirection that is
used to register the controls and DAPM elements.

Vinod, Subhransu, can you take a look at this and make sure it works as expected
and also keep this in mind for the new DPCM drivers?

Thanks,
- Lars

Lars-Peter Clausen (4):
  ASoC: Add snd_soc_component_{get,set}_drvdata()
  ASoC: sst-haswell-pcm: Alloc state struct in driver probe()
  ASoC: sst-haswell-pcm: Move controls and DAPM elements to component
  ASoC: Remove table based DAPM/control setup support from
    snd_soc_platform_driver

 include/sound/soc.h               | 28 ++++++++++---------
 sound/soc/intel/sst-haswell-pcm.c | 56 ++++++++++++++++++-------------------
 sound/soc/soc-core.c              | 58 ++++-----------------------------------
 3 files changed, 49 insertions(+), 93 deletions(-)

-- 
1.8.0
