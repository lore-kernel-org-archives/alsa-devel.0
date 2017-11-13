From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/4] ALSA: cs46xx: Improve a size determination
 in cs46xx_dsp_proc_register_scb_desc()
Date: Mon, 13 Nov 2017 19:24:38 +0100
Message-ID: <48771e1a-f520-3f80-16ad-ef2dbcb15a63@users.sourceforge.net>
References: <893b1dc2-d078-9ea6-4ad2-0e0327affddd@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 788FF2673B9
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 19:24:55 +0100 (CET)
In-Reply-To: <893b1dc2-d078-9ea6-4ad2-0e0327affddd@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Fabian Frederick <fabf@skynet.be>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 13 Nov 2017 18:56:58 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/cs46xx/dsp_spos_scb_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
index f9564f42eb09..bccd315e6c18 100644
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c
@@ -260,7 +260,7 @@ void cs46xx_dsp_proc_register_scb_desc (struct snd_cs46xx *chip,
 						   scb->scb_name,
 						   ins->proc_dsp_dir);
 		if (entry) {
-			scb_info = kmalloc(sizeof(struct proc_scb_info), GFP_KERNEL);
+			scb_info = kmalloc(sizeof(*scb_info), GFP_KERNEL);
 			if (!scb_info) {
 				snd_info_free_entry(entry);
 				entry = NULL;
-- 
2.15.0
