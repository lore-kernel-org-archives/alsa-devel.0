From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 1/6] ASoC: Intel: boards: remove
	unnecessary inclusion of skl.h
Date: Thu, 23 May 2019 18:39:46 -0500
Message-ID: <20190523233951.31122-2-pierre-louis.bossart@linux.intel.com>
References: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 528F6F89625
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 01:40:35 +0200 (CEST)
In-Reply-To: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

We've used a standard interface for machine drivers for some time now,
there is no need for this dependency on a Skylake-specific header

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 1 -
 sound/soc/intel/boards/kbl_da7219_max98357a.c | 1 -
 sound/soc/intel/boards/kbl_da7219_max98927.c  | 1 -
 sound/soc/intel/boards/skl_hda_dsp_common.c   | 1 -
 4 files changed, 4 deletions(-)

diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index 6b677b5bcdcd..7180100a9084 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -17,7 +17,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
-#include "../skylake/skl.h"
 #include "../../codecs/rt5682.h"
 #include "../../codecs/hdac_hdmi.h"
 
diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 07491a0f8fb8..4e5db2241fb9 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -19,7 +19,6 @@
 #include <sound/soc.h>
 #include "../../codecs/da7219.h"
 #include "../../codecs/hdac_hdmi.h"
-#include "../skylake/skl.h"
 #include "../../codecs/da7219-aad.h"
 
 #define KBL_DIALOG_CODEC_DAI "da7219-hifi"
diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 1efe7fdad2cb..d6765c359449 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -19,7 +19,6 @@
 #include <sound/soc.h>
 #include "../../codecs/da7219.h"
 #include "../../codecs/hdac_hdmi.h"
-#include "../skylake/skl.h"
 #include "../../codecs/da7219-aad.h"
 
 #define KBL_DIALOG_CODEC_DAI	"da7219-hifi"
diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c b/sound/soc/intel/boards/skl_hda_dsp_common.c
index 8b68f41a5b88..82f10bf2abb2 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
@@ -12,7 +12,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "../../codecs/hdac_hdmi.h"
-#include "../skylake/skl.h"
 #include "skl_hda_dsp_common.h"
 
 #define NAME_SIZE	32
-- 
2.20.1
