From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 0/7] ASoC: hda - ASoC DSP widget event handlers
Date: Sun, 19 Apr 2015 02:27:26 +0530
Message-ID: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 683A3260881
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 23:02:42 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The aDSP is triggered by DAPM. The DAPM code is atm dependent upon the DFW
aka tplg RFC send by Liam. We will post missing tplg to driver links once
that series is accepted

This series is dependent upon
a) Takashi topic/hda which has core hdac splitup
b) SKL PCM driver series, which adds the SKL HDA Platform driver
c) SKL IPC series which sends IPCs to aDSP

This last series adds the missing link between b) and c).

Comments most welcome

-- 
~Vinod

Jeeja KP (7):
  ASoC: hda: Add skl dsp init and registering with SST IPC lib
  ASoC: hda: add hepler to configure module params
  ASoC: hda: add FW module init/bind IPC
  ASoC: hda: add FW pipe create/delete/set_pipe_state IPC
  ASOC: hda: add DSP platfrom controls widget event handlers
  ASoC: hda: Add support for SSP register settings
  ASoC: hda: Apply dai params_fixup for DSP widgets

 include/sound/soc-hda-sst-dsp.h    |    3 +
 sound/soc/hda/Kconfig              |    1 +
 sound/soc/hda/Makefile             |    3 +-
 sound/soc/hda/hda_dsp_controls.c   |  913 ++++++++++++++++++++++++++++++++++++
 sound/soc/hda/hda_dsp_controls.h   |  338 +++++++++++++
 sound/soc/hda/hda_dsp_ssp_config.c |  290 ++++++++++++
 sound/soc/hda/hda_dsp_ssp_config.h |  423 +++++++++++++++++
 sound/soc/hda/hda_skl.h            |  108 ++++-
 sound/soc/hda/hda_soc_dsp.c        |  702 +++++++++++++++++++++++++++
 9 files changed, 2767 insertions(+), 14 deletions(-)
 create mode 100644 sound/soc/hda/hda_dsp_controls.c
 create mode 100644 sound/soc/hda/hda_dsp_controls.h
 create mode 100644 sound/soc/hda/hda_dsp_ssp_config.c
 create mode 100644 sound/soc/hda/hda_dsp_ssp_config.h
 create mode 100644 sound/soc/hda/hda_soc_dsp.c

-- 
1.7.9.5
