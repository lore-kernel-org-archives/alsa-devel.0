From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: fix invalid memory
	access due to wrong reference of pointer" to the asoc tree
Date: Tue, 07 Mar 2017 15:21:26 +0100
Message-ID: <E1clFzS-0006dg-A7@finisterre>
References: <20170224024841.10515-1-takashi.sakamoto@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 237E0266EEB
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 15:21:41 +0100 (CET)
In-Reply-To: <20170224024841.10515-1-takashi.sakamoto@miraclelinux.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Cc: alsa-devel@alsa-project.org, hirotaka.furukawa@miraclelinux.com, Vinod Koul <vinod.koul@intel.com>, ichiro.suzuki@miraclelinux.com, ryotaro.shibata@miraclelinux.com, stable@vger.kernel.org, broonie@kernel.org, shreyas.nc@intel.com, jeeja.kp@intel.com, ",
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, yukie.kato@miraclelinux.com,
 alsa-devel@alsa-project.org"@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: fix invalid memory access due to wrong reference of pointer

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

>From d1a6fe41d3c4ff0d26f0b186d774493555ca5282 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Date: Fri, 24 Feb 2017 11:48:41 +0900
Subject: [PATCH] ASoC: Intel: Skylake: fix invalid memory access due to wrong
 reference of pointer

In 'skl_tplg_set_module_init_data()', a pointer to 'params' member of
'struct skl_algo_data' is calculated, then casted to (u32 *) and assigned
to a member of configuration data. The configuration data is passed to the
other functions and used to process intel IPC. In this processing, the
value of member is used to get message data, however this can bring invalid
memory access in 'skl_set_module_params()' as a result of calculation of
a pointer for actual message data.

(sound/soc/intel/skylake/skl-topology.c)
skl_tplg_init_pipe_modules()
->skl_tplg_set_module_init_data() (has this bug)
->skl_tplg_set_module_params()
  (sound/soc/intel/skylake/skl-messages.c)
  ->skl_set_module_params()
    ((char *)param) + data_offset

This commit fixes the bug.

Fixes: abb740033b56 ("ASoC: Intel: Skylake: Add support to configure module params")
Signed-off-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # v4.5+
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ed58b5b3555a..2dbfb1b24ef4 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -512,7 +512,7 @@ static int skl_tplg_set_module_init_data(struct snd_soc_dapm_widget *w)
 			if (bc->set_params != SKL_PARAM_INIT)
 				continue;
 
-			mconfig->formats_config.caps = (u32 *)&bc->params;
+			mconfig->formats_config.caps = (u32 *)bc->params;
 			mconfig->formats_config.caps_size = bc->size;
 
 			break;
-- 
2.11.0
