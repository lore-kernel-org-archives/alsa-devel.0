From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Ensuring proper setting of
	output widget power state" to the asoc tree
Date: Fri, 12 Jan 2018 21:08:53 +0000
Message-ID: <E1ea6ZJ-0003BS-KB@debutante>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B705F266B67
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 22:09:12 +0100 (CET)
In-Reply-To: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, abhijeet.kumar@intel.com, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Guneshwor Singh <guneshwor.o.singh@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, Sandeep Tayal <sandeepx.tayal@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Ensuring proper setting of output widget power state

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

>From a04ba2b3dc6c14bedd5efca442d6039690562951 Mon Sep 17 00:00:00 2001
From: Abhijeet Kumar <abhijeet.kumar@intel.com>
Date: Fri, 12 Jan 2018 14:02:54 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Ensuring proper setting of output widget
 power state

In usecases like hot plug-unplug DP panel or modeset during a playback,
sometimes we observe no audio after codec resets.

During no audio condition, we have noticed that the power state of the
pin or the connector is D3. Optimzing the way we set the power could
mitigate the issue. With this changes the verb is sent to set the power
state and response is received. Thus ensuring power state is set.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index f3b4f4dfae6a..e24caecf0a4f 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -718,7 +718,7 @@ static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
 {
 	if (get_wcaps(&edev->hdac, nid) & AC_WCAP_POWER) {
 		if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state))
-			snd_hdac_codec_write(&edev->hdac, nid, 0,
+			snd_hdac_codec_read(&edev->hdac, nid, 0,
 				AC_VERB_SET_POWER_STATE, pwr_state);
 	}
 }
-- 
2.15.1
