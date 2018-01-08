From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: pcm: Abort properly at pending
	signal in OSS read/write loops
Date: Mon,  8 Jan 2018 15:25:40 +0100
Message-ID: <20180108142541.18098-2-tiwai@suse.de>
References: <20180108142541.18098-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C465267396
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 15:25:49 +0100 (CET)
In-Reply-To: <20180108142541.18098-1-tiwai@suse.de>
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
Cc: Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

The loops for read and write in PCM OSS emulation have no proper check
of pending signals, and they keep processing even after user tries to
break.  This results in a very long delay, often seen as RCU stall
when a huge unprocessed bytes remain queued.  The bug could be easily
triggered by syzkaller.

As a simple workaround, this patch adds the proper check of pending
signals and aborts the loop appropriately.

Reported-by: syzbot+993cb4cfcbbff3947c21@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_oss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index ceaa51f76591..e317964bd2ea 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1381,6 +1381,10 @@ static ssize_t snd_pcm_oss_write1(struct snd_pcm_substream *substream, const cha
 			    tmp != runtime->oss.period_bytes)
 				break;
 		}
+		if (signal_pending(current)) {
+			tmp = -ERESTARTSYS;
+			goto err;
+		}
 	}
 	mutex_unlock(&runtime->oss.params_lock);
 	return xfer;
@@ -1466,6 +1470,10 @@ static ssize_t snd_pcm_oss_read1(struct snd_pcm_substream *substream, char __use
 			bytes -= tmp;
 			xfer += tmp;
 		}
+		if (signal_pending(current)) {
+			tmp = -ERESTARTSYS;
+			goto err;
+		}
 	}
 	mutex_unlock(&runtime->oss.params_lock);
 	return xfer;
-- 
2.15.1
