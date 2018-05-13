From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] ALSA: hda: Add Lenovo C50 All in one to
	the power_save blacklist
Date: Sun, 13 May 2018 14:48:14 +0100
Message-ID: <20180513134814.26845-3-hdegoede@redhat.com>
References: <20180513134814.26845-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 69327267673
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 15:48:23 +0200 (CEST)
In-Reply-To: <20180513134814.26845-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Power-saving is causing loud plops on the Lenovo C50 All in one, add it
to the blacklist.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1572975
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0981c3c64d87..9a16af179503 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2214,6 +2214,8 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=199607 */
 	SND_PCI_QUIRK(0x8086, 0x2057, "Intel NUC5i7RYB", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
+	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
 	{}
-- 
2.17.0
