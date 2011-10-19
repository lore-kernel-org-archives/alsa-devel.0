From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Add new revision for ALC662
Date: Wed, 19 Oct 2011 11:50:11 +0200
Message-ID: <4E9E9D53.1030502@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070301030905080206060603"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 03C21244D6
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 11:50:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, kailang@realtek.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070301030905080206060603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

We found a new chip, with Vendor Id: 0x10ec0662 and Revision Id: 
0x100300. It seems to work well with patch_alc662, but I don't know if 
patch_alc882 had been better, and actually, I don't know if there's much 
of a difference between the two patch functions these days anyway.

I'm cc:ing Kailang in case there's more to it (codec renaming, 
processing coefficients etc) that we don't know of.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------070301030905080206060603
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Add-new-revision-for-ALC662.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-HDA-Add-new-revision-for-ALC662.patch"

>From 8820c37abd6b093f2cf61787b8e2abf64166c53e Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 18 Oct 2011 14:07:51 +0200
Subject: [PATCH] ALSA: HDA: Add new revision for ALC662

The revision 0x100300 was found for ALC662. It seems to work well
with patch_alc662.

Cc: stable@kernel.org
BugLink: http://bugs.launchpad.net/bugs/877373
Tested-by: Shengyao Xue <Shengyao.xue@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f9d24c3..86ecc72 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5774,6 +5774,8 @@ static const struct hda_codec_preset snd_hda_preset_realtek[] = {
 	  .patch = patch_alc882 },
 	{ .id = 0x10ec0662, .rev = 0x100101, .name = "ALC662 rev1",
 	  .patch = patch_alc662 },
+	{ .id = 0x10ec0662, .rev = 0x100300, .name = "ALC662 rev3",
+	  .patch = patch_alc662 },
 	{ .id = 0x10ec0663, .name = "ALC663", .patch = patch_alc662 },
 	{ .id = 0x10ec0665, .name = "ALC665", .patch = patch_alc662 },
 	{ .id = 0x10ec0670, .name = "ALC670", .patch = patch_alc662 },
-- 
1.7.5.4


--------------070301030905080206060603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070301030905080206060603--
