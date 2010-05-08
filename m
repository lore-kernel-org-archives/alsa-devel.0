From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: sound/usb: fix UAC1 regression
Date: Sat,  8 May 2010 11:24:56 +0200
Message-ID: <1273310696-10920-1-git-send-email-daniel@caiaq.de>
References: <4BE5120B.4020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 284B91038D5
	for <alsa-devel@alsa-project.org>;
	Sat,  8 May 2010 11:25:40 +0200 (CEST)
In-Reply-To: <4BE5120B.4020201@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Commit 23caaf19b ("ALSA: usb-mixer: Add support for Audio Class v2.0")
broke support for Class1 devices due to two faulty changes. This patch
fixes it.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Reported-and-Tested-by: The Source <thesourcehim@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
---
 include/linux/usb/audio.h |    2 +-
 sound/usb/mixer.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index 905a87c..57f2055 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -244,7 +244,7 @@ struct uac_selector_unit_descriptor {
 static inline __u8 uac_selector_unit_iSelector(struct uac_selector_unit_descriptor *desc)
 {
 	__u8 *raw = (__u8 *) desc;
-	return raw[desc->bLength - 1];
+	return raw[9 + desc->bLength - 1];
 }
 
 /* 4.3.2.5 Feature Unit Descriptor */
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 21613fe..fa0fb77 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -656,7 +656,7 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
 		case UAC_FEATURE_UNIT: {
 			/* the header is the same for v1 and v2 */
 			struct uac_feature_unit_descriptor *d = p1;
-			id = d->bUnitID;
+			id = d->bSourceID;
 			break; /* continue to parse */
 		}
 		case UAC_MIXER_UNIT: {
-- 
1.7.1
