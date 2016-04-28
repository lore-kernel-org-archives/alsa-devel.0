From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: hda - add helper to get channels from
	cap bits" to the asoc tree
Date: Thu, 28 Apr 2016 18:48:51 +0100
Message-ID: <E1avq3X-0002cC-Gt@debutante>
References: <1460608656-8860-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E66112666BF
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 19:48:56 +0200 (CEST)
In-Reply-To: <1460608656-8860-3-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: hda - add helper to get channels from cap bits

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

>From 9fc7c862e78ba8bec142935673227f2463aa05a5 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Thu, 14 Apr 2016 10:07:29 +0530
Subject: [PATCH] ALSA: hda - add helper to get channels from cap bits

This helper is copied from legacy hda driver.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/hda/local.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/hda/local.h b/sound/hda/local.h
index d692f417ddc0..0d5bb159d538 100644
--- a/sound/hda/local.h
+++ b/sound/hda/local.h
@@ -16,6 +16,16 @@ static inline int get_wcaps_type(unsigned int wcaps)
 	return (wcaps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
 }
 
+static inline unsigned int get_wcaps_channels(u32 wcaps)
+{
+	unsigned int chans;
+
+	chans = (wcaps & AC_WCAP_CHAN_CNT_EXT) >> 13;
+	chans = (chans + 1) * 2;
+
+	return chans;
+}
+
 extern const struct attribute_group *hdac_dev_attr_groups[];
 int hda_widget_sysfs_init(struct hdac_device *codec);
 void hda_widget_sysfs_exit(struct hdac_device *codec);
-- 
2.8.0.rc3
