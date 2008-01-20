From: Robert Jarzmik <rjarzmik@free.fr>
Subject: [PATCH] wm9713 and virtual Line mixer
Date: 21 Jan 2008 00:36:50 +0100
Message-ID: <87lk6kdq7h.fsf@polgara.paysbobval>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 47501244E4
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 00:36:49 +0100 (CET)
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id BC8555FE3A
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 00:36:48 +0100 (CET)
Received: from polgara (mur31-2-82-243-122-54.fbx.proxad.net [82.243.122.54])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 7A7D95FD4F
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 00:36:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=

Trivial patch for the forgotten virtual line mixer in wm9713.

Missing this mixer causes Mono Mixer and Speaker Mixer lack of support for input
from Line Left and Line Right signals.

--
Robert


--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment; filename=wm9713.diff
Content-Description: wm9713 virtual Line In support

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 404ef18..68a8b25 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -421,6 +421,7 @@ SND_SOC_DAPM_DAC("Left DAC", "Left HiFi Playback", AC97_EXTENDED_MID, 7, 1),
 SND_SOC_DAPM_DAC("Right DAC", "Right HiFi Playback", AC97_EXTENDED_MID, 6, 1),
 SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_MIXER("HP Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
+SND_SOC_DAPM_MIXER("Line Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_MIXER("Capture Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_DAC("Voice DAC", "Voice Playback", AC97_EXTENDED_MID, 12, 1),
 SND_SOC_DAPM_DAC("Aux DAC", "Aux Playback", AC97_EXTENDED_MID, 11, 1),

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--
