From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: oxfw: remove needless member from
	private structure
Date: Sun, 27 Mar 2016 16:09:07 +0900
Message-ID: <1459062549-18721-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1459062549-18721-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 9766926044E
 for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2016 09:09:14 +0200 (CEST)
In-Reply-To: <1459062549-18721-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In former commit, 'struct device_info' is obsoleted, whereas private
structure still keeps a pointer to it.

This commit remove the member.

d6ce6bbd7d83('ALSA: oxfw: rename a structure so that it means backward compatibility to old drivers')

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 9beecc2..2c84714e 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -36,7 +36,6 @@
 struct snd_oxfw {
 	struct snd_card *card;
 	struct fw_unit *unit;
-	const struct device_info *device_info;
 	struct mutex mutex;
 	spinlock_t lock;
 
-- 
2.7.3
