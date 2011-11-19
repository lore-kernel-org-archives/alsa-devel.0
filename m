From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: cs42l73: Return proper error code if
 device id mismatch
Date: Sat, 19 Nov 2011 10:15:53 +0800
Message-ID: <1321668953.9341.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3185B244F2
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2011 03:16:09 +0100 (CET)
Received: by yenr9 with SMTP id r9so1207238yen.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 18:16:06 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

Return -ENODEV instead of 0 if device id mismatch.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs42l73.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index aadfd6b..3eed21e 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1370,6 +1370,7 @@ static __devinit int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 
 
 	if (devid != CS42L73_DEVID) {
+		ret = -ENODEV;
 		dev_err(&i2c_client->dev,
 			"CS42L73 Device ID (%X). Expected %X\n",
 			devid, CS42L73_DEVID);
-- 
1.7.5.4
