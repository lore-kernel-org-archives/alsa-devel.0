From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: For TLV controls only register TLV get/set" to the asoc tree
Date: Wed, 28 Feb 2018 11:06:04 +0000
Message-ID: <E1eqzYi-0005BJ-Eq@debutante>
References: <20180228103110.2055-1-rf@opensource.cirrus.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180228103110.2055-1-rf@opensource.cirrus.com>
Sender: stable-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgbroonie@kernel.org, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: For TLV controls only register TLV get/set

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

>From d7789f5bcdb298c4a302db471b1b20f74a20de95 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Wed, 28 Feb 2018 10:31:10 +0000
Subject: [PATCH] ASoC: wm_adsp: For TLV controls only register TLV get/set

Normal 512-byte get/set of a TLV isn't supported but we were
registering the normal get/set anyway and relying on omitting
the SNDRV_CTL_ELEM_ACCESS_[READ|WRITE] flags to prevent them
being called.

Trouble is if this gets broken in the core ALSA code - as it has
been since at least 4.14 - the standard get/set can be called
unexpectedly and corrupt memory.

There's no point providing functions that won't be called and
it's a trivial change. The benefit is that if the ALSA core gets
broken again we get a big fat immediate NULL dereference instead
of a memory corruption timebomb.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm_adsp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 66e32f5d2917..989d093abda7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1204,12 +1204,14 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 		kcontrol->put = wm_coeff_put_acked;
 		break;
 	default:
-		kcontrol->get = wm_coeff_get;
-		kcontrol->put = wm_coeff_put;
-
-		ctl->bytes_ext.max = ctl->len;
-		ctl->bytes_ext.get = wm_coeff_tlv_get;
-		ctl->bytes_ext.put = wm_coeff_tlv_put;
+		if (kcontrol->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+			ctl->bytes_ext.max = ctl->len;
+			ctl->bytes_ext.get = wm_coeff_tlv_get;
+			ctl->bytes_ext.put = wm_coeff_tlv_put;
+		} else {
+			kcontrol->get = wm_coeff_get;
+			kcontrol->put = wm_coeff_put;
+		}
 		break;
 	}
 
-- 
2.16.1
