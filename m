From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 06/12] pcm: hw: use helper function to
	query status/control data after REWIND/FORWARD call
Date: Fri, 30 Jun 2017 08:58:22 +0900
Message-ID: <20170629235828.18076-7-o-takashi@sakamocchi.jp>
References: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 835492673FE
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 01:58:35 +0200 (CEST)
In-Reply-To: <20170629235828.18076-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When operating rewind/forward, appl_ptr is recalculated by ALSA PCM core
in kernel space. Therefore, after the operations, applications should
query appl_ptr.

This commit utilizes a helper function for this purpose. The value of
avail_min is relevant to this operation, thus just queried.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 6f20cbff..59ba33b5 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -702,7 +702,7 @@ static snd_pcm_sframes_t snd_pcm_hw_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t fra
 		SYSMSG("SNDRV_PCM_IOCTL_REWIND failed (%i)", err);
 		return err;
 	}
-	err = sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL);
+	err = query_state(hw);
 	if (err < 0)
 		return err;
 	return frames;
@@ -723,7 +723,7 @@ static snd_pcm_sframes_t snd_pcm_hw_forward(snd_pcm_t *pcm, snd_pcm_uframes_t fr
 			SYSMSG("SNDRV_PCM_IOCTL_FORWARD failed (%i)", err);
 			return err;
 		}
-		err = sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL);
+		err = query_state(hw);
 		if (err < 0)
 			return err;
 		return frames;
-- 
2.11.0
