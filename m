From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 1/3] emu10k1: remove unused AC'97 mixer controls on Audigy
Date: Tue, 07 Jul 2015 21:52:24 +0200
Message-ID: <559C2DF8.5030809@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Michael Gernoth <michael@gernoth.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

AC'97 Headphone output and EAPD control aren't used
on Audigy so remove them from mixer.

Also remove AC'97 3D control as the driver is
already doing for Audigys with 1361T ADC.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 sound/pci/emu10k1/emumixer.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index 55e5716..f1cb7b3 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -1830,10 +1830,16 @@ int snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 		"Capture Switch",
 		"Capture Volume",
 		"Mic Select",
+		"Headphone Playback Switch",
+		"Headphone Playback Volume",
+		"3D Control - Center",
+		"3D Control - Depth",
+		"3D Control - Switch",
 		"Video Playback Switch",
 		"Video Playback Volume",
 		"Mic Playback Switch",
 		"Mic Playback Volume",
+		"External Amplifier",
 		NULL
 	};
 	static char *audigy_rename_ctls[] = {
@@ -1996,11 +2002,6 @@ int snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 		rename_ctl(card, "Analog Mix Capture Volume", "Line2 Capture Volume");
 		rename_ctl(card, "Aux2 Capture Volume", "Line3 Capture Volume");
 		rename_ctl(card, "Mic Capture Volume", "Unknown1 Capture Volume");
-		remove_ctl(card, "Headphone Playback Switch");
-		remove_ctl(card, "Headphone Playback Volume");
-		remove_ctl(card, "3D Control - Center");
-		remove_ctl(card, "3D Control - Depth");
-		remove_ctl(card, "3D Control - Switch");
 	}
 	if ((kctl = emu->ctl_send_routing = snd_ctl_new1(&snd_emu10k1_send_routing_control, emu)) == NULL)
 		return -ENOMEM;
