From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Do not try to create speaker NIDs for ALC268
 if there aren't any
Date: Mon, 02 Aug 2010 14:48:19 +0200
Message-ID: <4C56BE93.8080305@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040107040505080605020601"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id BD7C310380E
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 14:48:19 +0200 (CEST)
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
--------------040107040505080605020601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The new warning gave a false alarm, now silenced.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040107040505080605020601
Content-Type: text/x-patch;
 name="0006-Do-not-try-to-create-speaker-NIDs-for-ALC268-if-ther.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0006-Do-not-try-to-create-speaker-NIDs-for-ALC268-if-ther.pa";
 filename*1="tch"

>From e2b3d05db4d825701c6033567fc7b89283372f44 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 2 Aug 2010 13:13:25 +0200
Subject: [PATCH] Do not try to create speaker NIDs for ALC268 if there aren't any

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 49c04fc..cf14b00 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -13216,7 +13216,7 @@ static int alc268_auto_create_multi_out_ctls(struct alc_spec *spec,
 				  HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_INPUT));
 		if (err < 0)
 			return err;
-	} else {
+	} else if (nid) {
 		err = alc268_new_analog_output(spec, nid, "Speaker", 0);
 		if (err < 0)
 			return err;
-- 
1.7.0.4


--------------040107040505080605020601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040107040505080605020601--
