From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: use kmemdup rather than
	duplicating its implementation" to the asoc tree
Date: Fri, 07 Aug 2015 13:30:08 +0100
Message-ID: <E1ZNgmm-00024L-7G@finisterre>
References: <1438934377-4922-32-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8859C26041D
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 14:30:18 +0200 (CEST)
In-Reply-To: <1438934377-4922-32-git-send-email-a.hajda@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrzej Hajda <a.hajda@samsung.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: use kmemdup rather than duplicating its implementation

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

>From 376c0afe2f0047d091956a95e382e1edd104ea72 Mon Sep 17 00:00:00 2001
From: Andrzej Hajda <a.hajda@samsung.com>
Date: Fri, 7 Aug 2015 09:59:37 +0200
Subject: [PATCH] ASoC: topology: use kmemdup rather than duplicating its
 implementation

The patch was generated using fixed coccinelle semantic patch
scripts/coccinelle/api/memdup.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2014320

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index f038c6e..8620dbf 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -832,12 +832,12 @@ static int soc_tplg_denum_create_values(struct soc_enum *se,
 	if (ec->items > sizeof(*ec->values))
 		return -EINVAL;
 
-	se->dobj.control.dvalues =
-		kmalloc(ec->items * sizeof(u32), GFP_KERNEL);
+	se->dobj.control.dvalues = kmemdup(ec->values,
+					   ec->items * sizeof(u32),
+					   GFP_KERNEL);
 	if (!se->dobj.control.dvalues)
 		return -ENOMEM;
 
-	memcpy(se->dobj.control.dvalues, ec->values, ec->items * sizeof(u32));
 	return 0;
 }
 
-- 
2.5.0
