From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: hdspm: fix spelling mistake
	"Initializeing" -> "Initializing"
Date: Sun, 26 Aug 2018 23:09:52 +0100
Message-ID: <20180826220952.12335-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B28026777F
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 00:09:57 +0200 (CEST)
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

Trivial fix to spelling mistake in dev_dbg message and also remove
extraneous white space and repeated question marks.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/rme9652/hdspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 11b5b5e0e058..679ad0415e3b 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6534,7 +6534,7 @@ static int snd_hdspm_create_alsa_devices(struct snd_card *card,
 	dev_dbg(card->dev, "Update mixer controls...\n");
 	hdspm_update_simple_mixer_controls(hdspm);
 
-	dev_dbg(card->dev, "Initializeing complete ???\n");
+	dev_dbg(card->dev, "Initializing complete?\n");
 
 	err = snd_card_register(card);
 	if (err < 0) {
-- 
2.17.1
