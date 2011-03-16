From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Correct address for SSYNC register
Date: Wed, 16 Mar 2011 11:51:00 +0100
Message-ID: <4D809614.1090508@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050206000100040505070002"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 93BC11037FB
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 11:51:03 +0100 (CET)
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
--------------050206000100040505070002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's something I stumbled upon, while debugging something probably 
unrelated. I don't exactly know the implications of failing multiple 
stream synchronisation (is that something we commonly use?), or the 
implications of writing to a register that is "Reserved" in the HDA Spec 
(can there be crazy vendor magic in there we're unwillingly messing with?).

Perhaps someone else knows more and can tell if this is something that 
is actually important.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------050206000100040505070002
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Correct-address-for-SYNC-register.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Correct-address-for-SYNC-register.patch"

>From d7ade361618ee99b89a82b84b035d345ef7a1bd9 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 16 Mar 2011 11:35:11 +0100
Subject: [PATCH] ALSA: HDA: Correct address for SYNC register

The SSYNC register is located at address 0x38 according to the
HDA specification.

Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_intel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 70a9d32..ab3f654 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -176,7 +176,7 @@ MODULE_DESCRIPTION("Intel HDA driver");
 #define ICH6_REG_INTCTL			0x20
 #define ICH6_REG_INTSTS			0x24
 #define ICH6_REG_WALLCLK		0x30	/* 24Mhz source */
-#define ICH6_REG_SYNC			0x34	
+#define ICH6_REG_SYNC			0x38
 #define ICH6_REG_CORBLBASE		0x40
 #define ICH6_REG_CORBUBASE		0x44
 #define ICH6_REG_CORBWP			0x48
-- 
1.7.1


--------------050206000100040505070002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050206000100040505070002--
