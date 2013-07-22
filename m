From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: core: double free in
	snd_soc_add_platform()
Date: Mon, 22 Jul 2013 09:56:54 +0300
Message-ID: <20130722065654.GC14617@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E7AF261737
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 08:59:32 +0200 (CEST)
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
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org

There are three callers for this function, and none of them want it to
free platform for them.  It leads to a double free.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0ec070c..d82ee38 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3908,10 +3908,8 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 {
 	/* create platform component name */
 	platform->name = fmt_single_name(dev, &platform->id);
-	if (platform->name == NULL) {
-		kfree(platform);
+	if (platform->name == NULL)
 		return -ENOMEM;
-	}
 
 	platform->dev = dev;
 	platform->driver = platform_drv;
