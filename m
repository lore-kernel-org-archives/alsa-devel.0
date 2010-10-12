From: David Henningsson <david.henningsson@canonical.com>
Subject: [RESEND] [PATCH] ALSA: HDA: Correctly apply
 position_fix quirks for ATI and VIA controllers
Date: Tue, 12 Oct 2010 12:36:45 +0200
Message-ID: <4CB43A3D.20702@canonical.com>
References: <4CA9A951.2010604@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090607090605080508040608"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F9FD1039C9
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 12:36:47 +0200 (CEST)
In-Reply-To: <4CA9A951.2010604@canonical.com>
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
--------------090607090605080508040608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This one never got picked up when I posted it a week ago.

On 2010-10-04 12:15, David Henningsson wrote:
> Position_fix quirks for specific machines now override the default
> position_fix behavior for all HDA controllers.
>
> BugLink: http://launchpad.net/bugs/465942
> BugLink: http://launchpad.net/bugs/580749
> BugLink: http://launchpad.net/bugs/587546
>
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------090607090605080508040608
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Correctly-apply-position_fix-quirks-for-ATI.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Correctly-apply-position_fix-quirks-for-ATI.pa";
 filename*1="tch"

>From b36e71f568c26ab11909454c5bf8bc5d47dbf025 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 4 Oct 2010 12:02:14 +0200
Subject: [PATCH] ALSA: HDA: Correctly apply position_fix quirks for ATI and VIA controllers

Position_fix quirks for specific machines now override the default
position_fix behavior for all HDA controllers.

BugLink: http://launchpad.net/bugs/465942
BugLink: http://launchpad.net/bugs/580749
BugLink: http://launchpad.net/bugs/587546

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_intel.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 38b063e..5cbea85 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2315,14 +2315,6 @@ static int __devinit check_position_fix(struct azx *chip, int fix)
 		return fix;
 	}
 
-	/* Check VIA/ATI HD Audio Controller exist */
-	switch (chip->driver_type) {
-	case AZX_DRIVER_VIA:
-	case AZX_DRIVER_ATI:
-		/* Use link position directly, avoid any transfer problem. */
-		return POS_FIX_VIACOMBO;
-	}
-
 	q = snd_pci_quirk_lookup(chip->pci, position_fix_list);
 	if (q) {
 		printk(KERN_INFO
@@ -2331,6 +2323,15 @@ static int __devinit check_position_fix(struct azx *chip, int fix)
 		       q->value, q->subvendor, q->subdevice);
 		return q->value;
 	}
+
+	/* Check VIA/ATI HD Audio Controller exist */
+	switch (chip->driver_type) {
+	case AZX_DRIVER_VIA:
+	case AZX_DRIVER_ATI:
+		/* Use link position directly, avoid any transfer problem. */
+		return POS_FIX_VIACOMBO;
+	}
+
 	return POS_FIX_AUTO;
 }
 
-- 
1.7.1


--------------090607090605080508040608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090607090605080508040608--
