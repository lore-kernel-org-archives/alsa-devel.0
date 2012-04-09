From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH 23/26] ALSA: riptide: remove redundant NULL
 test before release_firmware()
Date: Mon, 9 Apr 2012 22:52:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204092241550.14420@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1204092157340.13925@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115]) by alsa0.perex.cz (Postfix) with ESMTP id 3DCC624560
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Apr 2012 22:52:11 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1204092157340.13925@swampdragon.chaosbits.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, trivial@kernel.org, Takashi Iwai <tiwai@suse.de>, Rusty Russell <rusty@rustcorp.com.au>, Clemens Ladisch <clemens@ladisch.de>, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: alsa-devel@alsa-project.org

release_firmware() deals gracefully with NULL pointers, no need to check first.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 sound/pci/riptide/riptide.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 0481d94..cbeb3f7 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1837,8 +1837,7 @@ static int snd_riptide_free(struct snd_riptide *chip)
 	}
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
-	if (chip->fw_entry)
-		release_firmware(chip->fw_entry);
+	release_firmware(chip->fw_entry);
 	release_and_free_resource(chip->res_port);
 	kfree(chip);
 	return 0;
-- 
1.7.10


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
