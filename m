From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 6/6] test: use position offset macro
	of TLV data
Date: Tue, 15 May 2018 21:36:39 +0900
Message-ID: <20180515123639.18255-7-o-takashi@sakamocchi.jp>
References: <20180515123639.18255-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f68.google.com (mail-pl0-f68.google.com
 [209.85.160.68])
 by alsa0.perex.cz (Postfix) with ESMTP id A73EB26707F
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 14:37:25 +0200 (CEST)
Received: by mail-pl0-f68.google.com with SMTP id i5-v6so9360287plt.2
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 05:37:25 -0700 (PDT)
In-Reply-To: <20180515123639.18255-1-o-takashi@sakamocchi.jp>
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

A series of SNDRV_CTL_TLVO_XXX macro was introduced for position offset
of TLV data. This commit applies a code optimization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 test/user-ctl-element-set.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index e94152b9..fee130e2 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -660,7 +660,7 @@ static int check_tlv(struct elem_set_trial *trial)
 	if (err < 0)
 		return err;
 
-	len = tlv[1] + sizeof(unsigned int) * 2;
+	len = tlv[SNDRV_CTL_TLVO_LEN] + sizeof(unsigned int) * 2;
 	curr = malloc(len);
 	if (curr == NULL) {
 		free(tlv);
-- 
2.14.1
