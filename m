From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: [PATCH] snd-sbxfi: use SBXXXX model numbers instead of
	user-unfriendly names like UAA and ORIG.
Date: Sat, 18 Oct 2008 19:58:23 -0500
Message-ID: <20081019004820.8D3F0835910@carpathia.dereferenced.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (carpathia.dereferenced.org
	[64.71.161.129])
	by alsa0.perex.cz (Postfix) with ESMTP id DB99E1038A0
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Oct 2008 03:00:39 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

This is just something that bothers me. There's no reason to accept or reject it,
other than that it might be more informative about what hardware revision we are
dealing with.

Signed-off-by: William Pitcock <nenolod@sacredspiral.co.uk>

---
 sound/pci/sbxfi/sbxfi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
index 30ad25b..c006278 100644
--- a/sound/pci/sbxfi/sbxfi.c
+++ b/sound/pci/sbxfi/sbxfi.c
@@ -1702,10 +1702,10 @@ static int __devinit sbxfi_create_mixer(struct sbxfi *chip)
  */
 
 static char *typenames[SBXFI_HW_TYPES] = {
-	[SBXFI_HW_ORIG] = "ORIG",
-	[SBXFI_HW_055x] = "055x",
-	[SBXFI_HW_073x] = "073x",
-	[SBXFI_HW_UAA] = "UAA"
+	[SBXFI_HW_ORIG] = "SB0760",
+	[SBXFI_HW_055x] = "SB0550",
+	[SBXFI_HW_073x] = "SB0730",
+	[SBXFI_HW_UAA] = "SB0886"
 };
 
 #ifdef CONFIG_PROC_FS
-- 
1.5.5.4
