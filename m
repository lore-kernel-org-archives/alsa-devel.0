From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/7] ALSA: line6: Remove invalid capability
	bits for PODxt Live Variax
Date: Wed, 28 Jan 2015 17:41:28 +0100
Message-ID: <1422463289-19135-7-git-send-email-tiwai@suse.de>
References: <1422463289-19135-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 20778264FBA
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:41:37 +0100 (CET)
In-Reply-To: <1422463289-19135-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

PODxt Live Variax doesn't have PCM and HWMON but only MIDI.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/variax.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index 9dfbe7916d99..b1c1de65d584 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -259,9 +259,7 @@ static const struct line6_properties variax_properties_table[] = {
 	[LINE6_PODXTLIVE_VARIAX] = {
 		.id = "PODxtLive",
 		.name = "PODxt Live",
-		.capabilities	= LINE6_CAP_CONTROL
-				| LINE6_CAP_PCM
-				| LINE6_CAP_HWMON,
+		.capabilities	= LINE6_CAP_CONTROL,
 		.altsetting = 1,
 		.ep_ctrl_r = 0x86,
 		.ep_ctrl_w = 0x05,
-- 
2.2.2
