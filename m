From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Change RT wq to
	singlethread wq
Date: Thu, 26 Nov 2009 13:55:11 +0200
Message-ID: <1259236511-25805-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 101C2243E9
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 12:56:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, sfr@canb.auug.org.au
Cc: tj@kernel.org, tiwai@suse.de, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

RT workqueue is going away in the near future, replace it with
singlethread wq for now, which is still supported.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

Hello,

I believe this patch fixes the linux-next breakage (in the tlv320dac33 codec
driver) caused by the removal of the RT workqueue in the wq tree.

 sound/soc/codecs/tlv320dac33.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 2a013e4..9c8903d 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1118,7 +1118,8 @@ static int dac33_i2c_probe(struct i2c_client *client,
 		}
 		if (dac33->irq != -1) {
 			/* Setup work queue */
-			dac33->dac33_wq = create_rt_workqueue("tlv320dac33");
+			dac33->dac33_wq =
+				create_singlethread_workqueue("tlv320dac33");
 			if (dac33->dac33_wq == NULL) {
 				free_irq(dac33->irq, &dac33->codec);
 				ret = -ENOMEM;
--
1.6.5.3
