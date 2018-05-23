From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/4] ALSA: hda: Add Intel NUC7i3BNB to the
	power_save blacklist
Date: Wed, 23 May 2018 15:27:02 +0200
Message-ID: <20180523132705.13888-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E40726705D
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 15:27:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Power-saving is causing a humming sound when active on the Intel
NUC7i3BNB, add it to the blacklist.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1520902
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9a16af179503..7cf4e1a96cab 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2214,6 +2214,8 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=199607 */
 	SND_PCI_QUIRK(0x8086, 0x2057, "Intel NUC5i7RYB", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1520902 */
+	SND_PCI_QUIRK(0x8086, 0x2068, "Intel NUC7i3BNB", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
 	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
-- 
2.17.0
