From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 3/5]alsa:patch_realtek.c Add SSID table for
	MacBookAir1, 1
Date: Sun,  6 Jun 2010 16:09:51 -0700
Message-ID: <1275865793-7357-3-git-send-email-justinmattock@gmail.com>
References: <1275865793-7357-1-git-send-email-justinmattock@gmail.com>
	<1275865793-7357-2-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 9C8DD24339
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 01:09:51 +0200 (CEST)
Received: by mail-pv0-f179.google.com with SMTP id 4so1459941pva.38
	for <alsa-devel@alsa-project.org>; Sun, 06 Jun 2010 16:09:51 -0700 (PDT)
In-Reply-To: <1275865793-7357-2-git-send-email-justinmattock@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>
List-Id: alsa-devel@alsa-project.org

Note: This patch does not work with Patch 2/5
(Add-support-for-the-MacBookAir1-1).

This patch add's the MacBookAir1,1 SSID entry to
patch_realtek.c which adds sound support.
bug entry:
https://bugs.launchpad.net/mactel-support/+bug/268301

Note:I do not have this machine on hand only
codec#0 file for the machine so please
test if you have the appropriate equipment.

 Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 Documentation/sound/alsa/HD-Audio-Models.txt |    1 +
 sound/pci/hda/patch_realtek.c                |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 1d38b0d..d3838b5 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -125,6 +125,7 @@ ALC882/883/885/888/889
   macpro	MacPro support
   mb5		Macbook 5,1
   macmini3	Macmini 3,1
+  mba11		MacBook Air 1,1
   mba21		Macbook Air 2,1
   mbp3		Macbook Pro rev3
   imac24	iMac 24'' with jack detection
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 17d4548..149b375 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9487,6 +9487,7 @@ static struct snd_pci_quirk alc882_ssid_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x106b, 0x4000, "MacbookPro 5,1", ALC885_MB5),
 	SND_PCI_QUIRK(0x106b, 0x4600, "MacbookPro 5,2", ALC885_MB5),
 	SND_PCI_QUIRK(0x106b, 0x4100, "Macmini 3,1", ALC885_MACMINI3),
+	SND_PCI_QUIRK(0x106b, 0x3400, "MacBookAir 1,1", ALC885_MBP3),
 	{} /* terminator */
 };
 
-- 
1.6.5.2.180.gc5b3e
