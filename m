From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: [PATCH] davinci: da8xx/omap-l1xx: match codec_name
	with i2c ids
Date: Fri, 21 Jan 2011 19:54:56 +0530
Message-ID: <1295619896-5498-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 12FCF24612
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 15:26:48 +0100 (CET)
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
Cc: khilman@ti.com, davinci-linux-open-source@linux.davincidsp.com, dansharon@nanometrics.ca, "Rajashekhara,
	Sudhakar" <sudhakar.raj@ti.com>, stable@kernel.org, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The codec_name entry for da8xx evm in sound/soc/davinci/davinci-evm.c
is not matching with the i2c ids in the board file. Without this fix the
soundcard does not get detected on da850/omap-l138/am18x evm.

Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
Tested-by: Dan Sharon <dansharon@nanometrics.ca>
---
This patch applies to Linus's kernel tree.

 sound/soc/davinci/davinci-evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 0c2d6ba..b36f0b3 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -223,7 +223,7 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
 	.stream_name = "AIC3X",
 	.cpu_dai_name= "davinci-mcasp.0",
 	.codec_dai_name = "tlv320aic3x-hifi",
-	.codec_name = "tlv320aic3x-codec.0-001a",
+	.codec_name = "tlv320aic3x-codec.1-0018",
 	.platform_name = "davinci-pcm-audio",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
-- 
1.7.1
