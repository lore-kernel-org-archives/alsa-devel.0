From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Fix to store enum text
	values" to the asoc tree
Date: Tue, 11 Apr 2017 19:37:29 +0100
Message-ID: <E1cy0fR-00048u-OO@debutante>
References: <1491896182-14199-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CC9A266D8D
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 20:37:44 +0200 (CEST)
In-Reply-To: <1491896182-14199-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mousumi Jana <mousumix.jana@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, tiwai@suse.de, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, lgirdwood@gmail.com, "Kranthikumar, , GudishaX" <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Fix to store enum text values

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

>From b6e38b2944f1153199becefb14ae3ee01778863e Mon Sep 17 00:00:00 2001
From: Mousumi Jana <mousumix.jana@intel.com>
Date: Tue, 11 Apr 2017 13:06:22 +0530
Subject: [PATCH] ASoC: topology: Fix to store enum text values

Add missing enum texts store in soc_enum.

Signed-off-by: Mousumi Jana <mousumix.jana@intel.com>
Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Kranthikumar, GudishaX <gudishax.kranthikumar@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 65670b2b408c..8e3df8ba9b68 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -934,6 +934,7 @@ static int soc_tplg_denum_create_texts(struct soc_enum *se,
 		}
 	}
 
+	se->texts = (const char * const *)se->dobj.control.dtexts;
 	return 0;
 
 err:
-- 
2.11.0
