From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] SOF dependencies
Date: Fri, 30 Nov 2018 18:54:35 -0600
Message-ID: <20181201005437.5198-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 07C7F267B9E
 for <alsa-devel@alsa-project.org>; Sat,  1 Dec 2018 01:54:56 +0100 (CET)
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Two minor patches that are needed to build the rest of the SOF patches
which I will post next week after the last round of internal
reviews. Submitting them first.

Keyon Jie (1):
  ALSA: HDA: export process_unsol_events()

Pierre-Louis Bossart (1):
  ASoC: Intel: common: add ACPI matching tables for ICL

 include/sound/hdaudio.h                       |  1 +
 include/sound/soc-acpi-intel-match.h          |  1 +
 sound/hda/hdac_bus.c                          |  7 ++--
 sound/soc/intel/common/Makefile               |  2 +-
 .../intel/common/soc-acpi-intel-icl-match.c   | 32 +++++++++++++++++++
 5 files changed, 38 insertions(+), 5 deletions(-)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-icl-match.c

-- 
2.17.1
