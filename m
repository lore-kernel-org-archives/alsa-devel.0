From: jeeja.kp@intel.com
Subject: [PATCH v5 0/3] ASoC: Intel: Skylake: Driver updates
Date: Tue, 10 Jan 2017 17:57:45 +0530
Message-ID: <1484051268-9526-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CF3AD2673D1
 for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2017 13:16:51 +0100 (CET)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

This patch series includes driver updates for the handling scenarios 
during System S0/S3 transitions when audio stream is stopped during
system.
o move DMA configuration in DSP Gateway Module widget event handler to
ensure DMA is configured after resume. 
o Enable SSP MLCK using Supply widget. This will ensure the MCLK is
enabled when the widget is power on.
o Check DMA decouple register state before coupling/decoupling the DMA.
o In case of HDMI pass-through pipe, reset only the FE Pipe when stream
in in XRUN state.
o Resume the stream from HW renderer position.
o HDMI Codec pin and converter state need to be restored when stream
is resumed.

Changes in v2:
 - Addressed Mark's comment on patch 1, split this into 2 as this had
additional changes other than configuring the DMA.
 - Addressed Takashi's comment on the usage of snd_hdac_updatel() 

Changes in v3:
 - Addressed Takashi's comment on superfluous shift used in reading the
value of PPCTL register and also cleaned the condition for updating
the reg value.

Changes in v4:
 - Acked by Takashi for patch "ALSA: hda: check stream decoupled register
   state".
 - Removed compilation warning in patch "ASoC: hdac_hdmi: Enable pin and
   converter in prepare".
 - Remove 4 patches which are already applied.

Changes in v5:
 - Removed the SSP MCLK patchs from this series, will rework and posted
later based on Marks' comments.


Jeeja KP (3):
  ASoC: Intel: Skylake: Don't reset pass-through pipe in BE prepare
  ASoC: Intel: Skylake: set the resume point to LPIB
  ASoC: hdac_hdmi: Enable pin and converter in prepare

 sound/soc/codecs/hdac_hdmi.c      | 37 +++++++++++++++++--------------------
 sound/soc/intel/skylake/skl-pcm.c |  6 +++---
 2 files changed, 20 insertions(+), 23 deletions(-)

-- 
2.5.0
