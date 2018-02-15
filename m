From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Fix build" to the asoc tree
Date: Thu, 15 Feb 2018 17:26:56 +0000
Message-ID: <E1emNJA-0004U9-PB@debutante>
References: <20180215172033.8534-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 60D20267CAE
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 18:27:12 +0100 (CET)
In-Reply-To: <20180215172033.8534-1-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, abhijeet.kumar@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Fix build

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

>From 0b9751c7179b8ec7a33addc3a8b2b1639d4678cb Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Thu, 15 Feb 2018 17:14:16 +0000
Subject: [PATCH] ASoC: Intel: Fix build

One of the recently introduced commits hadn't been build tested, fix
that.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 60bea9d69fc0..84f7a7a36e4b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -722,12 +722,12 @@ static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
 	unsigned int state;
 
 	if (get_wcaps(&edev->hdev, nid) & AC_WCAP_POWER) {
-		if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state)) {
+		if (!snd_hdac_check_power_state(&edev->hdev, nid, pwr_state)) {
 			for (count = 0; count < 10; count++) {
-				snd_hdac_codec_read(&edev->hdac, nid, 0,
+				snd_hdac_codec_read(&edev->hdev, nid, 0,
 						AC_VERB_SET_POWER_STATE,
 						pwr_state);
-				state = snd_hdac_sync_power_state(&edev->hdac,
+				state = snd_hdac_sync_power_state(&edev->hdev,
 						nid, pwr_state);
 				if (!(state & AC_PWRST_ERROR))
 					break;
-- 
2.16.1
