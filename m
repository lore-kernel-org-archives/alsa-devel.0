From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: mixart: silence an uninitialized variable warning
Date: Wed, 16 Mar 2016 10:42:13 +0300
Message-ID: <20160316074213.GC12860@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, Quentin Lambert <lambert.quentin@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We could print the uninitialized value of "stat" in the error message.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index bc81b9f..25c0ddd 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -132,7 +132,7 @@ static int mixart_set_pipe_state(struct mixart_mgr *mgr,
 	}
 
 	if(start) {
-		u32 stat;
+		u32 stat = 0;
 
 		group_state.pipe_count = 0; /* in case of start same command once again with pipe_count=0 */
 
