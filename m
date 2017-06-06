From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH 0/2] ASoC: Intel: Add Kabylake machine driver
	for RT5663+RT5514+MAX98927
Date: Tue,  6 Jun 2017 13:51:31 -0700
Message-ID: <1496782293-15658-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, broonie@kernel.org, patch@alsa-project.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch set adds a machine driver for Kabylake platform which has RT5663,
RT5514 and MAX9827 codecs. It also adds the quirk data for the platform driver
to load the correct machine driver. 

For this particular machine, 

*  the RT5663 is a headset codec connected on SSP0
*  the RT5514 is a dmic codec connected on SSP1
*  the MAX98987 is a speaker codec connected on SSP1

Harsha Priya (2):
  ASoC: Intel: Add Kabylake machine driver for RT5514, RT5663 and
    MAX98927
  ASoC: Intel: Add Kabylake RT5663+RT5514+MAX98927 machine driver entry

 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 640 +++++++++++++++++++++
 sound/soc/intel/skylake/skl.c                      |  29 +-
 2 files changed, 665 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c

-- 
1.9.1
