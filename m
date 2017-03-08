From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH for-4.11] ASoC: don't dereference NULL pcm_{new,free}
Date: Wed,  8 Mar 2017 15:18:54 -0800
Message-ID: <20170308231854.50167-1-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Brian Norris <briannorris@chromium.org>
List-Id: alsa-devel@alsa-project.org

Not all platform drivers have pcm_{new,free} callbacks. Seen with a
"snd-soc-dummy" codec from sound/soc/rockchip/rk3399_gru_sound.c.

Resolves an OOPS seen on v4.11-rc1 with Google Kevin (Samsung Chromebook
Plus):

[    2.863304] rk3399-gru-sound sound: HiFi <-> ff880000.i2s mapping ok
[    2.886930] rk3399-gru-sound sound: rt5514-aif1 <-> ff880000.i2s mapping ok
[    2.912496] rk3399-gru-sound sound: da7219-hifi <-> ff880000.i2s mapping ok
[    2.936157] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    2.945221] pgd = ffffff8008f65000
[    2.949040] [00000000] *pgd=00000000f7dfe003, *pud=00000000f7dfe003, *pmd=0000000000000000
[    2.958307] Internal error: Oops: 86000005 [#1] PREEMPT SMP
[    2.964532] Modules linked in:
[    2.967945] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.11.0-rc1+ #941
[    2.976597] Hardware name: Google Kevin (DT)
[    2.981364] task: ffffffc0f1cd0000 task.stack: ffffffc0f1ccc000
[    2.987978] PC is at 0x0
[    2.990806] LR is at snd_soc_platform_drv_pcm_new+0x74/0x84
[    2.997030] pc : [<0000000000000000>] lr : [<ffffff80086298f4>] pstate: 60000145
[    3.005293] sp : ffffffc0f1ccf9a0
...
[    3.657268] [<          (null)>]           (null)
[    3.662523] [<ffffff8008638a48>] soc_new_pcm+0x3b8/0x458
[    3.668457] [<ffffff800862c1f4>] snd_soc_register_card+0x900/0xd40
[    3.675361] [<ffffff8008639288>] devm_snd_soc_register_card+0x5c/0x98
[    3.682559] [<ffffff8008645a7c>] rockchip_sound_probe+0x1b0/0x1f4
[    3.689369] [<ffffff800846c55c>] platform_drv_probe+0x60/0xac
[    3.695789] [<ffffff800846a2cc>] driver_probe_device+0x14c/0x2d0
[    3.702499] [<ffffff800846a4d4>] __driver_attach+0x84/0xb0
[    3.708628] [<ffffff8008469158>] bus_for_each_dev+0x9c/0xcc
[    3.714853] [<ffffff8008469ca0>] driver_attach+0x2c/0x34
[    3.720786] [<ffffff8008469800>] bus_add_driver+0xf0/0x1f4
[    3.726914] [<ffffff800846b230>] driver_register+0x9c/0xe8
[    3.733042] [<ffffff800846c4a0>] __platform_driver_register+0x60/0x6c
[    3.740241] [<ffffff8008c3a720>] rockchip_sound_driver_init+0x18/0x20
[    3.747438] [<ffffff8008083204>] do_one_initcall+0xa0/0x138
[    3.753666] [<ffffff8008c00d70>] kernel_init_freeable+0x1ac/0x264
[    3.760474] [<ffffff8008783914>] kernel_init+0x18/0x100
[    3.766310] [<ffffff8008082ec0>] ret_from_fork+0x10/0x50
[    3.772246] Code: bad PC value
[    3.775704] ---[ end trace f68728a0d3053b53 ]---
[    3.787286] Kernel panic - not syncing: Fatal exception
[    3.793126] SMP: stopping secondary CPUs
[    3.797508] Kernel Offset: disabled
[    3.801400] Memory Limit: none

Fixes: 99b04f4c4051 ("ASoC: add Component level pcm_new/pcm_free")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
I'm really not that familiar with this subsystem... but this does fix the
crash seen here.

 sound/soc/soc-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6dca408faae3..2722bb0c5573 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3326,7 +3326,10 @@ static int snd_soc_platform_drv_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_platform *platform = rtd->platform;
 
-	return platform->driver->pcm_new(rtd);
+	if (platform->driver->pcm_new)
+		return platform->driver->pcm_new(rtd);
+	else
+		return 0;
 }
 
 static void snd_soc_platform_drv_pcm_free(struct snd_pcm *pcm)
@@ -3334,7 +3337,8 @@ static void snd_soc_platform_drv_pcm_free(struct snd_pcm *pcm)
 	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 
-	platform->driver->pcm_free(pcm);
+	if (platform->driver->pcm_free)
+		platform->driver->pcm_free(pcm);
 }
 
 /**
-- 
2.12.0.246.ga2ecc84866-goog
