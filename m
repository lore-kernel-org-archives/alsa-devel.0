From: Howard Mitchell <hm@hmbedded.co.uk>
Subject: [PATCH 1/2] ALSA:ControlName.txt: Add 'Analogue' as a
	prefix for volume controls
Date: Thu, 19 Mar 2015 12:08:29 +0000
Message-ID: <1426766910-27250-1-git-send-email-hm@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avasout02.plus.net (avasout02.plus.net [212.159.14.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D180260417
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 13:09:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, gordon@iqaudio.com, Howard Mitchell <hm@hmbedded.co.uk>
List-Id: alsa-devel@alsa-project.org

Currently 'Playback Volume' is the correct way to express an analogue
volume control. However, this control name has initialisation defaults
applied when using 'alsactl restore' and in some cases this is not
appropriate. An example would be a control that has a selection of
0db and -6dB of gain that is intended to set the fullscale ouput
voltage of a DAC. The TI pcm512x family of DAcs have such a control.
In this case the device/driver reset defaults are preferred.

Signed-off-by: Howard Mitchell <hm@hmbedded.co.uk>
---
 Documentation/sound/alsa/ControlNames.txt |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/sound/alsa/ControlNames.txt b/Documentation/sound/alsa/ControlNames.txt
index 79a6127..3fc1cf50 100644
--- a/Documentation/sound/alsa/ControlNames.txt
+++ b/Documentation/sound/alsa/ControlNames.txt
@@ -71,11 +71,11 @@ SOURCE:
   HDMI/DP	(either HDMI or DisplayPort)
 
 Exceptions (deprecated):
-  [Digital] Capture Source
-  [Digital] Capture Switch	(aka input gain switch)
-  [Digital] Capture Volume	(aka input gain volume)
-  [Digital] Playback Switch	(aka output gain switch)
-  [Digital] Playback Volume	(aka output gain volume)
+  [Analogue|Digital] Capture Source
+  [Analogue|Digital] Capture Switch	(aka input gain switch)
+  [Analogue|Digital] Capture Volume	(aka input gain volume)
+  [Analogue|Digital] Playback Switch	(aka output gain switch)
+  [Analogue|Digital] Playback Volume	(aka output gain volume)
   Tone Control - Switch
   Tone Control - Bass
   Tone Control - Treble
-- 
1.7.9.5
