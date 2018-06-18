From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/8] ASoC: Intel: common ACPI tables - take2
Date: Mon, 18 Jun 2018 13:29:34 -0500
Message-ID: <20180618182942.4925-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id D6203266E91
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 20:29:47 +0200 (CEST)
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

Last fall we started using common codec-indexed ACPI tables in
sound/soc/intel/common for BYT/CHT/HSW/BDW machine drivers. This is a
follow-up for all Skylake+ platforms.

The first three patches are cleanups and moves, no new functionality,
the last 5 add support for GeminiLake machine drivers as well as
references to SOF firmware/topology files.

Some of the ApolloLake tables map to machine drivers that haven't been
submitted yet but will be submitted after the SOF core patches, I
thought it was better to just go ahead with a single set of changes.

The code was pushed on
https://github.com/plbossart/sound/tree/topic/skl-acpi-tables to
trigger 0day tests, with no reports received. Naveen also tested the
GLK integration with his own machine driver patches submitted earlier today.

Comments welcome.

Naveen Manohar (3):
  ASoC: Intel: broxton: reduce machine name for bxt_da7219_max98357a
  ASoC: Intel: common: Add Geminilake Dialog+Maxim machine driver entry
  ASoC: Intel: common: add Geminilake Realtek+Maxim machine driver entry

Pierre-Louis Bossart (5):
  ASoC: Intel: Skylake: cleanup before moving ACPI tables
  ASoC: Intel: move SKL+ codec ACPI tables to common directory
  ASoC: Intel: common: add firmware/topology information for SOF
  ASoC: Intel: common: add entries for SOF-based machine drivers
  ASoC: Intel: common: fix copy/paste issue with SOF/broadwell topology
    file

 include/sound/soc-acpi-intel-match.h               |   5 +
 sound/soc/intel/boards/bxt_da7219_max98357a.c      |   4 +-
 sound/soc/intel/common/Makefile                    |   6 +-
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c  |  59 +++++++
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c  |  32 ++++
 sound/soc/intel/common/soc-acpi-intel-glk-match.c  |  51 +++++++
 .../intel/common/soc-acpi-intel-hsw-bdw-match.c    |   2 +-
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c  |  91 +++++++++++
 sound/soc/intel/common/soc-acpi-intel-skl-match.c  |  47 ++++++
 sound/soc/intel/skylake/skl.c                      | 170 ++-------------------
 10 files changed, 303 insertions(+), 164 deletions(-)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-bxt-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-cnl-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-glk-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-kbl-match.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-skl-match.c


base-commit: 5544717d416d9a095edc616be789bdab69e284dc
-- 
2.14.1
