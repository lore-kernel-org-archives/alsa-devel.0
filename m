From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/6] fireworks: Remove a constant over width to
	which it's applied
Date: Wed,  4 Jun 2014 15:25:35 +0900
Message-ID: <1401863137-15103-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1401863137-15103-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D59C26517E
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 08:25:56 +0200 (CEST)
In-Reply-To: <1401863137-15103-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The constants of enum snd_efw_grp_type is for struct snd_efw_phys_grp.type.
But this member is 1 byte. Although the value is between 0x00-0xff, a constant
has 0x10000. This constant is meaningless.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index d2b36be..4f0201a 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -162,7 +162,6 @@ enum snd_efw_grp_type {
 	SND_EFW_CH_TYPE_GUITAR			= 7,
 	SND_EFW_CH_TYPE_PIEZO_GUITAR		= 8,
 	SND_EFW_CH_TYPE_GUITAR_STRING		= 9,
-	SND_EFW_CH_TYPE_VIRTUAL			= 0x10000,
 	SND_EFW_CH_TYPE_DUMMY
 };
 struct snd_efw_phys_meters {
-- 
1.8.3.2
