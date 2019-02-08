From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/17] ASoC: soc-acpi: remove SOF file prefix
	and unused fields
Date: Fri,  8 Feb 2019 17:45:40 -0600
Message-ID: <20190208234557.7816-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 66A252674C9
 for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2019 00:46:04 +0100 (CET)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Remove the hard-coded "intel" for all SOF files. The SOF code now adds
a different default path for firmware and topology, both of which can
be overridden by kernel module arguments. The intent is to make
releases more manageable since for the same platform there will be
different releases (e.g. public and public+non-public
components). This change should have no impact since pre-production
devices with early versions of SOF will be updated with these patches.

Also remove fields that have not been used by SOF in a long time,
Marie Kondo style. In hindsight no one seems to recall why they were
necessary.

Pierre-Louis Bossart (17):
  ASoC: Intel: bxt-match: remove prefix for SOF files
  ASoC: Intel: byt-match.c: remove prefix for SOF files
  ASoC: Intel: cht-match: remove prefix for SOF files
  ASoC: Intel: cnl-match: remove prefix for SOF files
  ASoC: Intel: glk-match: remove prefix for SOF files
  ASoC: Intel: hda-match: remove prefix for SOF files
  ASoC: Intel: hsw-bdw-match: remove prefix for SOF files
  ASoC: Intel: icl-match: remove prefix for SOF files
  ASoC: Intel: soc-acpi: bxt-match: remove asoc_plat_name field
  ASoC: Intel: soc-acpi: byt-match: remove asoc_plat_name field
  ASoC: Intel: soc-acpi: cht-match: remove asoc_plat_name field
  ASoC: Intel: soc-acpi: glk-match: remove asoc_plat_name field
  ASoC: Intel: soc-acpi: hsw-bdw-match: remove asoc_plat_name field
  ASoC: Intel: soc-acpi: icl-match: remove asoc_plat_name field
  ASoC: Intel: soc-acpi: cnl-match.c: remove asoc_plat_name field
  ASoC: soc-acpi: remove asoc_plat_name field
  ASoC: soc-acpi: remove new_mach_data field

 include/sound/soc-acpi.h                      |  5 --
 .../intel/common/soc-acpi-intel-bxt-match.c   | 25 +++----
 .../intel/common/soc-acpi-intel-byt-match.c   | 60 +++++++---------
 .../intel/common/soc-acpi-intel-cht-match.c   | 70 ++++++++-----------
 .../intel/common/soc-acpi-intel-cnl-match.c   |  5 +-
 .../intel/common/soc-acpi-intel-glk-match.c   | 10 ++-
 .../intel/common/soc-acpi-intel-hda-match.c   |  2 +-
 .../common/soc-acpi-intel-hsw-bdw-match.c     | 20 +++---
 .../intel/common/soc-acpi-intel-icl-match.c   |  5 +-
 9 files changed, 79 insertions(+), 123 deletions(-)

-- 
2.17.1
