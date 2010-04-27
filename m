From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 5/5] ASoC: tlv320dac33 - disable regulators at
	i2c remove()
Date: Tue, 27 Apr 2010 15:54:20 +0100
Message-ID: <1272380060-12493-5-git-send-email-lrg@slimlogic.co.uk>
References: <1272380060-12493-1-git-send-email-lrg@slimlogic.co.uk>
	<1272380060-12493-2-git-send-email-lrg@slimlogic.co.uk>
	<1272380060-12493-3-git-send-email-lrg@slimlogic.co.uk>
	<1272380060-12493-4-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 57F73243DC
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 16:55:08 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 30so599401wwg.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 07:55:08 -0700 (PDT)
In-Reply-To: <1272380060-12493-4-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/tlv320dac33.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 824bb35..eadc1f6 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1358,6 +1358,7 @@ static int __devexit dac33_i2c_remove(struct i2c_client *client)
 	if (dac33->irq >= 0)
 		free_irq(dac33->irq, &dac33->codec);
 
+	regulator_bulk_disable(ARRAY_SIZE(dac33->supplies), dac33->supplies);
 	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
 
 	destroy_workqueue(dac33->dac33_wq);
-- 
1.6.3.3
