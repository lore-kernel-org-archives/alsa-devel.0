From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2 0/1] ASoC: Intel: Use acpi_dev_present()
Date: Thu, 14 Jan 2016 21:57:20 +0100
Message-ID: <cover.1452787340.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
 [83.223.90.233])
 by alsa0.perex.cz (Postfix) with ESMTP id E40A5260535
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 21:57:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, "Fang, Yang A" <yang.a.fang@intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

the acpi_dev_present() API has now landed in Linus' tree.
Thus, after Linus' tree gets merged back into yours,
it would be possible to use the API in the ASoC drivers
as per the following patch.

I've also pushed it to GitHub in case anyone prefers
perusing it in a browser:
https://github.com/l1k/linux/commit/f9011bb760cf5296474191406116e989dd292bf0

v1 of this patch was originally submitted with:
Message-Id: <b7bd5f48fd254fb743b99d5c3e63f95ea8dfd8a7.1448282995.git.lukas@wunner.de>
Link: http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100922.html

Thanks,

Lukas


Lukas Wunner (1):
  ASoC: Intel: Use acpi_dev_present()

 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 17 ++---------------
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 13 +------------
 sound/soc/intel/common/sst-match-acpi.c      | 16 +---------------
 3 files changed, 4 insertions(+), 42 deletions(-)

-- 
1.8.5.2 (Apple Git-48)
