From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 13/13] ASoC: wm_adsp: Warn that firmware file
	format 0 is depreciated
Date: Mon, 13 Apr 2015 13:28:05 +0100
Message-ID: <1428928085-20250-14-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DAF1326508D
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:14 +0200 (CEST)
In-Reply-To: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

There are very few version 0 firmwares in the wild and at some point in
the future it would be nice to remove support for them from the driver,
as they require several work arounds to be present to create controls
properly.

This patch adds a depreciated warning if someone is using this file
format.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a5dd22e..173f332 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -935,6 +935,9 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 
 	switch (header->ver) {
 	case 0:
+		adsp_warn(dsp, "%s: Depreciated file format %d\n",
+			  file, header->ver);
+		break;
 	case 1:
 	case 2:
 		break;
-- 
1.7.2.5
