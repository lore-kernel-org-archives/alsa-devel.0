From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Fix infoframe programming"
	to the asoc tree
Date: Thu, 10 Mar 2016 10:39:05 +0700
Message-ID: <E1adrRJ-0007U5-N7@finisterre>
References: <1457580847-32479-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 635D7260694
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 04:39:14 +0100 (CET)
In-Reply-To: <1457580847-32479-1-git-send-email-subhransu.s.prusty@intel.com>
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

   ASoC: hdac_hdmi: Fix infoframe programming

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

>From 391005e8e3cd5bb641dff5abb1ad37254602cd7e Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Thu, 10 Mar 2016 09:04:07 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Fix infoframe programming

Audio infoframe used incorrect buffer, so fix it.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 7851dd204a49..4f7bd1fae0db 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -303,7 +303,6 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 		if (ret < 0)
 			return ret;
 
-		dip = (u8 *)&frame;
 		break;
 
 	case DRM_ELD_CONN_TYPE_DP:
@@ -332,9 +331,9 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 	/*  Fill infoframe. Index auto-incremented */
 	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
 	if (conn_type == DRM_ELD_CONN_TYPE_HDMI) {
-		for (i = 0; i < sizeof(frame); i++)
+		for (i = 0; i < sizeof(buffer); i++)
 			snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
-				AC_VERB_SET_HDMI_DIP_DATA, dip[i]);
+				AC_VERB_SET_HDMI_DIP_DATA, buffer[i]);
 	} else {
 		for (i = 0; i < sizeof(dp_ai); i++)
 			snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
-- 
2.7.0
