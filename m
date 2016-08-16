From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Fix leak of a widget list in
	soc_compr_open_fe" to the asoc tree
Date: Tue, 16 Aug 2016 12:30:14 +0100
Message-ID: <E1bZcZS-0004iq-UG@debutante>
References: <1471343086-11383-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B65B2666BD
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 13:30:25 +0200 (CEST)
In-Reply-To: <1471343086-11383-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Fix leak of a widget list in soc_compr_open_fe

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b0f12c61de013ecb0abe19d5e64bdab45989de5a Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 16 Aug 2016 11:24:46 +0100
Subject: [PATCH] ASoC: compress: Fix leak of a widget list in
 soc_compr_open_fe

After we have called dpcm_path_get we should make sure to call
dpcm_path_put on all error paths. This was not happening causing the
allocated widget list to be leaked, this patch corrects this by adding a
dpcm_path_put to the error path.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index d2df46c14c68..bf7b52fce597 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -121,7 +121,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 
 		dpcm_be_disconnect(fe, stream);
 		fe->dpcm[stream].runtime = NULL;
-		goto fe_err;
+		goto path_err;
 	}
 
 	dpcm_clear_pending_state(fe, stream);
@@ -136,6 +136,8 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 
 	return 0;
 
+path_err:
+	dpcm_path_put(&list);
 fe_err:
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->shutdown)
 		fe->dai_link->compr_ops->shutdown(cstream);
-- 
2.8.1
