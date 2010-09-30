From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: via_dmapos_patch
Date: Thu, 30 Sep 2010 10:39:30 +0200
Message-ID: <4CA44CC2.9080701@canonical.com>
References: <4CA2F579.201@canonical.com> <s5hr5gben07.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010901080501010700060808"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 4707A10391D
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 10:39:31 +0200 (CEST)
In-Reply-To: <s5hr5gben07.wl%tiwai@suse.de>
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
Cc: Joseph Chan <josephchan@via.com.tw>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010901080501010700060808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2010-09-30 08:58, Takashi Iwai wrote:
> At Wed, 29 Sep 2010 10:14:49 +0200,
> David Henningsson wrote:
>>
>> I'm researching a few bugs where the user claims position_fix=1 helps
>> the problem, but adding the quirk for that model surprisingly didn't. So
>> looking at the code, I concluded that the difference was
>> via_dmapos_patch, and that they all had via_dmapos_patch=1, and that
>> via_dmapos_patch=0 helped them solve the problem. Three out of five (not
>> all of them have reported back on via_dmapos_patch=0 yet) are VIA
>> controllers rev 10.
>>
>> So we now have VIA controllers that need via_dmapos_patch=0.

I'm cc:ing Joseph here. You were the one writing via_dmapos_patch 
originally, could you confirm the suspicion that VIA controller rev 10 
(and possibly more) actually should have via_dmapos_patch turned off?

>>
>> I can think of a few approaches here:
>>
>> 1) since position_fix=1 implicitly sets via_dmapos_patch to 0 (maybe
>> unintentionally), we should add a position_fix=3 meaning lpib +
>> via_dmapos_patch=1
>>
>> 2) figure if something has changed recently (as in "within the last
>> year"...) that has made via_dmapos_patch=1 work worse than before
>>
>> 3) figure out if there are several ATI/VIA controllers that actually
>> never wants the patch.
>>
>> Any thoughts?
>
> All sound as reasonable proposals.
> The 1 is easy.  David, could you care to send a patch?'

Something like this (untested)?

> 2 and 3 aren't trivial, but we can start by disabling via_dmapos
> for recent revisions.Since it can be controlled over a module
> option by the fix 1, it'll be easier to check the regression.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------010901080501010700060808
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Add-position_fix-3-module-option-and-refact.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Add-position_fix-3-module-option-and-refact.pa";
 filename*1="tch"

>From 14a55f26024bc6f2e7c16c3c0bd21a4793b3d5b8 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 30 Sep 2010 10:12:50 +0200
Subject: [PATCH] ALSA: HDA: Add position_fix=3 module option, and refactor related code

What was previously known as via_dmapos_patch, and hard-coded to be
used for VIA and ATI controllers, is now configurable through a module
option. The background is that some VIA controllers seem to prefer
via_dmapos_patch to be turned off.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 Documentation/sound/alsa/HD-Audio.txt |    8 ++++--
 sound/pci/hda/hda_intel.c             |   41 +++++++++++++++-----------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio.txt b/Documentation/sound/alsa/HD-Audio.txt
index 278cc21..7d58e60 100644
--- a/Documentation/sound/alsa/HD-Audio.txt
+++ b/Documentation/sound/alsa/HD-Audio.txt
@@ -57,9 +57,11 @@ dead.  However, this detection isn't perfect on some devices.  In such
 a case, you can change the default method via `position_fix` option.
 
 `position_fix=1` means to use LPIB method explicitly.
-`position_fix=2` means to use the position-buffer.  0 is the default
-value, the automatic check and fallback to LPIB as described in the
-above.  If you get a problem of repeated sounds, this option might
+`position_fix=2` means to use the position-buffer.
+`position_fix=3` means to use a combination of both methods, needed
+for some VIA and ATI controllers.  0 is the default value for all other
+controllers, the automatic check and fallback to LPIB as described in
+the above.  If you get a problem of repeated sounds, this option might
 help.
 
 In addition to that, every controller is known to be broken regarding
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ec07e47..38b063e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -78,8 +78,8 @@ MODULE_PARM_DESC(enable, "Enable Intel HD audio interface.");
 module_param_array(model, charp, NULL, 0444);
 MODULE_PARM_DESC(model, "Use the given board model.");
 module_param_array(position_fix, int, NULL, 0444);
-MODULE_PARM_DESC(position_fix, "Fix DMA pointer "
-		 "(0 = auto, 1 = none, 2 = POSBUF).");
+MODULE_PARM_DESC(position_fix, "DMA pointer read method."
+		 "(0 = auto, 1 = LPIB, 2 = POSBUF, 3 = VIACOMBO).");
 module_param_array(bdl_pos_adj, int, NULL, 0644);
 MODULE_PARM_DESC(bdl_pos_adj, "BDL position adjustment offset.");
 module_param_array(probe_mask, int, NULL, 0444);
@@ -305,6 +305,7 @@ enum {
 	POS_FIX_AUTO,
 	POS_FIX_LPIB,
 	POS_FIX_POSBUF,
+	POS_FIX_VIACOMBO,
 };
 
 /* Defines for ATI HD Audio support in SB450 south bridge */
@@ -433,7 +434,6 @@ struct azx {
 	unsigned int polling_mode :1;
 	unsigned int msi :1;
 	unsigned int irq_pending_warned :1;
-	unsigned int via_dmapos_patch :1; /* enable DMA-position fix for VIA */
 	unsigned int probing :1; /* codec probing phase */
 
 	/* for debugging */
@@ -1309,11 +1309,8 @@ static int azx_setup_controller(struct azx *chip, struct azx_dev *azx_dev)
 	azx_sd_writel(azx_dev, SD_BDLPU, upper_32_bits(azx_dev->bdl.addr));
 
 	/* enable the position buffer */
-	if (chip->position_fix[0] == POS_FIX_POSBUF ||
-	    chip->position_fix[0] == POS_FIX_AUTO ||
-	    chip->position_fix[1] == POS_FIX_POSBUF ||
-	    chip->position_fix[1] == POS_FIX_AUTO ||
-	    chip->via_dmapos_patch) {
+	if (chip->position_fix[0] != POS_FIX_LPIB ||
+	    chip->position_fix[1] != POS_FIX_LPIB) {
 		if (!(azx_readl(chip, DPLBASE) & ICH6_DPLBASE_ENABLE))
 			azx_writel(chip, DPLBASE,
 				(u32)chip->posbuf.addr | ICH6_DPLBASE_ENABLE);
@@ -1852,20 +1849,21 @@ static unsigned int azx_get_position(struct azx *chip,
 				     struct azx_dev *azx_dev)
 {
 	unsigned int pos;
+	int stream = azx_dev->substream->stream;
 
-	if (chip->via_dmapos_patch)
+	switch (chip->position_fix[stream]) {
+	case POS_FIX_LPIB:
+		/* read LPIB */
+		pos = azx_sd_readl(azx_dev, SD_LPIB);
+		break;
+	case POS_FIX_VIACOMBO:
 		pos = azx_via_get_position(chip, azx_dev);
-	else {
-		int stream = azx_dev->substream->stream;
-		if (chip->position_fix[stream] == POS_FIX_POSBUF ||
-		    chip->position_fix[stream] == POS_FIX_AUTO) {
-			/* use the position buffer */
-			pos = le32_to_cpu(*azx_dev->posbuf);
-		} else {
-			/* read LPIB */
-			pos = azx_sd_readl(azx_dev, SD_LPIB);
-		}
+		break;
+	default:
+		/* use the position buffer */
+		pos = le32_to_cpu(*azx_dev->posbuf);
 	}
+
 	if (pos >= azx_dev->bufsize)
 		pos = 0;
 	return pos;
@@ -2313,6 +2311,7 @@ static int __devinit check_position_fix(struct azx *chip, int fix)
 	switch (fix) {
 	case POS_FIX_LPIB:
 	case POS_FIX_POSBUF:
+	case POS_FIX_VIACOMBO:
 		return fix;
 	}
 
@@ -2320,11 +2319,9 @@ static int __devinit check_position_fix(struct azx *chip, int fix)
 	switch (chip->driver_type) {
 	case AZX_DRIVER_VIA:
 	case AZX_DRIVER_ATI:
-		chip->via_dmapos_patch = 1;
 		/* Use link position directly, avoid any transfer problem. */
-		return POS_FIX_LPIB;
+		return POS_FIX_VIACOMBO;
 	}
-	chip->via_dmapos_patch = 0;
 
 	q = snd_pci_quirk_lookup(chip->pci, position_fix_list);
 	if (q) {
-- 
1.7.1


--------------010901080501010700060808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010901080501010700060808--
