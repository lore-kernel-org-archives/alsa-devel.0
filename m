From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ALSA: usb-audio: Fix the mixer control range limiting issue
Date: Wed, 21 Aug 2019 11:02:25 +0100
Message-ID: <20190821100225.9254-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Deepa Madiregama <dmadireg@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Meng Wang <mwang@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Deepa Madiregama <dmadireg@codeaurora.org>

- mixer_ctl_set() function is limiting the volume level
  to particular range. This results in incorrect initial
  volume setting for that device.
- In USB mixer while calculating the dBmin/dBmax values
  resolution factor is hardcoded to 256 which results in
  populating the wrong values for dBmin/dBmax.
- Fix is to use appropriate resolution factor while
  calculating the dBmin/dBmax values.

Signed-off-by: Deepa Madiregama <dmadireg@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Meng Wang <mwang@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/usb/mixer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 5070a6a76ab3..a67448327d07 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1248,8 +1248,10 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 	/* USB descriptions contain the dB scale in 1/256 dB unit
 	 * while ALSA TLV contains in 1/100 dB unit
 	 */
-	cval->dBmin = (convert_signed_value(cval, cval->min) * 100) / 256;
-	cval->dBmax = (convert_signed_value(cval, cval->max) * 100) / 256;
+	cval->dBmin =
+		(convert_signed_value(cval, cval->min) * 100) / (cval->res);
+	cval->dBmax =
+		(convert_signed_value(cval, cval->max) * 100) / (cval->res);
 	if (cval->dBmin > cval->dBmax) {
 		/* something is wrong; assume it's either from/to 0dB */
 		if (cval->dBmin < 0)
-- 
2.21.0
