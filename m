From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/4] ALSA: hda: Add ASRock H81M-HDS to the
	power_save blacklist
Date: Wed, 23 May 2018 15:27:05 +0200
Message-ID: <20180523132705.13888-4-hdegoede@redhat.com>
References: <20180523132705.13888-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 9042C267282
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 15:27:11 +0200 (CEST)
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

Power-saving is causing plops on audio start/stop on ASRock H81M-HDS
machines, add these to the power_save blacklist.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1525104
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c98ed35b8bdf..b906dcbb9005 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2209,6 +2209,8 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1025, 0x013f, "Acer Aspire 5930G", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
+	SND_PCI_QUIRK(0x1849, 0x7662, "Asrock H81M-HDS", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1849, 0x0c0c, "Asrock B85M-ITX", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
-- 
2.17.0
