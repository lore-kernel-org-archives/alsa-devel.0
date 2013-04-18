From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ALSA: hda - fix error return code in patch_alc662()
Date: Thu, 18 Apr 2013 11:12:59 +0800
Message-ID: <CAPgLHd-rk5P19xq8RgPALbQP7Wkf6FkmLm=koKW1d_1ejpF4Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, david.henningsson@canonical.com, kailang@realtek.com
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as returned elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/pci/hda/patch_realtek.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f15c36b..a3965b0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3787,7 +3787,8 @@ static int patch_alc662(struct hda_codec *codec)
 	if ((alc_get_coef0(codec) & (1 << 14)) &&
 	    codec->bus->pci->subsystem_vendor == 0x1025 &&
 	    spec->cdefine.platform_type == 1) {
-		if (alc_codec_rename(codec, "ALC272X") < 0)
+		err = alc_codec_rename(codec, "ALC272X");
+		if (err < 0)
 			goto error;
 	}
 
