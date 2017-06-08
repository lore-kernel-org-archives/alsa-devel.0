From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH v2 0/3] ASoC: Intel: Add Kabylake machine
	driver for RT5663+RT5514+MAX98927
Date: Wed,  7 Jun 2017 18:27:38 -0700
Message-ID: <1496885261-10771-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A53F7267230
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 03:27:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch set adds a machine driver for Kabylake platform which has RT5663,
RT5514 and MAX9827 codecs. It also adds the quirk data for the platform driver
to load the correct machine driver. 

For this particular machine, 

*  the RT5663 is a headset codec connected on SSP0
*  the RT5514 is a dmic codec connected on SSP1
*  the MAX98987 is a speaker codec connected on SSP1

Harsha Priya (3):
  ASoC: Intel: Add Kabylake machine driver for RT5514, RT5663 and
    MAX98927
  ASoC: Intel: Convert all sst_codecs data defintion to c99 style
  ASoC: Intel: Add Kabylake RT5663+RT5514+MAX98927 machine driver entry

 sound/soc/intel/Kconfig                            |  15 +
 sound/soc/intel/boards/Makefile                    |   2 +
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 640 +++++++++++++++++++++
 sound/soc/intel/skylake/skl.c                      |  37 +-
 4 files changed, 690 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c

-- 
1.9.1
