From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: avoid uninitialized kcontrol_type" to the asoc tree
Date: Mon, 12 Dec 2016 15:43:23 +0000
Message-ID: <E1cGSl9-0002Zs-2c@debutante>
References: <20161209115207.3885433-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209115207.3885433-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: avoid uninitialized kcontrol_type

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

>From dd5abb742071a962be4403f171063ed1e9d4202d Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 9 Dec 2016 12:51:46 +0100
Subject: [PATCH] ASoC: topology: avoid uninitialized kcontrol_type

When num_kcontrols is zero, widget->dobj.widget.kcontrol_type
gets set to an uninitialized local variable:

sound/soc/soc-topology.c: In function 'soc_tplg_dapm_widget_create':
sound/soc/soc-topology.c:1566:36: error: 'kcontrol_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]

I could not figure out which of the valid types would be appropriate
here, so this sets it to '0', which is invalid but at least well-defined
here. There is probably a better way to address the issue.

Fixes: eea3dd4f1247 ("ASoC: topology: Only free TLV for volume mixers of a widget")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 11feb19e9730..65670b2b408c 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1485,6 +1485,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	tplg->pos +=
 		(sizeof(struct snd_soc_tplg_dapm_widget) + w->priv.size);
 	if (w->num_kcontrols == 0) {
+		kcontrol_type = 0;
 		template.num_kcontrols = 0;
 		goto widget;
 	}
-- 
2.11.0
