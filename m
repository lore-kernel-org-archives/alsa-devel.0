From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: avoid reference to invalid
	variable of the pin list" to the asoc tree
Date: Mon, 06 Mar 2017 11:46:30 +0100
Message-ID: <E1ckq9u-0002QU-2L@finisterre>
References: <1488388284-11227-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C42F4266DBE
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:46:43 +0100 (CET)
In-Reply-To: <1488388284-11227-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, Julia Lawall <Julia.Lawall@lip6.fr>, broonie@kernel.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: avoid reference to invalid variable of the pin list

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

>From 04c8f2bf9117de7b8e8bc0b90e8c4bff15f4f613 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Wed, 1 Mar 2017 22:41:23 +0530
Subject: [PATCH] ASoC: hdac_hdmi: avoid reference to invalid variable of the
 pin list

Using pin list array iterator outside the iteration of the list can
point to dummy element, which can be invalid. So don't use pin variable
outside the pin list iteration.

This fixes the following coccinelle warning:
sound/soc/codecs/hdac_hdmi.c:1419:5-8: ERROR: invalid reference to the
index variable of the iterator

Fixes: 2acd8309a3a4('ASoC: hdac_hdmi: Add support to handle MST capable pin')
Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 78fca8acd3ec..bb405698e102 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1534,21 +1534,20 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
 			pin->mst_capable = false;
 			/* if not MST, default is port[0] */
 			hport = &pin->ports[0];
-			goto out;
 		} else {
 			for (i = 0; i < pin->num_ports; i++) {
 				pin->mst_capable = true;
 				if (pin->ports[i].id == pipe) {
 					hport = &pin->ports[i];
-					goto out;
+					break;
 				}
 			}
 		}
+
+		if (hport)
+			hdac_hdmi_present_sense(pin, hport);
 	}
 
-out:
-	if (pin && hport)
-		hdac_hdmi_present_sense(pin, hport);
 }
 
 static struct i915_audio_component_audio_ops aops = {
-- 
2.11.0
