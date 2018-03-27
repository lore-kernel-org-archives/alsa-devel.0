From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 0/6] ASoC: SOF driver dependencies
Date: Tue, 27 Mar 2018 14:30:39 +0100
Message-ID: <20180327133045.29351-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 941F926718B
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 15:31:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This series is a set of ASoC core and topology updates needed by the SOF
driver.

The SOF driver uses topology extensively to define most of the characteristsics
of an audio card with the exception of some immutable items like hardware
backend DAI links.

The SOF driver also allows for reuse of existing upstream machine drivers
by re-writting some aspects of the DAI link and DAPM configuration with data
from topology. i.e. existing machine drivers can be reused with different
topologies.

V2: Rebased on top of today for-next, V1 was probably missing 1/6 meaning
the others would not apply.

Liam Girdwood (6):
  ASoC: core: Allow topology to override machine driver FE DAI link
    config.
  ASoC: core: Add name prefix for machines with topology rewrites
  ASoC: topology: Give more data to clients via callbacks
  ASoC: topology: Add callback for DAPM route load/unload
  ASoC: topology: Check widget kcontrols before deref.
  ASoC: topology: Add support for compressed PCMs

 include/sound/soc-topology.h           | 30 ++++++++----
 include/sound/soc.h                    | 12 +++++
 sound/soc/intel/skylake/skl-pcm.c      |  7 +--
 sound/soc/intel/skylake/skl-topology.c |  5 +-
 sound/soc/intel/skylake/skl-topology.h | 20 ++------
 sound/soc/soc-core.c                   | 87 ++++++++++++++++++++++++++++++++--
 sound/soc/soc-pcm.c                    | 12 +++++
 sound/soc/soc-topology.c               | 51 ++++++++++++++------
 8 files changed, 177 insertions(+), 47 deletions(-)

-- 
2.14.1
