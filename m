From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ASoC: blackfin: Delete an error message
 for a failed memory allocation in sport_create()
Date: Fri, 11 Aug 2017 22:41:23 +0200
Message-ID: <d3eaf797-a4a3-f4ff-c368-3961b4e16fb1@users.sourceforge.net>
References: <e1ef440e-ed53-92f8-c30c-37c0b42cb351@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 70686266D12
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 22:41:31 +0200 (CEST)
In-Reply-To: <e1ef440e-ed53-92f8-c30c-37c0b42cb351@users.sourceforge.net>
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
To: adi-buildroot-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Scott Jiang <scott.jiang.linux@gmail.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Aug 2017 21:45:37 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/blackfin/bf6xx-sport.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/blackfin/bf6xx-sport.c b/sound/soc/blackfin/bf6xx-sport.c
index dfb744381c42..1bc3e0a47a57 100644
--- a/sound/soc/blackfin/bf6xx-sport.c
+++ b/sound/soc/blackfin/bf6xx-sport.c
@@ -388,10 +388,9 @@ struct sport_device *sport_create(struct platform_device *pdev)
 	int ret;
 
 	sport = kzalloc(sizeof(*sport), GFP_KERNEL);
-	if (!sport) {
-		dev_err(dev, "Unable to allocate memory for sport device\n");
+	if (!sport)
 		return NULL;
-	}
+
 	sport->pdev = pdev;
 
 	ret = sport_get_resource(sport);
-- 
2.14.0
