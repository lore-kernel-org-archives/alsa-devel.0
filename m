From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V2] ASoC: core: Don't probe the component which
	is dummy
Date: Fri, 3 Jul 2015 16:30:30 +0800
Message-ID: <127af50a5e5f16ff9c98dbe6da04a55a58d72f44.1435912028.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0112.outbound.protection.outlook.com [65.55.169.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 83B3D260476
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 10:31:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dummy dai can be used by multiple sound card. But it only belong to one
card's dapm list. If another card use it, there will be dapm_assert_locked
warning.

[   20.015782] WARNING: CPU: 1 PID: 661 at sound/soc/soc-dapm.c:124 dapm_assert_locked.isra.36+0x4c/0x58()
[   20.025249] Modules linked in:
[   20.028349] CPU: 1 PID: 661 Comm: aplay Not tainted 4.1.0-rc6-next-20150605-00004-gaee05d8-dirty #92
[   20.037528] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   20.044110] Backtrace:
[   20.046614] [<80012e00>] (dump_backtrace) from [<80012fa0>] (show_stack+0x18/0x1c)
[   20.054229]  r6:809e8060 r5:00000000 r4:00000000 r3:00000000
[   20.060002] [<80012f88>] (show_stack) from [<807a0f74>] (dump_stack+0x80/0x9c)
[   20.067293] [<807a0ef4>] (dump_stack) from [<8002b144>] (warn_slowpath_common+0x7c/0xb4)
[   20.075427]  r5:0000007c r4:00000000
[   20.079065] [<8002b0c8>] (warn_slowpath_common) from [<8002b1a0>] (warn_slowpath_null+0x24/0x2c)
[   20.087898]  r8:00000001 r7:88007c28 r6:ed94a680 r5:809e83e4 r4:ed83d6c0
[   20.094747] [<8002b17c>] (warn_slowpath_null) from [<8058403c>] (dapm_assert_locked.isra.36+0x4c/0x58)
[   20.104101] [<80583ff0>] (dapm_assert_locked.isra.36) from [<805842ec>] (dapm_mark_dirty+0x64/0xa4)
[   20.113165] [<80584288>] (dapm_mark_dirty) from [<805853a8>] (soc_dapm_dai_stream_event.isra.42+0x30/0xc8)
[   20.122863]  r8:ed9b5dbc r7:00000000 r6:00000001 r5:00000001 r4:ed83d6c0
[   20.129706] [<80585378>] (soc_dapm_dai_stream_event.isra.42) from [<80587e28>] (snd_soc_dapm_stream_event+0x78/0xa0)
[   20.140264]  r5:ee2ee62c r4:00000001
[   20.143918] [<80587db0>] (snd_soc_dapm_stream_event) from [<8058957c>] (soc_pcm_prepare+0x138/0x21c)
[   20.153058]  r8:ed8d9480 r7:00000000 r6:ed9b0e00 r5:00000001 r4:ee2ee62c r3:00000000
...

This patch is to not probe the dummy component in soc_probe_component. Then
there is no widget created for dummy DAI, and also don't need to check the
dummy dai in dapm_connect_dai_link_widgets().

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
changes in v2
- don't probe the component which is dummy
- remove the dummy check in dapm_connect_dai_link_widgets().

 sound/soc/soc-core.c |    2 +-
 sound/soc/soc-dapm.c |    5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3a4a5c0..6ce6217 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1102,7 +1102,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 	struct snd_soc_dai *dai;
 	int ret;
 
-	if (component->probed)
+	if (!strcmp(component->name, "snd-soc-dummy") || component->probed)
 		return 0;
 
 	component->card = card;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index aa327c9..37ab6b9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3820,11 +3820,6 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 	for (i = 0; i < rtd->num_codecs; i++) {
 		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
 
-		/* there is no point in connecting BE DAI links with dummies */
-		if (snd_soc_dai_is_dummy(codec_dai) ||
-			snd_soc_dai_is_dummy(cpu_dai))
-			continue;
-
 		/* connect BE DAI playback if widgets are valid */
 		if (codec_dai->playback_widget && cpu_dai->playback_widget) {
 			source = cpu_dai->playback_widget;
-- 
1.7.9.5
