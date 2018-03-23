From: Nobutaka Okabe <nob77413@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Add native DSD support for
	TEAC UD-301
Date: Fri, 23 Mar 2018 18:55:04 +0900
Message-ID: <20180323095504.6422-1-nob77413@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D34612673B2
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 10:55:55 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id n11so4385264pgp.4
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 02:55:55 -0700 (PDT)
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
Cc: Nobutaka Okabe <nob77413@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add native DSD support quirk for TEAC UD-301 DAC,
by adding the PID/VID 0644:804a.

Signed-off-by: Nobutaka Okabe <nob77413@gmail.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ea8f3de92fa4..794224e1d6df 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1171,6 +1171,7 @@ static bool is_teac_dsd_dac(unsigned int id)
 	switch (id) {
 	case USB_ID(0x0644, 0x8043): /* TEAC UD-501/UD-503/NT-503 */
 	case USB_ID(0x0644, 0x8044): /* Esoteric D-05X */
+	case USB_ID(0x0644, 0x804a): /* TEAC UD-301 */
 		return true;
 	}
 	return false;
-- 
2.11.1
