From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 21/29] mixer: change code formatting for
	init_db_range()
Date: Fri, 15 Jul 2016 09:23:25 +0900
Message-ID: <1468542213-24880-22-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 5E05626668F
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 02:23:41 +0200 (CEST)
In-Reply-To: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit applies code format according to typical and moderate rule.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/mixer/simple_none.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 4bd231c..05dde41 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -1112,10 +1112,10 @@ static int init_db_range(snd_hctl_elem_t *ctl, struct selem_str *rec)
 	snd_ctl_elem_info_alloca(&info);
 	if (snd_hctl_elem_info(ctl, info) < 0)
 		goto error;
-	if (! snd_ctl_elem_info_is_tlv_readable(info))
+	if (!snd_ctl_elem_info_is_tlv_readable(info))
 		goto error;
 	tlv = malloc(tlv_size);
-	if (! tlv)
+	if (!tlv)
 		return -ENOMEM;
 	if (snd_hctl_elem_tlv_read(ctl, tlv, tlv_size) < 0)
 		goto error;
-- 
2.7.4
