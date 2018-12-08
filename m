From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] ALSA: HDAudio: enable dynamic selection
	between legacy and Skylake drivers
Date: Fri,  7 Dec 2018 18:00:37 -0600
Message-ID: <20181208000039.23384-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DBDED267D20
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 01:00:53 +0100 (CET)
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

This patchset depends on the "ASoC: Intel: Skylake: probe and Kconfig
simplifications" series.

Add the same logic based on PCI class/subclass/prog-if in the HDaudio
legacy probe, and add a module parameter to bypass or force the
automatic detection should it ever fail.

This patchset was tested on a SKL device with the DSP disabled and a
WHL device with the DSP enabled. All 6 combinations of
module parameters provided the expected behavior.

The SOF driver will use exactly the same mechanism, and add a mutual
exclusion with the Skylake/SST driver to avoid having 3 drivers for
the same PCI ID. Two is complicated enough.

Pierre-Louis Bossart (2):
  ALSA: HD-Audio: SKL+: abort probe if DSP is present and Skylake driver
    selected
  ALSA: HD-Audio: SKL+: force HDaudio legacy or SKL+ driver selection

 include/sound/hdaudio.h        |  6 ++++
 sound/pci/hda/Kconfig          | 46 +++++++++++++++++++++++++++++
 sound/pci/hda/hda_controller.h |  2 +-
 sound/pci/hda/hda_intel.c      | 53 +++++++++++++++++++++++++++++-----
 sound/soc/intel/Kconfig        |  6 ++++
 sound/soc/intel/skylake/skl.c  | 44 +++++++++++++++++++---------
 6 files changed, 135 insertions(+), 22 deletions(-)

-- 
2.17.1
