From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Fix to wait for D3 before
	powering off codec" to the asoc tree
Date: Wed, 24 Feb 2016 12:53:39 +0900
Message-ID: <E1aYQWB-0008JY-T8@finisterre>
References: <1456034444-10606-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 44911265D9F
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 04:53:49 +0100 (CET)
In-Reply-To: <1456034444-10606-1-git-send-email-subhransu.s.prusty@intel.com>
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

   ASoC: hdac_hdmi: Fix to wait for D3 before powering off codec

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

>From 7ed49700c4d6959dbfdf174023a57fc15a97c9ab Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Mon, 22 Feb 2016 07:50:32 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Fix to wait for D3 before powering off codec

Powering off codec immediately after sending D3 verb may not set
the node to D3 state. So wait for a confirmation response before
shutting down codec.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 2445b4351efb..aa953a5b57d4 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1486,6 +1486,7 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdac = &edev->hdac;
 	struct hdac_bus *bus = hdac->bus;
+	unsigned long timeout;
 	int err;
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
@@ -1495,10 +1496,19 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 		return 0;
 
 	/* Power down afg */
-	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D3))
+	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D3)) {
 		snd_hdac_codec_write(hdac, hdac->afg, 0,
 			AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
 
+		/* Wait till power state is set to D3 */
+		timeout = jiffies + msecs_to_jiffies(1000);
+		while (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D3)
+				&& time_before(jiffies, timeout)) {
+
+			msleep(50);
+		}
+	}
+
 	err = snd_hdac_display_power(bus, false);
 	if (err < 0) {
 		dev_err(bus->dev, "Cannot turn on display power on i915\n");
-- 
2.7.0
