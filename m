From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH 1/2] usb: Add native DSD support for
	Denon/Marantz DACs
Date: Fri, 28 Nov 2014 17:32:53 +0100
Message-ID: <1417192374-21980-2-git-send-email-gtmkramer@xs4all.nl>
References: <1417192374-21980-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb1-smtp-cloud3.xs4all.net (lb1-smtp-cloud3.xs4all.net
 [194.109.24.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 31E32260563
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 17:33:00 +0100 (CET)
In-Reply-To: <1417192374-21980-1-git-send-email-gtmkramer@xs4all.nl>
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

This patch adds native DSD support for the following devices:
- Marantz SA-14S1
- Marants HD-DAC1

Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
---
 sound/usb/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index bc9ebb6..7cb75e6 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1213,5 +1213,16 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 		break;
 	}
 
+	/* Denon/Marantz devices with USB DAC functionality */
+	switch (chip->usb_id) {
+	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
+	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
+		if (fp->altsetting == 2)
+			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
-- 
1.9.3
