From: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Subject: [PATCH] ASoC: Intel: Skylake: fix invalid memory access due to wrong reference of pointer
Date: Fri, 24 Feb 2017 11:48:41 +0900
Message-ID: <20170224024841.10515-1-takashi.sakamoto@miraclelinux.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: broonie@kernel.org, jeeja.kp@intel.com, shreyas.nc@intel.com
Cc: alsa-devel@alsa-project.org, ichiro.suzuki@miraclelinux.com, yukie.kato@miraclelinux.com, hirotaka.furukawa@miraclelinux.com, ryotaro.shibata@miraclelinux.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, "# v4 . 5+" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

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

Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: <stable@vger.kernel.org> # v4.5+
Fixes: abb740033b56 ("ASoC: Intel: Skylake: Add support to configure module params")
Signed-off-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ed58b5b..2dbfb1b 100644
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
2.9.3
