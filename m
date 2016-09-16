From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: au88x0: Add missing \n to end of dev_err message
Date: Fri, 16 Sep 2016 11:09:25 +0100
Message-ID: <20160916100925.25282-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trival fix, the dev_err message is missing a \n so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/au88x0/au88x0_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index d3125c1..e1af24f 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -1043,7 +1043,7 @@ static void vortex_fifo_init(vortex_t * vortex)
 	for (x = NR_ADB - 1; x >= 0; x--) {
 		hwwrite(vortex->mmio, addr, (FIFO_U0 | FIFO_U1));
 		if (hwread(vortex->mmio, addr) != (FIFO_U0 | FIFO_U1))
-			dev_err(vortex->card->dev, "bad adb fifo reset!");
+			dev_err(vortex->card->dev, "bad adb fifo reset!\n");
 		vortex_fifo_clearadbdata(vortex, x, FIFO_SIZE);
 		addr -= 4;
 	}
-- 
2.9.3
