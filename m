From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2] ASoC: sgtl5000: defer the probe if clock is
	not found
Date: Tue, 16 Jul 2013 09:17:27 +0800
Message-ID: <1373937447-28722-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 69F242618EE
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 03:17:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

It's not always the case that clock is already available when sgtl5000
get probed at the first time, e.g. the clock is provided by CPU DAI
which may be probed after sgtl5000.  So let's defer the probe when
devm_clk_get() call fails and give it chance to try later.

It fixes the regression on imx28 since commit 9e13f34 (ASoC: sgtl5000:
Let the codec acquire its clock).

[    1.927637] sgtl5000 0-000a: Failed to get mclock: -2
[    1.934280] sgtl5000: probe of 0-000a failed with error -2
[    1.945906] mxs-sgtl5000 sound.13: ASoC: CODEC (null) not registered
[    1.953787] mxs-sgtl5000 sound.13: snd_soc_register_card failed (-517)
[    1.960865] platform sound.13: Driver mxs-sgtl5000 requests probe deferral

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes since v1:
* Not use ternary operator.

Mark,

I'm still not going to fix this regression during -rc at clock core
level with the risk of breaking clock API users and being yelled by
clock maintainer.

Shawn

 sound/soc/codecs/sgtl5000.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d441559..f5ec35b 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1527,6 +1527,9 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	if (IS_ERR(sgtl5000->mclk)) {
 		ret = PTR_ERR(sgtl5000->mclk);
 		dev_err(&client->dev, "Failed to get mclock: %d\n", ret);
+		/* Defer the probe to see if the clk will be provided later */
+		if (ret == -ENOENT)
+			return -EPROBE_DEFER;
 		return ret;
 	}
 
-- 
1.7.9.5
