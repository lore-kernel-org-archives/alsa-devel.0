From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Make use of local variables"
	to the asoc tree
Date: Wed,  3 Apr 2019 05:41:27 +0100 (BST)
Message-ID: <20190403044127.70AE4440083@finisterre.ee.mobilebroadband>
References: <20190402124916.28736-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8301DF8970A
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 06:41:32 +0200 (CEST)
In-Reply-To: <20190402124916.28736-3-ckeepax@opensource.cirrus.com>
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Make use of local variables

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

>From 789b930a8f0de609fd2ef9f2ebf73726b7087fea Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 2 Apr 2019 13:49:16 +0100
Subject: [PATCH] ASoC: wm_adsp: Make use of local variables

Tidy up some instances of dereferencing to obtain things that are
already stored in local variables.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 6145260d89bf..4662a20cfb92 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3381,7 +3381,7 @@ static int wm_adsp_compr_attach(struct wm_adsp_compr *compr)
 		return -EINVAL;
 
 	compr->buf = buf;
-	compr->buf->compr = compr;
+	buf->compr = compr;
 
 	return 0;
 }
@@ -4091,7 +4091,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 
 	buf = compr->buf;
 
-	if (!compr->buf || compr->buf->error) {
+	if (!buf || buf->error) {
 		snd_compr_stop_error(stream, SNDRV_PCM_STATE_XRUN);
 		ret = -EIO;
 		goto out;
@@ -4111,7 +4111,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 		if (buf->avail < wm_adsp_compr_frag_words(compr)) {
 			ret = wm_adsp_buffer_get_error(buf);
 			if (ret < 0) {
-				if (compr->buf->error)
+				if (buf->error)
 					snd_compr_stop_error(stream,
 							SNDRV_PCM_STATE_XRUN);
 				goto out;
-- 
2.20.1
