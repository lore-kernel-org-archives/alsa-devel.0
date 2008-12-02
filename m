From: Andy Whitcroft <apw@canonical.com>
Subject: [PATCH 1/1] intel hda: add model dell-m6 quirk for the
	Dell Studio 15 (1537)
Date: Tue,  2 Dec 2008 12:41:02 +0000
Message-ID: <1228221662-23377-1-git-send-email-apw@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3096B245DA
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 13:41:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Andy Whitcroft <apw@canonical.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sort out the headphone connections for the Dell Studio 15 (1537), by
default there is no sound from this socket.  This seems to have the same
wiring as a dell-m6.  Automatically detect and select that model.

Signed-off-by: Andy Whitcroft <apw@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 243f8de..7760636 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1325,6 +1325,8 @@ static struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {
 				"unknown Dell", STAC_DELL_M6),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0271,
 				"unknown Dell", STAC_DELL_M6),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x029f,
+				"unknown Dell", STAC_DELL_M6),
 	{} /* terminator */
 };
 
-- 
1.6.0.4.911.gc990
