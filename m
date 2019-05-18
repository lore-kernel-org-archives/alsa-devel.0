From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] ASoC: Intel: fix rt5682-based machine
	drivers
Date: Sat, 18 May 2019 13:30:06 -0500
Message-ID: <20190518183009.13359-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BD6FF80C18
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2019 20:30:17 +0200 (CEST)
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

We have two machine drivers based on rt5682 and they both need a
correction for the mapping of the buttons, the initial mapping taken
from the DA7219 is incorrect.

Also fix ACPI tables, quirks as needed.

Sathya Prakash M R (2):
  ASoC: Intel: sof-rt5682: Few minor fixes for AMP SSP and codec button
  ASoC: Intel: soc-acpi: Fix machine selection order

Yong Zhi (1):
  ASoC: Intel: glk_rt5682_max98357a: Remap button control-function

 sound/soc/intel/boards/glk_rt5682_max98357a.c     |  7 ++++---
 sound/soc/intel/boards/sof_rt5682.c               | 12 +++++++-----
 sound/soc/intel/common/soc-acpi-intel-cnl-match.c | 10 +++++-----
 3 files changed, 16 insertions(+), 13 deletions(-)


base-commit: d0723c9d845f9a6ff1069e5786ccda8e81566763
-- 
2.20.1
