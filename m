From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/6] ASoC: Intel: Skylake: probe and Kconfig
	simplifications
Date: Fri,  7 Dec 2018 17:50:02 -0600
Message-ID: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id C0D1E267D20
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 00:51:01 +0100 (CET)
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

The patches add support for CoffeeLake, harden and simplify the probe
for the Skylake driver, introduce more compile-time granularity so
that platforms can be selected individually.

The main difference since the RFC posted on November 20 is the
addition of the pci class/subclass/prog-if information. This greatly
simplifies the detection of the DSP and will allow for an automatic
selection between HDaudio legacy and Skylake drivers. As suggested by
Takashi this automatic selection will be posted separately (it will
result on changes on both sound/pci/hda and sound/soc/intel sides)

Pierre-Louis Bossart (5):
  ASoC: Intel: Skylake: Harden DSP detection with PCI class/subclass
    info
  ASoC: Intel: Skylake: stop probe if HDaudio capabilities don't exist
  ASoC: Intel: Skylake: remove useless tests on HDaudio capabilities
  ASoC: Intel: Skylake: add error logs on probe, remove dependency on
    NHLT
  ASoC: Intel: Skylake: Add more platform granularity

Takashi Iwai (1):
  ASoC: Intel: Skylake: Add CFL-S support

 sound/soc/intel/Kconfig                |  73 +++++++++++++--
 sound/soc/intel/boards/Kconfig         |  16 +++-
 sound/soc/intel/skylake/skl-messages.c |   8 ++
 sound/soc/intel/skylake/skl-nhlt.c     |   3 +
 sound/soc/intel/skylake/skl.c          | 125 +++++++++++++++++--------
 5 files changed, 179 insertions(+), 46 deletions(-)

-- 
2.17.1
