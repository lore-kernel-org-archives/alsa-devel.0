From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/8] Baytrail followup
Date: Mon,  4 Jan 2016 17:20:22 -0600
Message-ID: <1451949630-3475-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A303F260564
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 00:20:54 +0100 (CET)
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
Cc: broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Thanks to Mark for merging most of the patches in the first batch.
Resending update for patches that where not merged.
No additional functionalitity, only correction in first patch to refer to 
correct SHA1 and copy/paste fixes in bytcr_rt5651 machine driver

Acknowledgements:
Keyon Jie for his MinnowBoard validation
Francisco Mendez for his help with the MCLK and jack detection
Jack Yu and Bard Liao for their codec support

Known issues: 
noise on startup when using speakers

Once this batch is merged, the following updates will be provided:
MCLK support to fix noise issues
BYT-CR fixes
jack detection

Jack Yu (1):
  ASoC: rt5640: add ASRC support

Jorge Fernandez Monteagudo (1):
  ASoC: Intel: Atom: Add support for HP ElitePad 1000 G2

Pierre-Louis Bossart (6):
  ASoC: Intel: fix ACPI probe regression with Atom DPCM driver
  ASoC: Intel: add bytct-rt5651 machine driver
  ASoC: intel: boards: add card for MinnowBoard I2S access
  ASoC: Intel: bytcr-rt5640: enable ASRC
  ASoC: Intel: bytcr_rt5640: fixup DAI codec_name with HID
  ASoC: Intel: Atom: add support for RT5642

 sound/soc/codecs/rt5640.c              | 103 ++++++++++
 sound/soc/codecs/rt5640.h              |  17 ++
 sound/soc/intel/Kconfig                |  24 +++
 sound/soc/intel/atom/sst/sst_acpi.c    |  23 ++-
 sound/soc/intel/boards/Makefile        |   4 +
 sound/soc/intel/boards/bytcr_nocodec.c | 233 +++++++++++++++++++++++
 sound/soc/intel/boards/bytcr_rt5640.c  |  25 ++-
 sound/soc/intel/boards/bytcr_rt5651.c  | 332 +++++++++++++++++++++++++++++++++
 sound/soc/intel/common/Makefile        |   5 +
 9 files changed, 760 insertions(+), 6 deletions(-)
 create mode 100644 sound/soc/intel/boards/bytcr_nocodec.c
 create mode 100644 sound/soc/intel/boards/bytcr_rt5651.c

-- 
1.9.1
