From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] ALSA: hda: Add Intel NUC5i7RY to the
	power_save blacklist
Date: Sun, 13 May 2018 14:48:13 +0100
Message-ID: <20180513134814.26845-2-hdegoede@redhat.com>
References: <20180513134814.26845-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id ADE73267673
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 15:48:21 +0200 (CEST)
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

Power-saving is causing a humming sound when active on the Intel
NUC5i7RY, add it to the blacklist.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199607
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 7ca29b890425..0981c3c64d87 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2212,6 +2212,8 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	SND_PCI_QUIRK(0x1849, 0x0c0c, "Asrock B85M-ITX", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=199607 */
+	SND_PCI_QUIRK(0x8086, 0x2057, "Intel NUC5i7RYB", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
 	{}
-- 
2.17.0
