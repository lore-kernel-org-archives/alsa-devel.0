From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH 0/3] ASoC: Intel: Skylake: Driver updates for
	new DSP FW
Date: Mon,  2 Apr 2018 12:15:47 +0530
Message-ID: <1522651550-27236-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 8327A266A73
 for <alsa-devel@alsa-project.org>; Mon,  2 Apr 2018 08:54:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

The series contains driver changes which are needed
to be compatible with the new DSP Firmware.

Divya Prakash (1):
  ASoC: Intel: Skylake: Reset DSP pipe in skl_pcm_hw_free

Pardha Saradhi K (1):
  ASoC: Intel: Skylake: Reset DSP Pipelines in prepare

Pradeep Tewani (1):
  ASoC: Intel: Skylake: Unify the fw ops for SKL and KBL

 sound/soc/intel/skylake/skl-messages.c |  2 +-
 sound/soc/intel/skylake/skl-pcm.c      | 36 ++++++++++++++++++++++++++++++----
 sound/soc/intel/skylake/skl-sst-dsp.h  |  3 ---
 sound/soc/intel/skylake/skl-sst.c      | 34 ++------------------------------
 4 files changed, 35 insertions(+), 40 deletions(-)

-- 
2.7.4
