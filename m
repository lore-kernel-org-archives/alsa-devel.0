From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/4] ALSA: hda: Add Gigabyte P55A-UD3 and
	Z87-D3HP to the power_save blacklist
Date: Wed, 23 May 2018 15:27:04 +0200
Message-ID: <20180523132705.13888-3-hdegoede@redhat.com>
References: <20180523132705.13888-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id D43FE267265
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 15:27:10 +0200 (CEST)
In-Reply-To: <20180523132705.13888-1-hdegoede@redhat.com>
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

Power-saving is causing plops on audio start/stop on Gigabyte
P55A-UD3 and Gigabyte Z87-D3HP machines, add these to the power_save
blacklist.

Note these 2 boards both use 1458:a002 as subsystem ids, so they share
a single entry.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1525104
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 744a255b50d9..c98ed35b8bdf 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2214,6 +2214,9 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1581607 */
 	SND_PCI_QUIRK(0x1558, 0x3501, "Clevo W35xSS_370SS", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
+	/* Note the P55A-UD3 and Z87-D3HP share the subsys id for the HDA dev */
+	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte P55A-UD3 / Z87-D3HP", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=199607 */
 	SND_PCI_QUIRK(0x8086, 0x2057, "Intel NUC5i7RYB", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1520902 */
-- 
2.17.0
