From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Fix to check num nodes
	correctly" to the asoc tree
Date: Tue, 05 Jan 2016 23:07:25 +0000
Message-ID: <E1aGahJ-0007S8-8s@debutante>
References: <1449176942-3441-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 59136260410
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2016 00:07:34 +0100 (CET)
In-Reply-To: <1449176942-3441-1-git-send-email-subhransu.s.prusty@intel.com>
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

   ASoC: hdac_hdmi: Fix to check num nodes correctly

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

>From 541140d43046ccd4e7b511846d22b3d3ca7367f3 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Wed, 9 Dec 2015 21:46:08 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Fix to check num nodes correctly

commit 3c83ac23253c ("ASoC: hdac_hdmi: check error return") fixes
the static checker warning reported by Dan Carpenter:

	sound/soc/codecs/hdac_hdmi.c:416 hdac_hdmi_parse_and_map_nid()
	warn: unsigned 'hdac->num_nodes' is never less than zero.

But it doesn't fix the issue completely.

It's also a failure if no sub nodes found for an afg node. So modify
the return condition appropriately.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index b999fb2a463b..e6dc4cd037d3 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -415,7 +415,7 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
 	int cvt_nid = 0, pin_nid = 0;
 
 	num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
-	if (!nid || num_nodes < 0) {
+	if (!nid || num_nodes <= 0) {
 		dev_warn(&hdac->dev, "HDMI: failed to get afg sub nodes\n");
 		return -EINVAL;
 	}
-- 
2.7.0.rc3
