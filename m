From: Jenny TC <jenny.tc@intel.com>
Subject: [PATCH v2] ASoC: Intel: Boards: Add Maxim98373 support
Date: Mon, 25 Feb 2019 22:17:30 +0530
Message-ID: <1551113251-21317-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33D4DF89650
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 17:47:46 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: N Harshapriya <harshapriya.n@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Chiang Mac <mac.chiang@intel.com>, Nujella Sathyanarayana <sathyanarayana.nujella@intel.com>, M R Sathya Prakash <sathya.prakash.m.r@intel.com>, M Naveen <naveen.m@intel.com>, jenny.tc@intel.com
List-Id: alsa-devel@alsa-project.org

Reuse kbl_da7219_max98927 machine driver to support max98373

v1: First patchset
V2: Updated commit message and Acked-by

Jenny TC (1):
  ASoC: Intel: Boards: Add Maxim98373 support

 sound/soc/intel/boards/Kconfig                    |   1 +
 sound/soc/intel/boards/kbl_da7219_max98927.c      | 203 +++++++++++++++++++---
 sound/soc/intel/common/soc-acpi-intel-kbl-match.c |  19 ++
 3 files changed, 200 insertions(+), 23 deletions(-)

-- 
1.9.1
