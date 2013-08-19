From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: bt-sco: Add generic compatible string
Date: Mon, 19 Aug 2013 12:16:49 +0100
Message-ID: <1376911010-16215-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D67D261A53
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 13:16:55 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Provide a common compatible string for device trees to list as a fallback
for simplicity. We don't currently have a binding document but let's not
fix that right now...

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/bt-sco.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index a081d9f..5c040ce 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -50,6 +50,9 @@ static struct platform_device_id bt_sco_driver_ids[] = {
 	{
 		.name		= "dfbmcs320",
 	},
+	{
+		.name		= "bt-sco",
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(platform, bt_sco_driver_ids);
-- 
1.8.4.rc3
