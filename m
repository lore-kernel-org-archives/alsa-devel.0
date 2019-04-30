From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] ASoC: Intel: machine drivers for SOF
Date: Tue, 30 Apr 2019 17:37:41 -0500
Message-ID: <20190430223744.3863-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3056EF80759
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 00:38:03 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add support for the two main machine drivers used by SOF (not tested
with the Skylake driver due to lack of hardware and/or firmware
signature/ missing topology)

The DMIC support for HDaudio-based devices is very much needed for a
number of WhiskyLake+ platforms designed for Windows. SOF will be the
only Intel driver supporting this configuration. A firmware binary
signed with the required production key should be available shortly.

The rt5682 codec is the main validation vehicle of the Intel SOF team,
with eval boards connected to the Baytrail MinnowBoard as well as more
recent devices. The main difference with traditional Intel machine
drivers is that the dai links are added dynamically at probe time to
avoid multiple table copy/pastes.

Bard liao (1):
  ASoC: Intel: add sof-rt5682 machine driver

Rander Wang (2):
  ASoC: Intel: skl_hda_dsp_generic: add DMIC support
  ASoC: Intel: skl_hda_dsp_generic:refine code style

 sound/soc/intel/boards/Kconfig                |  16 +
 sound/soc/intel/boards/Makefile               |   2 +
 sound/soc/intel/boards/skl_hda_dsp_common.c   |  22 +-
 sound/soc/intel/boards/skl_hda_dsp_common.h   |   2 +-
 sound/soc/intel/boards/skl_hda_dsp_generic.c  |  19 +-
 sound/soc/intel/boards/sof_rt5682.c           | 563 ++++++++++++++++++
 .../intel/common/soc-acpi-intel-byt-match.c   |   6 +
 .../intel/common/soc-acpi-intel-cht-match.c   |   6 +
 .../intel/common/soc-acpi-intel-cnl-match.c   |  19 +
 .../intel/common/soc-acpi-intel-icl-match.c   |   6 +
 10 files changed, 656 insertions(+), 5 deletions(-)
 create mode 100644 sound/soc/intel/boards/sof_rt5682.c

-- 
2.17.1
