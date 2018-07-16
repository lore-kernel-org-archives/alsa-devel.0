From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: cs46xx: remove redundant pointer 'ins'
Date: Mon, 16 Jul 2018 10:03:15 +0100
Message-ID: <20180716090315.16267-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 23BF8267688
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 11:03:18 +0200 (CEST)
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

Pointer 'ins' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'ins' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/cs46xx/dsp_spos_scb_lib.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
index abb01ce66983..8d0a3d357345 100644
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c
@@ -73,13 +73,10 @@ static void cs46xx_dsp_proc_scb_info_read (struct snd_info_entry *entry,
 {
 	struct proc_scb_info * scb_info  = entry->private_data;
 	struct dsp_scb_descriptor * scb = scb_info->scb_desc;
-	struct dsp_spos_instance * ins;
 	struct snd_cs46xx *chip = scb_info->chip;
 	int j,col;
 	void __iomem *dst = chip->region.idx[1].remap_addr + DSP_PARAMETER_BYTE_OFFSET;
 
-	ins = chip->dsp_spos_instance;
-
 	mutex_lock(&chip->spos_mutex);
 	snd_iprintf(buffer,"%04x %s:\n",scb->address,scb->scb_name);
 
-- 
2.17.1
