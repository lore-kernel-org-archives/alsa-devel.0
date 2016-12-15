From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: remove unused 'err'" to the
	asoc tree
Date: Thu, 15 Dec 2016 12:21:47 +0000
Message-ID: <E1cHV2h-0000uv-Ag@debutante>
References: <1481218297-17568-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3751101548966539681=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 653E7266A53
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 13:21:53 +0100 (CET)
In-Reply-To: <1481218297-17568-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

--===============3751101548966539681==
Content-Type: text/plain

The patch

   ASoC: topology: remove unused 'err'

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

>From fd34045567991dc77a50163c5d0e465b423df962 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 8 Dec 2016 23:01:27 +0530
Subject: [PATCH] ASoC: topology: remove unused 'err'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In soc_tplg_pcm_elems_load, a variable 'err' is initialized but not
used.

It is assigned return values for pcm_new_ver() but never checked, so
remove it.

sound/soc/soc-topology.c: In function ‘soc_tplg_pcm_elems_load’:
sound/soc/soc-topology.c:1865:9: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]
  int i, err;

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 65670b2b408c..585b88b45f7b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1863,7 +1863,7 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 {
 	struct snd_soc_tplg_pcm *pcm, *_pcm;
 	int count = hdr->count;
-	int i, err;
+	int i;
 	bool abi_match;
 
 	if (tplg->pass != SOC_TPLG_PASS_PCM_DAI)
@@ -1897,7 +1897,7 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 			_pcm = pcm;
 		} else {
 			abi_match = false;
-			err = pcm_new_ver(tplg, pcm, &_pcm);
+			pcm_new_ver(tplg, pcm, &_pcm);
 		}
 
 		/* create the FE DAIs and DAI links */
-- 
2.11.0


--===============3751101548966539681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3751101548966539681==--
