From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: vx_core: off by one in vx_read_status()
Date: Fri, 21 Jun 2013 15:25:33 +0300
Message-ID: <20130621122533.GA24059@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FED326556B
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 14:25:44 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This code is older than git, and I haven't tested it, but if size ==
SIZE_MAX_STATUS then we would write one space past the end of the
rmh->Stat[] array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/drivers/vx/vx_core.c b/sound/drivers/vx/vx_core.c
index c39961c..8359689 100644
--- a/sound/drivers/vx/vx_core.c
+++ b/sound/drivers/vx/vx_core.c
@@ -205,7 +205,7 @@ static int vx_read_status(struct vx_core *chip, struct vx_rmh *rmh)
 
 	if (size < 1)
 		return 0;
-	if (snd_BUG_ON(size > SIZE_MAX_STATUS))
+	if (snd_BUG_ON(size >= SIZE_MAX_STATUS))
 		return -EINVAL;
 
 	for (i = 1; i <= size; i++) {
