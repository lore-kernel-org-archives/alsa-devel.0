From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Potential small memory leak in
	dapm_cnew_widget()" to the asoc tree
Date: Tue, 19 Feb 2019 15:50:22 +0000 (GMT)
Message-ID: <20190219155022.A1E3211284C2@debutante.sirena.org.uk>
References: <20190219120427.GA26719@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7778EF807A3
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 12:13:53 +0100 (CET)
In-Reply-To: <20190219120427.GA26719@kadam>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Potential small memory leak in dapm_cnew_widget()

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

>From a6d9cef30eb11b2de8cbfed9065e3dc5b1f829a8 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 19 Feb 2019 15:04:27 +0300
Subject: [PATCH] ASoC: dapm: Potential small memory leak in dapm_cnew_widget()

We should free "w" on the error path.

Fixes: 199ed3e81c49 ("ASoC: dapm: fix use-after-free issue with dailink sname")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dea6fc2353e4..1ec06ef6d161 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -332,8 +332,10 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	 */
 	if (_widget->sname) {
 		w->sname = kstrdup_const(_widget->sname, GFP_KERNEL);
-		if (!w->sname)
+		if (!w->sname) {
+			kfree(w);
 			return NULL;
+		}
 	}
 	return w;
 }
-- 
2.20.1
