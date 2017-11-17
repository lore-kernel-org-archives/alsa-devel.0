From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/4] ALSA: riptide: Reduce the scope for two
 variables in snd_riptide_proc_read()
Date: Fri, 17 Nov 2017 10:50:23 +0100
Message-ID: <2362b245-fcde-3327-11e1-f54985c95dd6@users.sourceforge.net>
References: <0eef2699-f28a-c1e0-9351-268b5eb7e0c1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 51680266B67
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 10:50:32 +0100 (CET)
In-Reply-To: <0eef2699-f28a-c1e0-9351-268b5eb7e0c1@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, David Howells <dhowells@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 17 Nov 2017 09:55:27 +0100

Move the definitions for the local variables "lval" and "rval" into
an if branch so that the corresponding setting will only be performed
on concrete demand in this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/riptide/riptide.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 3d00488ff137..774fba5bba48 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1921,5 +1921,4 @@ snd_riptide_proc_read(struct snd_info_entry *entry,
 	unsigned char p[256];
-	unsigned short rval = 0, lval = 0;
 	unsigned int rate;
 
 	if (!chip)
@@ -1934,6 +1933,8 @@ snd_riptide_proc_read(struct snd_info_entry *entry,
 
 	cif = chip->cif;
 	if (cif) {
+		unsigned short rval = 0, lval = 0;
+
 		snd_iprintf(buffer,
 			    "\nVersion: ASIC: %d CODEC: %d AUXDSP: %d PROG: %d",
 			    chip->firmware.firmware.ASIC,
-- 
2.15.0
