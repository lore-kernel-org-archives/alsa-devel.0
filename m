From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt298: remove meanless pr_info
Date: Thu, 16 Jul 2015 10:01:33 +0800
Message-ID: <1437012093-6133-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 53F5B260506
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 04:01:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, ramesh.babu@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This line doesn't include any information. So, remove it.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 7c4bcb6..6ff68a3 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1144,8 +1144,6 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 	const struct acpi_device_id *acpiid;
 	int i, ret;
 
-	pr_info("%s\n", __func__);
-
 	rt298 = devm_kzalloc(&i2c->dev,	sizeof(*rt298),
 				GFP_KERNEL);
 	if (NULL == rt298)
-- 
1.8.1.1.439.g50a6b54
