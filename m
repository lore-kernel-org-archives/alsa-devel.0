From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: Ux500: unlock on an error path
Date: Sat, 16 Jun 2012 16:19:27 +0300
Message-ID: <20120616131927.GB17980@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 29862243E3
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2012 15:19:52 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is a missing mutex_unlock() here.  The cleanup path also has more
debug output.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 389dd66..3c79592 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -1235,7 +1235,8 @@ static int anc_status_control_put(struct snd_kcontrol *kcontrol,
 		req != ANC_APPLY_IIR) {
 		dev_err(dev, "%s: ERROR: Unsupported status to set '%s'!\n",
 			__func__, enum_anc_state[req]);
-		return -EINVAL;
+		status = -EINVAL;
+		goto cleanup;
 	}
 	apply_fir = req == ANC_APPLY_FIR || req == ANC_APPLY_FIR_IIR;
 	apply_iir = req == ANC_APPLY_IIR || req == ANC_APPLY_FIR_IIR;
