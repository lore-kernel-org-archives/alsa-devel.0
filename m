From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/4] ASoC: Intel/SOF: add initial support for
	Tiger Lake and Elhkart Lake
Date: Thu, 15 Aug 2019 10:57:45 -0500
Message-ID: <20190815155749.29304-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD92FF80273
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 18:01:16 +0200 (CEST)
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

Add initial/minimal support for PCI enumeration, hardware descriptions
and ACPI match tables.

Follow-up patches will be provided to enable multi-core support
(requires new IPC calls). Machine drivers will be provided at a later
point as well when there are fewer configurations. And last HDMI work
is required to handle the 4 converters (which may be combined with the
transition from hdac_hdmi to patch_hdmi already mentioned by Kai).

Pan Xiuli (4):
  ASoC: Intel: common: add ACPI matching tables for Tiger Lake
  ASoC: SOF: Intel: initial support for Tiger Lake.
  ASoC: Intel: common: add ACPI matching tables for EHL
  ASoC: SOF: Intel: initial support for Elkhart Lake

 include/sound/soc-acpi-intel-match.h          |  2 +
 sound/soc/intel/common/Makefile               |  1 +
 .../intel/common/soc-acpi-intel-ehl-match.c   | 18 ++++++++
 .../intel/common/soc-acpi-intel-tgl-match.c   | 24 ++++++++++
 sound/soc/sof/intel/Kconfig                   | 32 ++++++++++++++
 sound/soc/sof/intel/cnl.c                     | 32 ++++++++++++++
 sound/soc/sof/intel/hda.h                     |  2 +
 sound/soc/sof/sof-pci-dev.c                   | 44 +++++++++++++++++++
 8 files changed, 155 insertions(+)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-ehl-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-tgl-match.c

-- 
2.20.1
