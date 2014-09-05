From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH] add native DSD support for XMOS based DACs.
Date: Fri,  5 Sep 2014 10:49:31 +0200
Message-ID: <1409906971-3365-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb3-smtp-cloud6.xs4all.net (lb3-smtp-cloud6.xs4all.net
 [194.109.24.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 88C33265794
 for <alsa-devel@alsa-project.org>; Fri,  5 Sep 2014 10:49:34 +0200 (CEST)
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
Cc: Jurgen Kramer <gtmkramer@xs4all.nl>
List-Id: alsa-devel@alsa-project.org

Add quirk for XMOS based DACs for native DSD playback support using the new DSD_U32_LE sample
format. Works for all DAC vendors which use XMOS as idVendor. E.g. iFi Audio
with their micro iDSD and nano iDSD.

Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
---
 sound/usb/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 19a921e..e0efffb 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1174,5 +1174,15 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 		}
 	}
 
+	/* XMOS based DACs, e.g. iFi Audio micro/nano iDSD */
+	if (le16_to_cpu(chip->dev->descriptor.idVendor) == 0x20b1) {
+		switch (fp->altsetting) {
+		case 2:
+			return SNDRV_PCM_FMTBIT_DSD_U32_LE;
+		default:
+			return 0;
+		}
+	}
+
 	return 0;
 }
-- 
1.9.3
