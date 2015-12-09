From: Gabriele Martino <g.martino@gmx.com>
Subject: Re: Intel HDA / ca0132: quirk for Alienware 17 2015
Date: Wed, 9 Dec 2015 17:05:58 +0100
Message-ID: <56685166.2070200@gmx.com>
References: <56670AF0.2090306@gmx.com> <s5h1taw17rf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050202030505070607000705"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 6773826058D
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 17:04:39 +0100 (CET)
In-Reply-To: <s5h1taw17rf.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050202030505070607000705
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

The Alienware 17 (2015) has the same card and pin configuration of the
Alienware 15, so the same quirks must be applied.

Signed-off-by: Gabriele Martino <g.martino@gmx.com>


--------------050202030505070607000705
Content-Type: text/x-patch;
 name="ca0132-quirk-alienware17.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ca0132-quirk-alienware17.patch"

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index f8a12ca..4ef2259 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -778,7 +778,8 @@ static const struct hda_pintbl alienware_pincfgs[] = {
 };
 
 static const struct snd_pci_quirk ca0132_quirks[] = {
-	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15", QUIRK_ALIENWARE),
+	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15 2015", QUIRK_ALIENWARE),
+	SND_PCI_QUIRK(0x1028, 0x0688, "Alienware 17 2015", QUIRK_ALIENWARE),
 	{}
 };
 

--------------050202030505070607000705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050202030505070607000705--
