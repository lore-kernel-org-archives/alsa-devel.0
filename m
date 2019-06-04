From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/4] ASoC: Intel: fix kernel oops in machine
	drivers
Date: Tue,  4 Jun 2019 15:08:54 -0500
Message-ID: <20190604200858.4867-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 991F1F89673
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2019 22:09:09 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The changes made for v5.1 to override the default platform_name
assumed the card device was properly initialized so that devm_strdup()
could be used. This is true for the majority of the machine drivers,
but unfortunately this isn't valid for four of the Cherrytrail-based
ones which don't follow the same programming flow and initialize the
card device last. After hitting a kernel oops on cht-bsw-max98090
(Cyan Chromebook) I found 3 other cases where the same fix is
required.

These fixes should be applied for 5.1 and 5.2. While it's not an
excuse for this miss, the impact is limited in that the kernel oops
will only happen when SOF is used.

Pierre-Louis Bossart (4):
  ASoC: Intel: cht_bsw_max98090: fix kernel oops with platform_name
    override
  ASoC: Intel: bytcht_es8316: fix kernel oops with platform_name
    override
  ASoC: Intel: cht_bsw_nau8824: fix kernel oops with platform_name
    override
  ASoC: Intel: cht_bsw_rt5672: fix kernel oops with platform_name
    override

 sound/soc/intel/boards/bytcht_es8316.c       | 2 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 2 +-
 sound/soc/intel/boards/cht_bsw_nau8824.c     | 2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.20.1
