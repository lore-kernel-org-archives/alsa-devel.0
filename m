From: Eric Engestrom <eric@engestrom.ch>
Subject: [PATCH 36/41] Documentation: sound: fix spelling mistakes
Date: Mon, 25 Apr 2016 07:37:02 +0100
Message-ID: <1461566229-4717-10-git-send-email-eric@engestrom.ch>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
 <1461566229-4717-1-git-send-email-eric@engestrom.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461566229-4717-1-git-send-email-eric@engestrom.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Eric Engestrom <eric@engestrom.ch>, Vinod Koul <vinod.koul@intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Eric Engestrom <eric@engestrom.ch>
---
 Documentation/sound/alsa/compress_offload.txt | 2 +-
 Documentation/sound/alsa/soc/dapm.txt         | 2 +-
 Documentation/sound/alsa/soc/overview.txt     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/sound/alsa/compress_offload.txt b/Documentation/sound/alsa/compress_offload.txt
index 630c492..81476b4 100644
--- a/Documentation/sound/alsa/compress_offload.txt
+++ b/Documentation/sound/alsa/compress_offload.txt
@@ -149,7 +149,7 @@ Gapless Playback
 ================
 When playing thru an album, the decoders have the ability to skip the encoder
 delay and padding and directly move from one track content to another. The end
-user can perceive this as gapless playback as we dont have silence while
+user can perceive this as gapless playback as we don't have silence while
 switching from one track to another
 
 Also, there might be low-intensity noises due to encoding. Perfect gapless is
diff --git a/Documentation/sound/alsa/soc/dapm.txt b/Documentation/sound/alsa/soc/dapm.txt
index 6faab48..c45bd79 100644
--- a/Documentation/sound/alsa/soc/dapm.txt
+++ b/Documentation/sound/alsa/soc/dapm.txt
@@ -132,7 +132,7 @@ SOC_DAPM_SINGLE("HiFi Playback Switch", WM8731_APANA, 4, 1, 0),
 SND_SOC_DAPM_MIXER("Output Mixer", WM8731_PWR, 4, 1, wm8731_output_mixer_controls,
 	ARRAY_SIZE(wm8731_output_mixer_controls)),
 
-If you dont want the mixer elements prefixed with the name of the mixer widget,
+If you don't want the mixer elements prefixed with the name of the mixer widget,
 you can use SND_SOC_DAPM_MIXER_NAMED_CTL instead. the parameters are the same
 as for SND_SOC_DAPM_MIXER.
 
diff --git a/Documentation/sound/alsa/soc/overview.txt b/Documentation/sound/alsa/soc/overview.txt
index ff88f52..f3f28b7 100644
--- a/Documentation/sound/alsa/soc/overview.txt
+++ b/Documentation/sound/alsa/soc/overview.txt
@@ -63,7 +63,7 @@ multiple re-usable component drivers :-
     and any audio DSP drivers for that platform.
 
   * Machine class driver: The machine driver class acts as the glue that
-    decribes and binds the other component drivers together to form an ALSA
+    describes and binds the other component drivers together to form an ALSA
     "sound card device". It handles any machine specific controls and
     machine level audio events (e.g. turning on an amp at start of playback).
 
-- 
2.8.0
