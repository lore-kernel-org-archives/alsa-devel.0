From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 2/4] ASoC: remove unused comment
Date: Wed, 20 Apr 2011 16:00:42 +0800
Message-ID: <20110420080042.11377.98550.stgit@localhost>
References: <20110420075859.11377.67437.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 06CD81038DF
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

`type` parameter is not longer used in `snd_soc_codec_set_cache_io`,
so remove this line.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/soc-cache.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index f46a198..a217db2 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -484,7 +484,6 @@ static struct {
  * snd_soc_codec_set_cache_io: Set up standard I/O functions.
  *
  * @codec: CODEC to configure.
- * @type: Type of cache.
  * @addr_bits: Number of bits of register address data.
  * @data_bits: Number of bits of data per register.
  * @control: Control bus used.
