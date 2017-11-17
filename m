From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/4] ALSA: riptide: Delete an unnecessary
 variable initialisation in snd_riptide_proc_read()
Date: Fri, 17 Nov 2017 10:49:12 +0100
Message-ID: <1662947b-17be-10f4-50ef-2902d9470f53@users.sourceforge.net>
References: <0eef2699-f28a-c1e0-9351-268b5eb7e0c1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id ED21F266B67
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 10:49:21 +0100 (CET)
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
Date: Fri, 17 Nov 2017 09:50:52 +0100

The variable "cif" will be set to an appropriate pointer a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/riptide/riptide.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 22d15ea7e210..3d00488ff137 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1917,5 +1917,5 @@ snd_riptide_proc_read(struct snd_info_entry *entry,
 	struct snd_riptide *chip = entry->private_data;
 	struct pcmhw *data;
 	int i;
-	struct cmdif *cif = NULL;
+	struct cmdif *cif;
 	unsigned char p[256];
-- 
2.15.0
