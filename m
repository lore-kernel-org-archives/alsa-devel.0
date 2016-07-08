From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ASoC: Intel: Add support for surface3
	tablet
Date: Fri,  8 Jul 2016 15:39:48 +0530
Message-ID: <1467972591-29175-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B9345265914
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 12:03:07 +0200 (CEST)
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
Cc: Stephen Just <stephenjust@gmail.com>, patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, apterix@gmail.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, bugzilla@hadess.net
List-Id: alsa-devel@alsa-project.org

Surface3 tablet is CHT based device which used RT5645 codec. But the ACPI ID
is 10EC5640 which belong to RT5640 codec :(
So we add quirk support to load cht-machine driver for surface tablet
combination, add the ACPI id and DMI fix for jack detect in codec and
finally machine update.

This fixes Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98001
Please verify and send your tested-by.

Vinod Koul (3):
  ASoC: Intel: Atom: Add quirk for Surface 3
  ASoC: rt5645: Add ACPI ID 10EC5640
  ASoC: Intel: Add surface3 entry in CHT-RT5645 machine

 sound/soc/codecs/rt5645.c               |  7 ++++++
 sound/soc/intel/atom/sst/sst_acpi.c     | 44 ++++++++++++++++++++++++++++++++-
 sound/soc/intel/boards/cht_bsw_rt5645.c | 20 ++++++++++++++-
 sound/soc/intel/common/sst-acpi.h       |  2 +-
 4 files changed, 70 insertions(+), 3 deletions(-)

-- 
1.9.1
