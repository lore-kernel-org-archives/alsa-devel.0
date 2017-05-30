From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: usb: Fix a typo in Tascam US-16x08
	mixer element
Date: Tue, 30 May 2017 23:29:58 +0200
Message-ID: <20170530212959.5975-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 280682668BF
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 23:30:02 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B0998AB9D
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 21:30:02 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

A mixer element created in a quirk for Tascam US-16x08 contains a
typo: it should be "EQ MidLow Q" instead of "EQ MidQLow Q".

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195875
Fixes: d2bb390a2081 ("ALSA: usb-audio: Tascam US-16x08 DSP mixer quirk")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_us16x08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 29d2c9282987..442d8f7998e3 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -1135,7 +1135,7 @@ static const struct snd_us16x08_control_params eq_controls[] = {
 		.control_id = SND_US16X08_ID_EQLOWMIDWIDTH,
 		.type = USB_MIXER_U8,
 		.num_channels = 16,
-		.name = "EQ MidQLow Q",
+		.name = "EQ MidLow Q",
 	},
 	{ /* EQ mid high gain */
 		.kcontrol_new = &snd_us16x08_eq_gain_ctl,
-- 
2.13.0
