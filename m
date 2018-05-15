From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 3/6] hcontrol: use position offset
	macro of TLV data
Date: Tue, 15 May 2018 21:36:36 +0900
Message-ID: <20180515123639.18255-4-o-takashi@sakamocchi.jp>
References: <20180515123639.18255-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C813266EDF
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 14:37:19 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id z70-v6so6976845pgz.3
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 05:37:19 -0700 (PDT)
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
 src/control/hcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/control/hcontrol.c b/src/control/hcontrol.c
index 7e775248..0cac8956 100644
--- a/src/control/hcontrol.c
+++ b/src/control/hcontrol.c
@@ -870,7 +870,7 @@ int snd_hctl_elem_tlv_write(snd_hctl_elem_t *elem, const unsigned int *tlv)
 {
 	assert(elem);
 	assert(tlv);
-	assert(tlv[1] >= 4);
+	assert(tlv[SNDRV_CTL_TLVO_LEN] >= 4);
 	return snd_ctl_elem_tlv_write(elem->hctl->ctl, &elem->id, tlv);
 }
 
@@ -886,7 +886,7 @@ int snd_hctl_elem_tlv_command(snd_hctl_elem_t *elem, const unsigned int *tlv)
 {
 	assert(elem);
 	assert(tlv);
-	assert(tlv[1] >= 4);
+	assert(tlv[SNDRV_CTL_TLVO_LEN] >= 4);
 	return snd_ctl_elem_tlv_command(elem->hctl->ctl, &elem->id, tlv);
 }
 
-- 
2.14.1
