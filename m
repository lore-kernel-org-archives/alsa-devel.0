From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: fix getting wrong work handler
	container" to the asoc tree
Date: Wed, 08 Mar 2017 14:23:21 +0100
Message-ID: <E1clbYn-0000Mq-2N@finisterre>
References: <1488970990-18967-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EAAED267258
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 14:24:31 +0100 (CET)
In-Reply-To: <1488970990-18967-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, stable@vger.kernel.org, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: fix getting wrong work handler container

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

>From f1994a9c0930de4b2244816e62120cad08283cdc Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 8 Mar 2017 19:03:10 +0800
Subject: [PATCH] ASoC: rt5665: fix getting wrong work handler container

We got rt5665 private data from wrong work. It will result in kernel
panic.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/rt5665.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 324461e985b3..fe2cf1ed8237 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1241,7 +1241,7 @@ static irqreturn_t rt5665_irq(int irq, void *data)
 static void rt5665_jd_check_handler(struct work_struct *work)
 {
 	struct rt5665_priv *rt5665 = container_of(work, struct rt5665_priv,
-		calibrate_work.work);
+		jd_check_work.work);
 
 	if (snd_soc_read(rt5665->codec, RT5665_AJD1_CTRL) & 0x0010) {
 		/* jack out */
-- 
2.11.0
