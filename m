From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: au88x0: remove redundant assignment of
	variable i
Date: Tue, 17 Oct 2017 12:53:21 +0100
Message-ID: <20171017115321.19713-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 62F87266EB0
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 13:53:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The assignment to variable i is redundant as it is never read
because it is updated a little later on. Remove this assignment.
Cleans up clang warning: Value stored to 'i' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/au88x0/au88x0_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index c308a4f70550..4083c8b01619 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -2628,7 +2628,7 @@ static void vortex_spdif_init(vortex_t * vortex, int spdif_sr, int spdif_mode)
 			else
 				edi = 0x1ffff;
 		} else {
-			i = edi = 0x800;
+			edi = 0x800;
 		}
 		/* this_04 and this_08 are the CASp4Src's (samplerate converters) */
 		vortex_src_setupchannel(vortex, this_04, edi, 0, 1,
-- 
2.14.1
