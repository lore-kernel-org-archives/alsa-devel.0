From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ALSA: au88x0: avoid theoretical uninitialized
	access
Date: Thu, 23 Mar 2017 16:15:55 +0100
Message-ID: <20170323151607.636485-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 10F56266A33
 for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2017 16:16:17 +0100 (CET)
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
Cc: Colin Ian King <colin.king@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

The latest gcc-7.0.1 snapshot points out that we if nr_ch is zero, we never
initialize some variables:

sound/pci/au88x0/au88x0_core.c: In function 'vortex_adb_allocroute':
sound/pci/au88x0/au88x0_core.c:2304:68: error: 'mix[0]' may be used uninitialized in this function [-Werror=maybe-uninitialized]
sound/pci/au88x0/au88x0_core.c:2305:58: error: 'src[0]' may be used uninitialized in this function [-Werror=maybe-uninitialized]

I assume this can never happen in practice, but adding a check here doesn't
hurt either and avoids the warning. The code has been unchanged since
the start of git history.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/au88x0/au88x0_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index e1af24f87566..c308a4f70550 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -2279,6 +2279,9 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 	} else {
 		int src[2], mix[2];
 
+		if (nr_ch < 1)
+			return -EINVAL;
+
 		/* Get SRC and MIXER hardware resources. */
 		for (i = 0; i < nr_ch; i++) {
 			if ((mix[i] =
-- 
2.9.0
