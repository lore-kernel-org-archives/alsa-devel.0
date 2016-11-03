From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 0/9] ASoC: Intel: Skylake: Add support for
	D0i3
Date: Thu,  3 Nov 2016 17:07:13 +0530
Message-ID: <1478173042-9458-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id A3FFE260083
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 12:28:16 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

This series adds support for low power D0i3 mode which lets audio controller
perform stream and non streaming usage scenarios while being in lower power
D0i3 state.

In this series, first we modify the sst_ipc_tx_message() API to check if
the DSP is in lower powered D0i3 mode or not and if so bring it to
active before sending any messages. This is followed by a new API
sst_ipc_tx_message_nopm() to send message without checking the new PM
method.

Then we start adding D0i3 refcounting which decides the entry to D0i3
mode based on capability. This is derived from topology data.
The new IPC to enter D0i3 is also required.

Finally we remove unwarranted pci device enabling calls on suspend.

Changes in v2:
 - update changelogs
 - remove patch 1 already applied

Jayachandran B (3):
  ASoC: Intel: Skylake: Add D0iX callbacks
  ASoC: Intel: Skylake: Flush pending D0i3 request on suspend
  ASoC: Intel: Skylake: remove pci device enabling calls on suspend

Pardha Saradhi K (2):
  ASoC: Intel: Skylake: Add D0iX IPCs
  ASoC: Intel: Skylake: Add support for programming D0i3C

Vinod Koul (4):
  ASoC: Intel: Add sst_ipc_tx_message_nopm
  ASoC: Intel: Skylake: Add support for LPMode
  ASoC: Intel: Skylake: Add support for specifying D0i3 configuration
  ASoC: Intel: Skylake: Add D0i3 mode ref counting

 include/uapi/sound/snd_sst_tokens.h    |   8 +-
 sound/soc/intel/common/sst-ipc.c       |   8 ++
 sound/soc/intel/common/sst-ipc.h       |   3 +
 sound/soc/intel/skylake/bxt-sst.c      | 145 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-messages.c |  30 ++++++-
 sound/soc/intel/skylake/skl-pcm.c      |  10 +++
 sound/soc/intel/skylake/skl-sst-dsp.h  |  12 +++
 sound/soc/intel/skylake/skl-sst-ipc.c  |  69 +++++++++++++++-
 sound/soc/intel/skylake/skl-sst-ipc.h  |  36 +++++++-
 sound/soc/intel/skylake/skl-topology.c |  47 +++++++++++
 sound/soc/intel/skylake/skl-topology.h |  11 +++
 sound/soc/intel/skylake/skl.c          |  59 +++++++++++++-
 sound/soc/intel/skylake/skl.h          |   6 ++
 13 files changed, 437 insertions(+), 7 deletions(-)

-- 
1.9.1
