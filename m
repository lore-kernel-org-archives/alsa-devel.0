From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: topology: Use struct_size()
	helper" to the asoc tree
Date: Tue, 28 May 2019 16:06:59 +0100 (BST)
Message-ID: <20190528150659.CEE4E440046@finisterre.sirena.org.uk>
References: <20190524161051.GA26061@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50637F8972C
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 17:07:02 +0200 (CEST)
In-Reply-To: <20190524161051.GA26061@embeddedor>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: topology: Use struct_size() helper

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 41f4fadb34af8cdcd7c1e7b4118b8db14d06849e Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Fri, 24 May 2019 11:10:51 -0500
Subject: [PATCH] ASoC: SOF: topology: Use struct_size() helper

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

sizeof(struct sof_ipc_ctrl_data) + sizeof(struct sof_ipc_ctrl_value_chan) *
	le32_to_cpu(mc->num_channels)

with:

struct_size(scontrol->control_data, chanv, le32_to_cpu(mc->num_channels))

and so on...

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/topology.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index c88afa872a58..745cb875863c 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -442,9 +442,8 @@ static int sof_control_load_volume(struct snd_soc_component *scomp,
 		return -EINVAL;
 
 	/* init the volume get/put data */
-	scontrol->size = sizeof(struct sof_ipc_ctrl_data) +
-			 sizeof(struct sof_ipc_ctrl_value_chan) *
-			 le32_to_cpu(mc->num_channels);
+	scontrol->size = struct_size(scontrol->control_data, chanv,
+				     le32_to_cpu(mc->num_channels));
 	scontrol->control_data = kzalloc(scontrol->size, GFP_KERNEL);
 	if (!scontrol->control_data)
 		return -ENOMEM;
@@ -501,9 +500,8 @@ static int sof_control_load_enum(struct snd_soc_component *scomp,
 		return -EINVAL;
 
 	/* init the enum get/put data */
-	scontrol->size = sizeof(struct sof_ipc_ctrl_data) +
-			 sizeof(struct sof_ipc_ctrl_value_chan) *
-			 le32_to_cpu(ec->num_channels);
+	scontrol->size = struct_size(scontrol->control_data, chanv,
+				     le32_to_cpu(ec->num_channels));
 	scontrol->control_data = kzalloc(scontrol->size, GFP_KERNEL);
 	if (!scontrol->control_data)
 		return -ENOMEM;
-- 
2.20.1
