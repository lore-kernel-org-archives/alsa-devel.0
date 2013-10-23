From: Joe Perches <joe@perches.com>
Subject: [PATCH 8/8] sound: Remove OOM message after
	input_allocate_device
Date: Wed, 23 Oct 2013 12:14:54 -0700
Message-ID: <67fa483a408bf2abe0e2fad829f3c496130ae507.1382555436.git.joe@perches.com>
References: <cover.1382555436.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0054.hostedemail.com
 [216.40.44.54]) by alsa0.perex.cz (Postfix) with ESMTP id 2B61C260304
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2013 21:16:09 +0200 (CEST)
In-Reply-To: <cover.1382555436.git.joe@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Emitting an OOM message isn't necessary after input_allocate_device
as there's a generic OOM and a dump_stack already done.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/pci/hda/hda_beep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 63c9909..20d065a 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -151,10 +151,8 @@ static int snd_hda_do_attach(struct hda_beep *beep)
 	int err;
 
 	input_dev = input_allocate_device();
-	if (!input_dev) {
-		printk(KERN_INFO "hda_beep: unable to allocate input device\n");
+	if (!input_dev)
 		return -ENOMEM;
-	}
 
 	/* setup digital beep device */
 	input_dev->name = "HDA Digital PCBeep";
-- 
1.8.1.2.459.gbcd45b4.dirty
