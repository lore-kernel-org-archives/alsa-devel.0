From: murray.alex@gmail.com
Subject: [PATCH - hda 1/1] ALSA: hda - Add PCI quirk for 17"
	MacBook Pro 5, 2 model (July 2009) to use existing mb5 model
Date: Thu, 21 Jan 2010 22:16:26 +1030
Message-ID: <4b583eaa.0d0bca0a.753e.37fc@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Alex Murray <murray.alex@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Alex Murray <murray.alex@gmail.com>


Signed-off-by: Alex Murray <murray.alex@gmail.com>
---
 pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/pci/hda/patch_realtek.c b/pci/hda/patch_realtek.c
index 7e0ea37..d044db9 100644
--- a/pci/hda/patch_realtek.c
+++ b/pci/hda/patch_realtek.c
@@ -9223,6 +9223,7 @@ static struct snd_pci_quirk alc882_ssid_cfg_tbl[] = {
 	 */
 	SND_PCI_QUIRK(0x106b, 0x4000, "MacbookPro 5,1", ALC885_MB5),
 	SND_PCI_QUIRK(0x106b, 0x4600, "MacbookPro 5,2", ALC885_MB5),
+	SND_PCI_QUIRK(0x10ec, 0x0885, "MacbookPro 5,2", ALC885_MB5),
 	{} /* terminator */
 };
 
-- 
1.6.3.3
