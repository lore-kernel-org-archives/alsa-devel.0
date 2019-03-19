From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH asoc] ASoC: wm_adsp: wm_halo_ops can be
	static
Date: Tue, 19 Mar 2019 23:55:53 +0800
Message-ID: <20190319155552.GA1200@lkp-wsm-ep2>
References: <201903192324.Mauv8ezY%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 470B2F80791
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 16:56:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201903192324.Mauv8ezY%lkp@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Wen Shi <wenshi@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com, Piotr Stankiewicz <piotrs@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Stuart Henderson <stuarth@opensource.cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


Fixes: 170b1e123f38 ("ASoC: wm_adsp: Add support for new Halo core DSPs")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 wm_adsp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 644aaf1..33b39c6 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -308,7 +308,7 @@
 
 struct wm_adsp_ops wm_adsp1_ops;
 struct wm_adsp_ops wm_adsp2_ops[];
-struct wm_adsp_ops wm_halo_ops;
+static struct wm_adsp_ops wm_halo_ops;
 
 struct wm_adsp_buf {
 	struct list_head list;
