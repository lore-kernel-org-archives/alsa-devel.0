From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: sc6000: fix spelling mistake: "iomaped"
	-> "iomapped"
Date: Wed,  2 May 2018 14:59:40 +0100
Message-ID: <20180502135940.30915-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BF5C266C1C
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 15:59:45 +0200 (CEST)
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

Trivial fix to spelling mistake in KERN_ERR error messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/sc6000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index c09d9b914efe..a985e9183be9 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -592,7 +592,7 @@ static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
 	*vport = devm_ioport_map(devptr, port[dev], 0x10);
 	if (*vport == NULL) {
 		snd_printk(KERN_ERR PFX
-			   "I/O port cannot be iomaped.\n");
+			   "I/O port cannot be iomapped.\n");
 		err = -EBUSY;
 		goto err_unmap1;
 	}
@@ -607,7 +607,7 @@ static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
 	vmss_port = devm_ioport_map(devptr, mss_port[dev], 4);
 	if (!vmss_port) {
 		snd_printk(KERN_ERR PFX
-			   "MSS port I/O cannot be iomaped.\n");
+			   "MSS port I/O cannot be iomapped.\n");
 		err = -EBUSY;
 		goto err_unmap2;
 	}
-- 
2.17.0
