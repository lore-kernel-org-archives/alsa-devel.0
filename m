From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: wm0010: unlock on error path
Date: Wed, 5 Sep 2012 15:29:46 +0300
Message-ID: <20120905122946.GA6128@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BA76265346
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 14:30:00 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, kernel-janitors@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

We're holding the wm0010->lock mutex when we goto err_core.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This driver is only in linux-next.

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 5f99148..1c052d6 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -663,7 +663,9 @@ abort:
 	wm0010_halt(codec);
 	mutex_unlock(&wm0010->lock);
 	return ret;
+
 err_core:
+	mutex_unlock(&wm0010->lock);
 	regulator_bulk_disable(ARRAY_SIZE(wm0010->core_supplies),
 			       wm0010->core_supplies);
 err:
