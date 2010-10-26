From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 9/14] sound/oss/sb_ess.c: delete double
	assignment
Date: Tue, 26 Oct 2010 12:25:38 +0200
Message-ID: <1288088743-3725-10-git-send-email-julia@diku.dk>
References: <1288088743-3725-1-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BC66103801
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Oct 2010 12:18:22 +0200 (CEST)
In-Reply-To: <1288088743-3725-1-git-send-email-julia@diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

Delete successive assignments to the same location.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression i;
@@

*i = ...;
 i = ...;
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/oss/sb_ess.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/oss/sb_ess.c b/sound/oss/sb_ess.c
index 51a3d38..9890cf2 100644
--- a/sound/oss/sb_ess.c
+++ b/sound/oss/sb_ess.c
@@ -1722,7 +1722,6 @@ printk (KERN_INFO "FKS: es_rec_set_recmask mask = %x\n", mask);
 				right = (value & 0x0000ff00) >> 8;
 			} else {				/* Turn it off (3)  */
 				left  = 0;
-				left  = 0;
 				right = 0;
 			}
 			sb_common_mixer_set(devc, i + ES_REC_MIXER_RECDIFF, left, right);
