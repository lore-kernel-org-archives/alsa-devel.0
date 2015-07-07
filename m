From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 3/3] emu10k1: rename Audigy Analog Capture Boost control
Date: Tue, 07 Jul 2015 21:54:02 +0200
Message-ID: <559C2E5A.4080104@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Michael Gernoth <michael@gernoth.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Audigy has "Analog Capture Boost" mixer control,
however now this only controls mic level, not
other analog sources.

It applies also both to playback and capture,
so rename it to something more descriptive.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 sound/pci/emu10k1/emumixer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index 567b5cb..076b117 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -1741,7 +1741,7 @@ static int snd_audigy_capture_boost_put(struct snd_kcontrol *kcontrol,
 static struct snd_kcontrol_new snd_audigy_capture_boost =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name =		"Analog Capture Boost",
+	.name =		"Mic Extra Boost",
 	.info =		snd_audigy_capture_boost_info,
 	.get =		snd_audigy_capture_boost_get,
 	.put =		snd_audigy_capture_boost_put
