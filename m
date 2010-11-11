From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: ac97: Apply quirk for Dell Latitude D610
 binding Master and Headphone controls
Date: Thu, 11 Nov 2010 09:38:18 +0100
Message-ID: <4CDBAB7A.4020504@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010602030009000700070906"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 0221610389F
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 09:38:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: crimsun@ubuntu.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010602030009000700070906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

BugLink: https://launchpad.net/bugs/669279

The original reporter states: "The Master mixer does not change the
volume from the headphone output (which is affected by the headphone
mixer). Instead it only seems to control the on-board speaker volume.
This confuses PulseAudio greatly as the Master channel is merged into
the volume mix."

Fix this symptom by applying the hp_only quirk for the reporter's SSID.
The fix is applicable to all stable kernels.

Reported-and-tested-by: Ben Gamari <bgamari@gmail.com>
Cc: <stable@kernel.org> [2.6.32+]
Signed-off-by: Daniel T Chen <crimsun@ubuntu.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------010602030009000700070906
Content-Type: text/x-patch;
 name="0001-ALSA-ac97-Apply-quirk-for-Dell-Latitude-D610-binding.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-ac97-Apply-quirk-for-Dell-Latitude-D610-binding.pa";
 filename*1="tch"

>From a2908e28990953d6b1310b15bc935307a1156d6c Mon Sep 17 00:00:00 2001
From: Daniel T Chen <crimsun@ubuntu.com>
Date: Mon, 1 Nov 2010 01:14:51 -0400
Subject: [PATCH] ALSA: ac97: Apply quirk for Dell Latitude D610 binding Master and Headphone controls

BugLink: https://launchpad.net/bugs/669279

The original reporter states: "The Master mixer does not change the
volume from the headphone output (which is affected by the headphone
mixer). Instead it only seems to control the on-board speaker volume.
This confuses PulseAudio greatly as the Master channel is merged into
the volume mix."

Fix this symptom by applying the hp_only quirk for the reporter's SSID.
The fix is applicable to all stable kernels.

Reported-and-tested-by: Ben Gamari <bgamari@gmail.com>
Cc: <stable@kernel.org> [2.6.32+]
Signed-off-by: Daniel T Chen <crimsun@ubuntu.com>
---
 sound/pci/intel8x0.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 4677492..ebfa1f8 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -1866,6 +1866,12 @@ static struct ac97_quirk ac97_quirks[] __devinitdata = {
 	},
 	{
 		.subvendor = 0x1028,
+		.subdevice = 0x0182,
+		.name = "Dell Latitude D610",	/* STAC9750/51 */
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.subvendor = 0x1028,
 		.subdevice = 0x0186,
 		.name = "Dell Latitude D810", /* cf. Malone #41015 */
 		.type = AC97_TUNE_HP_MUTE_LED
-- 
1.7.1


--------------010602030009000700070906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010602030009000700070906--
