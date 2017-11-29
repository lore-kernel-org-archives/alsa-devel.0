From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 3/6] ALSA: usb: ADC3. Do not set sample rate
	for BADD configuration.
Date: Wed, 29 Nov 2017 10:55:29 +0000
Message-ID: <20171129105532.15420-4-jorge.sanjuan@codethink.co.uk>
References: <20171129105532.15420-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id BFC3B26788E
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

BADD configuration is fixed to 48KHz for all AudioStreaming
interfaces.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/clock.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 04361d79b163..c7f4ca4cdcd4 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -605,7 +605,11 @@ int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
 
 	case UAC_VERSION_2:
 	case UAC_VERSION_3:
-		return set_sample_rate_v2v3(chip, iface, alts, fmt, rate);
+		if (chip->badd_profile > UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0)
+			return 0;
+		else
+			return set_sample_rate_v2v3(chip, iface,
+						    alts, fmt, rate);
 	}
 }
 
-- 
2.11.0
