From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Fix to keep codec power
	active during enumeration." to the asoc tree
Date: Sun, 21 Feb 2016 02:15:51 +0900
Message-ID: <E1aXB8J-0008Me-Ip@finisterre>
References: <1454161428-7896-14-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 44BA5265119
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:15:57 +0100 (CET)
In-Reply-To: <1454161428-7896-14-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ramesh Babu <ramesh.babu@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Fix to keep codec power active during enumeration.

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

>From aeaccef0bc0d364792ecc9455cb13d007fd7a371 Mon Sep 17 00:00:00 2001
From: Ramesh Babu <ramesh.babu@intel.com>
Date: Wed, 17 Feb 2016 21:34:01 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Fix to keep codec power active during
 enumeration.

The codec power is turned OFF in the first explicit call to
pm_runtime_suspend to keep the i915 refcount balanced. During regular
operation, the power is turned ON/OFF in runtime PM handlers.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index f12af62..57ab212 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1426,6 +1426,18 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	INIT_LIST_HEAD(&hdmi_priv->pcm_list);
 	mutex_init(&hdmi_priv->pin_mutex);
 
+	/*
+	 * Turned off in the runtime_suspend during the first explicit
+	 * pm_runtime_suspend call.
+	 */
+	ret = snd_hdac_display_power(edev->hdac.bus, true);
+	if (ret < 0) {
+		dev_err(&edev->hdac.dev,
+			"Cannot turn on display power on i915 err: %d\n",
+			ret);
+		return ret;
+	}
+
 	ret = hdac_hdmi_parse_and_map_nid(edev, &hdmi_dais, &num_dais);
 	if (ret < 0) {
 		dev_err(&codec->dev,
-- 
2.7.0
