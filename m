From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/12] fireworks: Use the same prototype for
	functions as actual declaration
Date: Wed, 28 May 2014 00:14:39 +0900
Message-ID: <1401203687-4189-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 34E09265866
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 17:15:14 +0200 (CEST)
In-Reply-To: <1401203687-4189-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, dan.carpenter@oracle.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

There are two modes for Fireworks, IEC 61883 compliant or Windows.
So it's better to use enum type instead of int to express the intension,
even if C language specification defines to handle enum variables as usual
integer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 494195b..14395e3 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -192,7 +192,8 @@ enum snd_efw_transport_mode {
 };
 int snd_efw_command_set_resp_addr(struct snd_efw *efw,
 				  u16 addr_high, u32 addr_low);
-int snd_efw_command_set_tx_mode(struct snd_efw *efw, unsigned int mode);
+int snd_efw_command_set_tx_mode(struct snd_efw *efw,
+				enum snd_efw_transport_mode mode);
 int snd_efw_command_get_hwinfo(struct snd_efw *efw,
 			       struct snd_efw_hwinfo *hwinfo);
 int snd_efw_command_get_phys_meters(struct snd_efw *efw,
-- 
1.8.3.2
