From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/3] ASoC: Intel: boards: fix compilation
	and quirk handling
Date: Fri, 19 Apr 2019 15:12:15 -0500
Message-ID: <20190419201218.19821-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F06C8F896E2
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 22:12:23 +0200 (CEST)
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
Cc: tiwai@suse.de, hdegoede@redhat.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Fix compilation warning and align quirk override handling between
machine drivers.

V2: use default -1 in all cases as discussed with Hans de Goede

Pierre-Louis Bossart (3):
  ASoC: Intel: bytcht_es8316: fix compilation warning
  ASoC: Intel: bytcr_rt5640: align quirk override handling
  ASoC: Intel: bytcr_rt5651: align quirk override handling

 sound/soc/intel/boards/bytcht_es8316.c | 7 ++++---
 sound/soc/intel/boards/bytcr_rt5640.c  | 6 +++---
 sound/soc/intel/boards/bytcr_rt5651.c  | 6 +++---
 3 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.17.1
