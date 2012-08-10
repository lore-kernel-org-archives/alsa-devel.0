From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: cs46xx - signedness bug in
	snd_cs46xx_codec_read()
Date: Fri, 10 Aug 2012 12:22:58 +0300
Message-ID: <20120810092258.GA26875@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
 by alsa0.perex.cz (Postfix) with ESMTP id B45AE2664BE
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 10:53:33 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This function returns its own error codes instead of normal negative
error codes.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index f75f5ff..a71d1c1 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -94,7 +94,7 @@ static unsigned short snd_cs46xx_codec_read(struct snd_cs46xx *chip,
 
 	if (snd_BUG_ON(codec_index != CS46XX_PRIMARY_CODEC_INDEX &&
 		       codec_index != CS46XX_SECONDARY_CODEC_INDEX))
-		return -EINVAL;
+		return 0xffff;
 
 	chip->active_ctrl(chip, 1);
 
