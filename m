From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 0/3] ASoC: Intel: Skylake: Add deep buffer
	support
Date: Mon, 19 Jun 2017 11:59:18 +0530
Message-ID: <1497853761-4778-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 065032668F0
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 08:44:19 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Now that we can configure DSP dma buffer size, the device can support deep
buffer playback. DSP fetches large buffer and can result fewer wakes, which
helps in power reduction.

So this series first adds a token in topology to get dma_buffer_size and
sends to firmware after conversion. Also ads a deepbuffer device to use
this support.

v1->v2
	Remove an unrelated change.

Ramesh Babu (2):
  ASoC: Intel: Skylake: Add deep buffer support
  ASoC: Intel: Skylake: Fix dma buffer size calculation

Subhransu S. Prusty (1):
  ASoC: skl_rt286: Add deepbuffer dai link

 include/uapi/sound/snd_sst_tokens.h    |  5 ++++-
 sound/soc/intel/boards/skl_rt286.c     | 18 ++++++++++++++++++
 sound/soc/intel/skylake/skl-messages.c | 29 +++++++++++++++++++++++++----
 sound/soc/intel/skylake/skl-topology.c |  4 ++++
 sound/soc/intel/skylake/skl-topology.h |  1 +
 5 files changed, 52 insertions(+), 5 deletions(-)

-- 
1.9.1
