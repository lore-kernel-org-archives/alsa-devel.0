From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: usb-audio: Remove set but not used variable 'first_ch_bits'
Date: Wed, 9 Jan 2019 02:20:16 +0000
Message-ID: <1547000416-144563-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Andrew Chant <achant@google.com>
Cc: YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/usb/mixer.c: In function 'parse_audio_feature_unit':
sound/usb/mixer.c:1838:28: warning:
 variable 'first_ch_bits' set but not used [-Wunused-but-set-variable]

It never used since 2.6

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/usb/mixer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index e7d441d..8ad1a24 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1835,7 +1835,7 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 {
 	int channels, i, j;
 	struct usb_audio_term iterm;
-	unsigned int master_bits, first_ch_bits;
+	unsigned int master_bits;
 	int err, csize;
 	struct uac_feature_unit_descriptor *hdr = _ftr;
 	__u8 *bmaControls;
@@ -1926,10 +1926,6 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 		break;
 
 	}
-	if (channels > 0)
-		first_ch_bits = snd_usb_combine_bytes(bmaControls + csize, csize);
-	else
-		first_ch_bits = 0;
 
 	if (state->mixer->protocol == UAC_VERSION_1) {
 		/* check all control types */
