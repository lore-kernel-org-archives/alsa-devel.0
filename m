From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/2] ALSA: HDAudio: enable dynamic selection
	between legacy and Skylake drivers
Date: Sat, 15 Dec 2018 14:07:21 -0600
Message-ID: <20181215200723.4216-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 6058326789B
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2018 21:07:38 +0100 (CET)
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Chris Chiu <chiu@endlessm.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

Use detection logic based on the PCI class/subclass/prog-if in the
HDaudio legacy probe, and add a module parameter to bypass or force
the automatic detection should it ever fail (or in case of missing
firmware or topology files)

This patchset was tested on
1. an SKL HP device with the DSP disabled
2. a WHL Acer Swift3 laptop
3. APL NUC6
4. KBL NUC7

5 reboot tests were done for each device with the DSP presence
detected reliably. The "pci_binding" parameter was also tested on the
WHL device.

The dynamic selection adds about 5ms worst case.

[    2.813741] snd_hda_intel 0000:00:1f.3: The DSP is enabled on this platform, aborting probe
[    2.850588] snd_soc_skl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040100

The SOF driver will use exactly the same mechanism, and add a mutual
exclusion with the Skylake/SST driver to avoid having 3 drivers for
the same PCI ID. Two is complicated enough.

Changes since v1 (Feedback from Takashi)
a) added explanations and renamed Kconfigs to SND_HDA_INTEL_DSP_DETECTION_XYZ
b) less verbose dev_info
c) fixed pci_binding parameter

Pierre-Louis Bossart (2):
  ALSA: HD-Audio: SKL+: abort probe if DSP is present and Skylake driver
    selected
  ALSA: HD-Audio: SKL+: force HDaudio legacy or SKL+ driver selection

 include/sound/hdaudio.h        |  6 ++++
 sound/pci/hda/Kconfig          | 62 ++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_controller.h |  2 +-
 sound/pci/hda/hda_intel.c      | 54 +++++++++++++++++++++++++----
 sound/soc/intel/Kconfig        |  6 ++++
 sound/soc/intel/skylake/skl.c  | 48 ++++++++++++++++++--------
 6 files changed, 155 insertions(+), 23 deletions(-)


base-commit: ba26f635bf7253b42b08135152b18a2c8082abb7
-- 
2.17.1
