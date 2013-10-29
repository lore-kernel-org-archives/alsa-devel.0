From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/10] ALSA: lola: Fix uninitialized variable
	access in error message
Date: Tue, 29 Oct 2013 17:00:33 +0100
Message-ID: <1383062433-9388-11-git-send-email-tiwai@suse.de>
References: <1383062433-9388-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F33102615D1
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A9B46A60F7
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
In-Reply-To: <1383062433-9388-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The FUNCTION_TYPE parameter isn't associated with any NID, thus
showing the uninitialized nid in the error message is simply
nonsense.

Spotted by coverity CID 145068.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/lola/lola.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index 7307d97186cb..0568540dc8d3 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -463,7 +463,7 @@ static int lola_parse_tree(struct lola *chip)
 
 	err = lola_read_param(chip, 1, LOLA_PAR_FUNCTION_TYPE, &val);
 	if (err < 0) {
-		printk(KERN_ERR SFX "Can't read FUNCTION_TYPE for 0x%x\n", nid);
+		printk(KERN_ERR SFX "Can't read FUNCTION_TYPE\n");
 		return err;
 	}
 	if (val != 1) {
-- 
1.8.4.1
