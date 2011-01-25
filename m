From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix dmesg output of HDMI supported
	bits
Date: Tue, 25 Jan 2011 19:52:16 +0100
Message-ID: <4D3F1BE0.2040704@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090609020005060300040600"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id E64B11039A3
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 19:52:27 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090609020005060300040600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This typo caused the dmesg output of the supported bits of HDMI
to be cut off early.

Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------090609020005060300040600
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-dmesg-output-of-HDMI-supported-bits.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Fix-dmesg-output-of-HDMI-supported-bits.patch"

>From 058ef40d05488d796256e37433afba664aa0a1a4 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 25 Jan 2011 19:44:26 +0100
Subject: [PATCH] ALSA: HDA: Fix dmesg output of HDMI supported bits

This typo caused the dmesg output of the supported bits of HDMI
to be cut off early.

Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_eld.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 4a66347..74b0560 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -381,7 +381,7 @@ static void hdmi_show_short_audio_desc(struct cea_sad *a)
 	snd_print_pcm_rates(a->rates, buf, sizeof(buf));
 
 	if (a->format == AUDIO_CODING_TYPE_LPCM)
-		snd_print_pcm_bits(a->sample_bits, buf2 + 8, sizeof(buf2 - 8));
+		snd_print_pcm_bits(a->sample_bits, buf2 + 8, sizeof(buf2) - 8);
 	else if (a->max_bitrate)
 		snprintf(buf2, sizeof(buf2),
 				", max bitrate = %d", a->max_bitrate);
-- 
1.7.1


--------------090609020005060300040600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090609020005060300040600--
