From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/4] ASoC: Intel: boards: quirks and DMIC
	corrections
Date: Fri,  9 Aug 2019 18:22:32 -0500
Message-ID: <20190809232236.21182-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40638F800E4
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2019 01:22:41 +0200 (CEST)
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

Extend quirk for GeminiLake-based Chromebooks and correct missing
dependencies for DMIC support (align with all other machine drivers).

Keyon Jie (3):
  ASoC: Intel: sof-rt5682: add dmic dapm widget to support dmic PCM
  ASoC: Intel: skl-hda-dsp-generic: add dependency to dmic driver
  ASoC: Intel: skl-hda-dsp-generic: add dmic dapm widget and route

Sathya Prakash M R (1):
  ASoC: Intel: boards: Match Product Family instead of product

 sound/soc/intel/boards/Kconfig               | 1 +
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 4 ++++
 sound/soc/intel/boards/sof_rt5682.c          | 7 +++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.20.1
