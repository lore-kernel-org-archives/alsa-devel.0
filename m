From: Viral Mehta <viral.mehta@einfochips.com>
Subject: [PATCH][SOUND]volume control for CSWITCH and CROUTE
Date: Sat, 04 Apr 2009 18:08:28 +0530
Message-ID: <49D754C4.2030803@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ahmedabad.einfochips.com (india.einfochips.com [203.88.139.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D4F524519
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Apr 2009 14:41:58 +0200 (CEST)
Received: from unknown (HELO [192.168.14.27]) (viral.mehta@[192.168.14.27])
	(envelope-sender <viral.mehta@einfochips.com>)
	by ahmedabad.einfochips.com (qmail-ldap-1.03) with SMTP
	for <alsa-devel@alsa-project.org>; 4 Apr 2009 12:39:54 -0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

From: Deepika Makhija <deepika.makhija@einfochips.com>

Added an else part to check 
SNDRV_MIXER_OSS_PRESENT_CVOLUME for MIC (slot 7)
in commit 36c7b833e5d2501142a371e4e75281d3a29fbd6b

Similarly, checks and volume control is required for 
SNDRV_MIXER_OSS_PRESENT_CSWITCH and SNDRV_MIXER_OSS_PRESENT_CROUTE
as well.

Signed-off-by: Deepika Makhija <deepika.makhija@einfochips.com>
Signed-off-by: Viral Mehta <viral.mehta@einfochips.com>
---
--- a/sound/core/oss/mixer-oss.c	2009-04-04 17:06:46.000000000 +0530
+++ b/sound/core/oss/mixer-oss.c	2009-04-04 17:04:33.000000000 +0530
@@ -703,19 +703,27 @@ static int snd_mixer_oss_put_volume1(str
 	if (left || right) {
 		if (slot->present & SNDRV_MIXER_OSS_PRESENT_PSWITCH)
 			snd_mixer_oss_put_volume1_sw(fmixer, pslot, slot->numid[SNDRV_MIXER_OSS_ITEM_PSWITCH], left, right, 0);
+		if (slot->present & SNDRV_MIXER_OSS_PRESENT_CSWITCH)
+			snd_mixer_oss_put_volume1_sw(fmixer, pslot, slot->numid[SNDRV_MIXER_OSS_ITEM_CSWITCH], left, right, 0);
 		if (slot->present & SNDRV_MIXER_OSS_PRESENT_GSWITCH)
 			snd_mixer_oss_put_volume1_sw(fmixer, pslot, slot->numid[SNDRV_MIXER_OSS_ITEM_GSWITCH], left, right, 0);
 		if (slot->present & SNDRV_MIXER_OSS_PRESENT_PROUTE)
 			snd_mixer_oss_put_volume1_sw(fmixer, pslot, slot->numid[SNDRV_MIXER_OSS_ITEM_PROUTE], left, right, 1);
+		if (slot->present & SNDRV_MIXER_OSS_PRESENT_CROUTE)
+			snd_mixer_oss_put_volume1_sw(fmixer, pslot, slot->numid[SNDRV_MIXER_OSS_ITEM_CROUTE], left, right, 1);
 		if (slot->present & SNDRV_MIXER_OSS_PRESENT_GROUTE)
 			snd_mixer_oss_put_volume1_sw(fmixer, pslot, slot->numid[SNDRV_MIXER_OSS_ITEM_GROUTE], left, right, 1);
 	} else {
 		if (slot->present & SNDRV_MIXER_OSS_PRESENT_PSWITCH) {
 			snd_mixer_oss_put_volume1_sw(fmixer, pslot, slot->numid[SNDRV_MIXER_OSS_ITEM_PSWITCH], left, right, 0);
+		} else if (slot->present & SNDRV_MIXER_OSS_PRESENT_CSWITCH) {
+			snd_mixer_oss_put_volume1_sw(fmixer, pslot, slot->numid[SNDRV_MIXER_OSS_ITEM_CSWITCH], left, right, 0);
 		} else if (slot->present & SNDRV_MIXER_OSS_PRESENT_GSWITCH) {
 			snd_mixer_oss_put_volume1_sw(fmixer, pslot, slot->numid[SNDRV_MIXER_OSS_ITEM_GSWITCH], left, right, 0);
 		} else if (slot->present & SNDRV_MIXER_OSS_PRESENT_PROUTE) {
 			snd_mixer_oss_put_volume1_sw(fmixer, pslot, slot->numid[SNDRV_MIXER_OSS_ITEM_PROUTE], left, right, 1);
+		} else if (slot->present & SNDRV_MIXER_OSS_PRESENT_CROUTE) {
+			snd_mixer_oss_put_volume1_sw(fmixer, pslot, slot->numid[SNDRV_MIXER_OSS_ITEM_CROUTE], left, right, 1);
 		} else if (slot->present & SNDRV_MIXER_OSS_PRESENT_GROUTE) {
 			snd_mixer_oss_put_volume1_sw(fmixer, pslot, slot->numid[SNDRV_MIXER_OSS_ITEM_GROUTE], left, right, 1);
 		}
