From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: remove redundant check for
	!port condition" to the asoc tree
Date: Thu,  6 Sep 2018 11:44:55 +0100 (BST)
Message-ID: <20180906104455.E04351122A1F@debutante.sirena.org.uk>
References: <20180906093901.16682-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 901E82677BB
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 12:44:57 +0200 (CEST)
In-Reply-To: <20180906093901.16682-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: remove redundant check for !port condition

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

>From c24fb71fa4f764f02c17cbf88a969f109794e602 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 6 Sep 2018 10:39:01 +0100
Subject: [PATCH] ASoC: hdac_hdmi: remove redundant check for !port condition

The !port check is redundant as it being performed in the following
check. Remove it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 7b8533abf637..dc6a0dfea050 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1961,9 +1961,6 @@ static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdev, int pcm_idx)
 
 	port = list_first_entry(&pcm->port_list, struct hdac_hdmi_port, head);
 
-	if (!port)
-		return 0;
-
 	if (!port || !port->eld.eld_valid)
 		return 0;
 
-- 
2.19.0.rc1
