From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ALSA: compress: Use snd_compr_get_poll on
	error path
Date: Wed, 4 May 2016 14:59:08 +0100
Message-ID: <1462370351-15388-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1462370351-15388-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id F0598265134
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 16:12:53 +0200 (CEST)
In-Reply-To: <1462370351-15388-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We have a function that returns the appropriate flags for the stream
direction, so we should use it.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/core/compress_offload.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index a9933c07..5268546 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -421,10 +421,7 @@ static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
 			retval = snd_compr_get_poll(stream);
 		break;
 	default:
-		if (stream->direction == SND_COMPRESS_PLAYBACK)
-			retval = POLLOUT | POLLWRNORM | POLLERR;
-		else
-			retval = POLLIN | POLLRDNORM | POLLERR;
+		retval = snd_compr_get_poll(stream) | POLLERR;
 		break;
 	}
 out:
-- 
2.1.4
