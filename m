From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH v3 0/3] ASoC: Intel: Add Kabylake machine
	driver for RT5663+RT5514+MAX98927
Date: Fri,  9 Jun 2017 15:18:51 -0700
Message-ID: <1497046734-31753-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A5472676E3
 for <alsa-devel@alsa-project.org>; Sat, 10 Jun 2017 00:19:01 +0200 (CEST)
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
  ASoC: Intel: Convert all sst_codecs data definition to c99 style
  ASoC: Intel: Add Kabylake RT5663+RT5514+MAX98927 machine driver entry

 sound/soc/intel/Kconfig                            |  15 +
 sound/soc/intel/boards/Makefile                    |   2 +
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 640 +++++++++++++++++++++
 sound/soc/intel/skylake/skl.c                      |  37 +-
 4 files changed, 690 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c

-- 
1.9.1
