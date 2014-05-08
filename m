From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 0/7] ASoC: Intel: Baytrail SST suspend/resume
	support
Date: Thu,  8 May 2014 16:07:20 +0300
Message-ID: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 33D9226166B
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 15:08:23 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

This set adds suspend/resume support to Baytrail SST. This is
implemented by putting the DSP into reset and by releasing driver
resources before suspend. In resume path the DSP is rebooted in normal
boot state. Active streams are restored by restarting them from last
known buffer position before suspend.

Patches 1-5 are preparing for the suspend/resume and patch 6 implements
the core logic that takes care of stopping the DSP before suspend and
restarting it again after resume. Patch 7 removes ignore_suspend flag
from byt-rt5640 machine driver since it doesn't have use at the moment
and adds suspend/resume callbacks that are hooked to ASoC core. This
takes care that active stream will be paused and resumed over
suspend/resume cycle on byt-rt5640 machine.

Jarkko Nikula (5):
  ASoC: Intel: Sample Baytrail DSP DMA pointer only after each period
  ASoC: Intel: Simplify Baytrail stream control IPC construction
  ASoC: Intel: Pass stream start position to sst_byt_stream_start()
  ASoC: Intel: Move Baytrail extended fw address saving to
    sst_byt_boot()
  ASoC: Intel: Allow byt-5640 machine driver and SST core go to suspend

Liam Girdwood (2):
  ASoC: Intel: Allow Rx/Tx message list can be cleared prior to suspend
  ASoC: Intel: Add Baytrail suspend/resume support

 sound/soc/intel/byt-rt5640.c       |  14 +++-
 sound/soc/intel/sst-baytrail-dsp.c |  14 ++--
 sound/soc/intel/sst-baytrail-ipc.c | 124 ++++++++++++++++++++++++++++------
 sound/soc/intel/sst-baytrail-ipc.h |   7 +-
 sound/soc/intel/sst-baytrail-pcm.c | 135 ++++++++++++++++++++++++++++++++-----
 5 files changed, 249 insertions(+), 45 deletions(-)

-- 
2.0.0.rc0
