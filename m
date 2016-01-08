From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Fix to warn instead of err
	for no connected nids" to the asoc tree
Date: Fri, 08 Jan 2016 13:44:42 +0000
Message-ID: <E1aHXLO-0003EN-HR@debutante>
References: <1448992031-8271-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 55CAF265B58
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 14:44:48 +0100 (CET)
In-Reply-To: <1448992031-8271-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Fix to warn instead of err for no connected nids

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

>From 5307246015bceb2758f1eee078c6bdc8545ac91f Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Wed, 9 Dec 2015 21:46:09 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Fix to warn instead of err for no connected
 nids

It is possible that some pin widget may return with no converter
connected. So don't throw error if none are found to be connected.
Instead print a warning and continue.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e6dc4cd037d3..41117e130ce0 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -316,10 +316,12 @@ static int hdac_hdmi_query_pin_connlist(struct hdac_ext_device *hdac,
 
 	pin->num_mux_nids = snd_hdac_get_connections(&hdac->hdac, pin->nid,
 			pin->mux_nids, HDA_MAX_CONNECTIONS);
-	if (pin->num_mux_nids == 0) {
-		dev_err(&hdac->hdac.dev, "No connections found\n");
-		return -ENODEV;
-	}
+	if (pin->num_mux_nids == 0)
+		dev_warn(&hdac->hdac.dev, "No connections found for pin: %d\n",
+								pin->nid);
+
+	dev_dbg(&hdac->hdac.dev, "num_mux_nids %d for pin: %d\n",
+			pin->num_mux_nids, pin->nid);
 
 	return pin->num_mux_nids;
 }
-- 
2.7.0.rc3
