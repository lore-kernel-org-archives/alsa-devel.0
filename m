From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 2/6] ALSA: usb: ADC3. BADD specification: fixed
	48KHz sample rate.
Date: Wed, 29 Nov 2017 10:55:28 +0000
Message-ID: <20171129105532.15420-3-jorge.sanjuan@codethink.co.uk>
References: <20171129105532.15420-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C13C267882
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 11:55:36 +0100 (CET)
In-Reply-To: <20171129105532.15420-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@lists.codethink.co.uk, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

Make the frame rate range fixed to just 48KHz as the BADD specification
stands for ADC3 devices.

For more details check section 4.2.4 of the Basic Audio Device version
3.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/format.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 6f8589227e6a..e8669a1e996e 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -445,7 +445,12 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
 	case UAC_VERSION_2:
 	case UAC_VERSION_3: {
 		/* fp->channels is already set in this case */
-		ret = parse_audio_format_rates_v2v3(chip, fp);
+		if (chip->badd_profile > UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0) {
+			fp->rate_min = fp->rate_max = 48000;
+			fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
+			return 0;
+		} else
+			ret = parse_audio_format_rates_v2v3(chip, fp);
 		break;
 	}
 	}
-- 
2.11.0
