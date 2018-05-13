From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: isight: use position offset macro of
	TLV data
Date: Mon, 14 May 2018 07:09:53 +0900
Message-ID: <20180513220953.15118-5-o-takashi@sakamocchi.jp>
References: <20180513220953.15118-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id C78A726769E
 for <alsa-devel@alsa-project.org>; Mon, 14 May 2018 00:10:32 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id l2-v6so4621970pgc.7
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 15:10:32 -0700 (PDT)
In-Reply-To: <20180513220953.15118-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A series of SNDRV_CTL_TLVO_XXX macro was introduced for position offset
of TLV data. This commit applies a code optimization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/isight.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index 46092fa3ff9b..3919e186a30b 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -569,18 +569,20 @@ static int isight_create_mixer(struct isight *isight)
 		return err;
 	isight->gain_max = be32_to_cpu(value);
 
-	isight->gain_tlv[0] = SNDRV_CTL_TLVT_DB_MINMAX;
-	isight->gain_tlv[1] = 2 * sizeof(unsigned int);
+	isight->gain_tlv[SNDRV_CTL_TLVO_TYPE] = SNDRV_CTL_TLVT_DB_MINMAX;
+	isight->gain_tlv[SNDRV_CTL_TLVO_LEN] = 2 * sizeof(unsigned int);
 
 	err = reg_read(isight, REG_GAIN_DB_START, &value);
 	if (err < 0)
 		return err;
-	isight->gain_tlv[2] = (s32)be32_to_cpu(value) * 100;
+	isight->gain_tlv[SNDRV_CTL_TLVO_DB_MINMAX_MIN] =
+						(s32)be32_to_cpu(value) * 100;
 
 	err = reg_read(isight, REG_GAIN_DB_END, &value);
 	if (err < 0)
 		return err;
-	isight->gain_tlv[3] = (s32)be32_to_cpu(value) * 100;
+	isight->gain_tlv[SNDRV_CTL_TLVO_DB_MINMAX_MAX] =
+						(s32)be32_to_cpu(value) * 100;
 
 	ctl = snd_ctl_new1(&gain_control, isight);
 	if (ctl)
-- 
2.14.1
