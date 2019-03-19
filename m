From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Correct error messages in
	wm_adsp_buffer_get_error" to the asoc tree
Date: Tue, 19 Mar 2019 13:13:21 +0000 (GMT)
Message-ID: <20190319131321.DB73211288E0@debutante.sirena.org.uk>
References: <20190319115215.22960-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10942F89714
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 14:13:23 +0100 (CET)
In-Reply-To: <20190319115215.22960-3-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Correct error messages in wm_adsp_buffer_get_error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 48ead31ce247dc8c0b01ad99d1a97da35421493b Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 19 Mar 2019 11:52:05 +0000
Subject: [PATCH] ASoC: wm_adsp: Correct error messages in
 wm_adsp_buffer_get_error

During recent logging improvements it seems two error messages lost
their updates during patch application/rebasing. Add these back in.

Fixes: 0d3fba3e7a56 ("ASoC: wm_adsp: Improve logging messages")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 0de36b7eeeb2..b3348a213c18 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3535,11 +3535,11 @@ static int wm_adsp_buffer_get_error(struct wm_adsp_compr_buf *buf)
 
 	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(error), &buf->error);
 	if (ret < 0) {
-		adsp_err(buf->dsp, "Failed to check buffer error: %d\n", ret);
+		compr_err(buf, "Failed to check buffer error: %d\n", ret);
 		return ret;
 	}
 	if (buf->error != 0) {
-		adsp_err(buf->dsp, "Buffer error occurred: %d\n", buf->error);
+		compr_err(buf, "Buffer error occurred: %d\n", buf->error);
 		return -EIO;
 	}
 
-- 
2.20.1
