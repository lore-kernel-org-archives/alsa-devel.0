From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ALSA: xen-front: remove redundant error
	check on ret
Date: Sun, 27 May 2018 22:23:12 +0100
Message-ID: <20180527212312.23997-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A6E54267255
 for <alsa-devel@alsa-project.org>; Sun, 27 May 2018 23:23:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The error for a -ve value in ret is redundant as all previous
assignments to ret have an associated -ve check and hence it
is impossible for ret to be less that zero at the point of the
check.  Remove this redundant error check.

Detected by CoveritScan, CID#1469407 ("Logically Dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/xen/xen_snd_front_evtchnl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/xen/xen_snd_front_evtchnl.c b/sound/xen/xen_snd_front_evtchnl.c
index d70a62e7f910..102d6e096cc8 100644
--- a/sound/xen/xen_snd_front_evtchnl.c
+++ b/sound/xen/xen_snd_front_evtchnl.c
@@ -351,8 +351,6 @@ int xen_snd_front_evtchnl_create_all(struct xen_snd_front_info *front_info,
 			}
 		}
 	}
-	if (ret < 0)
-		goto fail;
 
 	front_info->num_evt_pairs = num_streams;
 	return 0;
-- 
2.17.0
