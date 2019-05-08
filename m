From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Propagate
	sof_get_ctrl_copy_params() error properly" to the asoc tree
Date: Wed,  8 May 2019 07:47:08 +0100 (BST)
Message-ID: <20190508064708.ED666440033@finisterre.sirena.org.uk>
References: <20190507193910.23943-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AFDAAF80796
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 09:44:06 +0200 (CEST)
In-Reply-To: <20190507193910.23943-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Propagate sof_get_ctrl_copy_params() error properly

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 54d198d5019dd98b9bcb9099a389608d7e2cccad Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 7 May 2019 21:39:10 +0200
Subject: [PATCH] ASoC: SOF: Propagate sof_get_ctrl_copy_params() error
 properly

This fixes a compile warning below by properly handling the error code
from sof_get_ctrl_copy_params():
  include/linux/kernel.h:843:43: warning: 'sparams.pl_size' may be used uninitialized in this function [-Wmaybe-uninitialized]
  sound/soc/sof/ipc.c:639:34: note: 'sparams.pl_size' was declared here

The function returns an error before setting sparams.pl_size, so it'd
assign an uninitialized value at a later point.

Fixes: 53e0c72d98ba ("ASoC: SOF: Add support for IPC IO between DSP and Host")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/ipc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index ba1bb17a8d1e..f0b9d3c53f6f 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -567,7 +567,7 @@ static int sof_set_get_large_ctrl_data(struct snd_sof_dev *sdev,
 	size_t offset = 0;
 	size_t msg_bytes;
 	size_t pl_size;
-	int err = 0;
+	int err;
 	int i;
 
 	/* allocate max ipc size because we have at least one */
@@ -576,9 +576,13 @@ static int sof_set_get_large_ctrl_data(struct snd_sof_dev *sdev,
 		return -ENOMEM;
 
 	if (send)
-		sof_get_ctrl_copy_params(cdata->type, cdata, partdata, sparams);
+		err = sof_get_ctrl_copy_params(cdata->type, cdata, partdata,
+					       sparams);
 	else
-		sof_get_ctrl_copy_params(cdata->type, partdata, cdata, sparams);
+		err = sof_get_ctrl_copy_params(cdata->type, partdata, cdata,
+					       sparams);
+	if (err < 0)
+		return err;
 
 	msg_bytes = sparams->msg_bytes;
 	pl_size = sparams->pl_size;
-- 
2.20.1
