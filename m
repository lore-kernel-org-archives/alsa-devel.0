From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Remove over-initialization of mux
	in ALC269VB
Date: Thu, 10 Mar 2011 08:59:22 +0100
Message-ID: <4D7884DA.4040409@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080502060804070905010802"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CC9E103803
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2011 08:59:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080502060804070905010802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi, would you like to give this one a thought to make sure I 
haven't missed any case where this verb is needed. For both models (amic 
and dmic), the verb is re-issued, and the autoparser would either add a 
mux, or at least set it to a correct start.

The stable-cc (2.6.38+) is set that way because we tried it on top of 
2.6.35 and it didn't work on the particular machine. I don't know about 
2.6.36 or 2.6.37.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------080502060804070905010802
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Remove-over-initialization-of-mux-in-ALC269.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Remove-over-initialization-of-mux-in-ALC269.pa";
 filename*1="tch"

>From a6f6fa6a49d14bd1f85042a2575b607233c2a91d Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 9 Mar 2011 10:06:17 +0100
Subject: [PATCH] ALSA: HDA: Remove over-initialization of mux in ALC269VB

This initialization verb breaks the automatic mux setup in some
cases (e g just one internal mic and nothing else), and it's not
needed as both laptop_amic and laptop_dmic models set this verb
anyway.

Cc: stable@kernel.org (2.6.38+)
BugLink: http://bugs.launchpad.net/bugs/732445
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 33346c1..cf66d0f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -14574,11 +14574,6 @@ static struct hda_verb alc269vb_init_verbs[] = {
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 
-	/* FIXME: use Mux-type input source selection */
-	/* Mixer elements: 0x18, 19, 1a, 1b, 1d, 0b */
-	/* Input mixer1: unmute Mic, F-Mic, Line, CD inputs */
-	{0x22, AC_VERB_SET_CONNECT_SEL, 0x00},
-
 	/* set EAPD */
 	{0x14, AC_VERB_SET_EAPD_BTLENABLE, 2},
 	{ }
-- 
1.7.1


--------------080502060804070905010802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080502060804070905010802--
