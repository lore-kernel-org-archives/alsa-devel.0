From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: cs35l35: Add IRQF_SHARED to IRQ flags
Date: Wed, 8 Mar 2017 16:42:51 +0000
Message-ID: <1488991371-22513-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1488991371-22513-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 938BF266FF0
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 17:42:26 +0100 (CET)
In-Reply-To: <1488991371-22513-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

As it is quite common to use a stereo pair of amps but share the IRQ
line between them both add the IRQF_SHARED flag whilst requesting
cs35l35's IRQ.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs35l35.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 99bcdb9..7c4d74e 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1427,8 +1427,8 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 	init_completion(&cs35l35->pdn_done);
 
 	ret = devm_request_threaded_irq(dev, i2c_client->irq, NULL, cs35l35_irq,
-					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-					"cs35l35", cs35l35);
+					IRQF_ONESHOT | IRQF_TRIGGER_LOW |
+					IRQF_SHARED, "cs35l35", cs35l35);
 	if (ret != 0) {
 		dev_err(dev, "Failed to request IRQ: %d\n", ret);
 		goto err;
-- 
2.1.4
