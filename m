From: David Henningsson <david.henningsson@canonical.com>
Subject: Model=auto for LG R510
Date: Tue, 10 Aug 2010 09:24:56 +0200
Message-ID: <4C60FEC8.3010207@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040608090104040106090302"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 7132924492
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 09:24:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040608090104040106090302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I've got two users saying model=auto is working better for them (it
enables the internal mic and no regressions). I don't know if that is
enough to remove an existing quirk, but if it is, please apply the
attached patch.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040608090104040106090302
Content-Type: text/x-patch;
 name="0007-HDA-Use-model-auto-for-LG-R510.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0007-HDA-Use-model-auto-for-LG-R510.patch"

>From 8e19d29534d37b92a1ef63b328144b2a3837852f Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 10 Aug 2010 09:18:00 +0200
Subject: [PATCH] HDA: Use model=auto for LG R510

Two users report model=auto is needed to make the internal mic work properly.
BugLink: https://bugs.launchpad.net/bugs/495134

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6b00a23..55d6e5b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -13477,7 +13477,6 @@ static struct snd_pci_quirk alc268_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x14c0, 0x0025, "COMPAL IFL90/JFL-92", ALC268_TOSHIBA),
 	SND_PCI_QUIRK(0x152d, 0x0763, "Diverse (CPR2000)", ALC268_ACER),
 	SND_PCI_QUIRK(0x152d, 0x0771, "Quanta IL1", ALC267_QUANTA_IL1),
-	SND_PCI_QUIRK(0x1854, 0x1775, "LG R510", ALC268_DELL),
 	{}
 };
 
-- 
1.7.0.4


--------------040608090104040106090302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040608090104040106090302--
