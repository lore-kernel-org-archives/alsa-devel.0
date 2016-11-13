From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] More Baytrail improvements
Date: Sat, 12 Nov 2016 18:07:43 -0600
Message-ID: <1478995666-3866-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D1C92260083
 for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2016 01:07:52 +0100 (CET)
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

this patchset introduces an auto-detect mechanism to avoid adding
quirks over and over. The BIOS provides information on AIF1/AIF2
connection and we set the microphone settings differently on
baytrail-CR. This was tested on a variety of platforms and most
people should have sound without quirks.

Pierre-Louis Bossart (3):
  ASoC: Intel: common: add ACPI package extraction utility
  ASoC: Intel: detect audio routing with CHAN package
  ASoC: Intel: bytct_rt5640: change default capture settings

 sound/soc/intel/boards/bytcr_rt5640.c   | 64 ++++++++++++++++++++++++++++++---
 sound/soc/intel/common/sst-acpi.h       | 17 ++++++++-
 sound/soc/intel/common/sst-match-acpi.c | 57 +++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 6 deletions(-)

-- 
2.7.4
