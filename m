From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH asoc] ASoC: wm_adsp: wm_adsp1_ops can be
	static
Date: Tue, 19 Mar 2019 23:00:06 +0800
Message-ID: <20190319150006.GA15014@lkp-wsm-ep2>
References: <201903192200.16nwKI4j%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05328F80791
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 16:00:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201903192200.16nwKI4j%lkp@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Wen Shi <wenshi@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Stuart Henderson <stuarth@opensource.cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


Fixes: 4e08d50d1fb6 ("ASoC: wm_adsp: Factor out DSP specific operations")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 wm_adsp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 644aaf1..2a9554d 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -306,8 +306,8 @@
 #define HALO_MPU_VIO_ERR_SRC_MASK           0x00007fff
 #define HALO_MPU_VIO_ERR_SRC_SHIFT                   0
 
-struct wm_adsp_ops wm_adsp1_ops;
-struct wm_adsp_ops wm_adsp2_ops[];
+static struct wm_adsp_ops wm_adsp1_ops;
+static struct wm_adsp_ops wm_adsp2_ops[];
 struct wm_adsp_ops wm_halo_ops;
 
 struct wm_adsp_buf {
