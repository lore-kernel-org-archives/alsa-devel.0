From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/4] ASoC: wm2000: Delete an error message for
 a failed memory allocation in wm2000_i2c_probe()
Date: Fri, 24 Nov 2017 08:36:17 +0100
Message-ID: <87078639-7ec0-c3cc-5399-5607f2329c63@users.sourceforge.net>
References: <cd76c876-81a5-3cf6-e7d9-52037729fb98@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id A092D266A74
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 08:36:58 +0100 (CET)
In-Reply-To: <cd76c876-81a5-3cf6-e7d9-52037729fb98@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 22:28:00 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/codecs/wm2000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 23cde3a0dc11..ce936deed7e3 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -902,7 +902,6 @@ static int wm2000_i2c_probe(struct i2c_client *i2c,
 					    wm2000->anc_download_size,
 					    GFP_KERNEL);
 	if (wm2000->anc_download == NULL) {
-		dev_err(&i2c->dev, "Out of memory\n");
 		ret = -ENOMEM;
 		goto err_supplies;
 	}
-- 
2.15.0
