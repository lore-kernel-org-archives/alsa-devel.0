From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 1/4] ASoC: fix a simple coding style issue
Date: Wed, 20 Apr 2011 16:00:36 +0800
Message-ID: <20110420080036.11377.44041.stgit@localhost>
References: <20110420075859.11377.67437.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 141461038E1
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 09:59:48 +0200 (CEST)
In-Reply-To: <20110420075859.11377.67437.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2ee738c..2fa2442 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1597,7 +1597,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	}
 
 	/* connect dynamic paths */
-	switch(wsink->id) {
+	switch (wsink->id) {
 	case snd_soc_dapm_adc:
 	case snd_soc_dapm_dac:
 	case snd_soc_dapm_pga:
