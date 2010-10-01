From: valentine.sinitsyn@gmail.com
Subject: [PATCH - Realtek HDA Codec 1/1] Added fixup for Lenovo
	Y550P
Date: Fri,  1 Oct 2010 22:24:08 +0600
Message-ID: <1285950248-4114-1-git-send-email-valentine.sinitsyn@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>


Signed-off-by: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3b04087..124d52f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -19074,6 +19074,7 @@ static const struct alc_fixup alc662_fixups[] = {
 
 static struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
+	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	{}
 };
 
-- 
1.7.3.1
