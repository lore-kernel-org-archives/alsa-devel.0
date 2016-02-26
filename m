From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: silence and array overflow
	warning" to the asoc tree
Date: Fri, 26 Feb 2016 11:47:00 +0900
Message-ID: <E1aZ8Qm-0006Lj-15@finisterre>
References: <20160225075038.GC7333@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E3226265148
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 03:47:04 +0100 (CET)
In-Reply-To: <20160225075038.GC7333@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: silence and array overflow warning

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

>From 90966391005e69a8964350278917a87fe49adf0f Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 25 Feb 2016 10:50:38 +0300
Subject: [PATCH] ASoC: max9867: silence and array overflow warning

Smatch complains that we might reach the end of this loop without
finding what we're looking for leading to a buffer overflow.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index f371a52fe29d..2a22fddeb6af 100755
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -156,6 +156,8 @@ static inline int get_ni_value(int mclk, int rate)
 		if (ni_div[i].mclk >= mclk)
 			break;
 	}
+	if (i == ARRAY_SIZE(ni_div))
+		return -EINVAL;
 
 	switch (rate) {
 	case 8000:
-- 
2.7.0
