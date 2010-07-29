From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] Rename iMic to Int Mic on Lenovo NB0763
Date: Thu, 29 Jul 2010 15:35:00 +0200
Message-ID: <4C518384.9030104@canonical.com>
References: <4C517AD9.10107@canonical.com> <s5hlj8usa3i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000003000303050509090808"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 427DE1039A1
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 15:35:06 +0200 (CEST)
In-Reply-To: <s5hlj8usa3i.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000003000303050509090808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

2010-07-29 15:15, Takashi Iwai skrev:
> At Thu, 29 Jul 2010 14:58:01 +0200,
> David Henningsson wrote:
>>
>> The non-standard name "iMic" makes PulseAudio ignore the microphone.
>> BugLink: https://launchpad.net/bugs/605101
> 
> Could you add you sign-off?

Certainly.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------000003000303050509090808
Content-Type: text/x-patch;
 name="0004-Rename-iMic-to-Int-Mic-on-Lenovo-NB0763.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0004-Rename-iMic-to-Int-Mic-on-Lenovo-NB0763.patch"

>From 1fe20b2f8c694980cf376336e0d439327e1be89f Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 29 Jul 2010 14:46:42 +0200
Subject: [PATCH 4/4] Rename iMic to Int Mic on Lenovo NB0763

The non-standard name "iMic" makes PulseAudio ignore the microphone.
BugLink: https://launchpad.net/bugs/605101

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1744d4d..b4b7f58 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7087,7 +7087,7 @@ static struct hda_input_mux alc883_lenovo_nb0763_capture_source = {
 	.num_items = 4,
 	.items = {
 		{ "Mic", 0x0 },
-		{ "iMic", 0x1 },
+		{ "Int Mic", 0x1 },
 		{ "Line", 0x2 },
 		{ "CD", 0x4 },
 	},
@@ -8657,8 +8657,8 @@ static struct snd_kcontrol_new alc883_lenovo_nb0763_mixer[] = {
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("iMic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("iMic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
-- 
1.7.0.4


--------------000003000303050509090808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000003000303050509090808--
