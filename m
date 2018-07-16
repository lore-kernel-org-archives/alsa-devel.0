From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: ali5451: remove redundant pointer 'codec'
Date: Mon, 16 Jul 2018 09:57:38 +0100
Message-ID: <20180716085738.16041-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 04B9B267688
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 10:57:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'codec' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'codec' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/ali5451/ali5451.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 39547e32e584..9f569379b77e 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -1484,12 +1484,9 @@ static struct snd_pcm_hardware snd_ali_capture =
 static void snd_ali_pcm_free_substream(struct snd_pcm_runtime *runtime)
 {
 	struct snd_ali_voice *pvoice = runtime->private_data;
-	struct snd_ali *codec;
 
-	if (pvoice) {
-		codec = pvoice->codec;
+	if (pvoice)
 		snd_ali_free_voice(pvoice->codec, pvoice);
-	}
 }
 
 static int snd_ali_open(struct snd_pcm_substream *substream, int rec,
-- 
2.17.1
