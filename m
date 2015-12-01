From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: check error return" to the
	asoc tree
Date: Tue, 01 Dec 2015 22:59:43 +0000
Message-ID: <E1a3ttf-0006Kf-Bo@debutante>
References: <1448960375-9710-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A100A26644B
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:55 +0100 (CET)
In-Reply-To: <1448960375-9710-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudip@vectorindia.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: check error return

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

>From 3c83ac23253c6a1b6d3ebcb4bb05eabb8337c9df Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 1 Dec 2015 14:29:35 +0530
Subject: [PATCH] ASoC: hdac_hdmi: check error return

As hdac->num_nodes is unsigned we can not check if
snd_hdac_get_sub_nodes() has returned error or success. Lets have a
temporary int to check the error value.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 205f2c27263d..1a2f33b4abfc 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -409,17 +409,18 @@ static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev,
 static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
 {
 	hda_nid_t nid;
-	int i;
+	int i, num_nodes;
 	struct hdac_device *hdac = &edev->hdac;
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	int cvt_nid = 0, pin_nid = 0;
 
-	hdac->num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
-	if (!nid || hdac->num_nodes < 0) {
+	num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
+	if (!nid || num_nodes < 0) {
 		dev_warn(&hdac->dev, "HDMI: failed to get afg sub nodes\n");
 		return -EINVAL;
 	}
 
+	hdac->num_nodes = num_nodes;
 	hdac->start_nid = nid;
 
 	for (i = 0; i < hdac->num_nodes; i++, nid++) {
-- 
2.6.2
