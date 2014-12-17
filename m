From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH] usb: add native DSD support for Matrix Audio
	DACs
Date: Wed, 17 Dec 2014 17:45:20 +0100
Message-ID: <1418834720-4772-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb2-smtp-cloud3.xs4all.net (lb2-smtp-cloud3.xs4all.net
 [194.109.24.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 157C526063D
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 17:45:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Jurgen Kramer <gtmkramer@xs4all.nl>
List-Id: alsa-devel@alsa-project.org

This patch adds native DSD support for two XMOS based DACs from Matrix Audio:
- X-Sabre
- Mini-i Pro

Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
---
 sound/usb/quirks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 4dbfb3d..a739841 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1245,8 +1245,9 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 
 	/* XMOS based USB DACs */
 	switch (chip->usb_id) {
-	/* iFi Audio micro/nano iDSD */
-	case USB_ID(0x20b1, 0x3008):
+	case USB_ID(0x20b1, 0x3008): /* iFi Audio micro/nano iDSD */
+	case USB_ID(0x20b1, 0x2008): /* Matrix Audio X-Sabre */
+	case USB_ID(0x20b1, 0x300a): /* Matrix Audio Mini-i Pro */
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
-- 
1.9.3
