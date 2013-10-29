From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/10] ALSA: pcsp: Fix initialization with
	nopcm=1
Date: Tue, 29 Oct 2013 17:00:25 +0100
Message-ID: <1383062433-9388-3-git-send-email-tiwai@suse.de>
References: <1383062433-9388-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D57492610D3
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9FA4BA5FCA
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

When nopcm=1 is set, some initializations based on hrtimer resolution
might be bogus because the driver checks the resolution only when
nopcm=0.  Simply get the resolution always at first for fixing the
bug.

Spotted by coverity CID 139740.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/pcsp/pcsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 1c19cd7ad26e..f664bae3b9b0 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -46,8 +46,9 @@ static int snd_pcsp_create(struct snd_card *card)
 	int err;
 	int div, min_div, order;
 
+	hrtimer_get_res(CLOCK_MONOTONIC, &tp);
+
 	if (!nopcm) {
-		hrtimer_get_res(CLOCK_MONOTONIC, &tp);
 		if (tp.tv_sec || tp.tv_nsec > PCSP_MAX_PERIOD_NS) {
 			printk(KERN_ERR "PCSP: Timer resolution is not sufficient "
 				"(%linS)\n", tp.tv_nsec);
-- 
1.8.4.1
