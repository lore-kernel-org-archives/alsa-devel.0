From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] ALSA: tascam: improve loop condition to
	filling MIDI bytes in transaction
Date: Sun, 18 Oct 2015 19:02:17 +0900
Message-ID: <1445162538-12293-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1445162538-12293-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 267CD26166B
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 12:02:26 +0200 (CEST)
In-Reply-To: <1445162538-12293-1-git-send-email-o-takashi@sakamocchi.jp>
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

It includes meaningless condition. This commit improve it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 7fcee81..4ffaa8a 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -74,7 +74,7 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 	/* On exclusive message. */
 	if (tscm->on_sysex[port]) {
 		/* Seek the end of exclusives. */
-		for (i = 1; i < 4 || i < len; ++i) {
+		for (i = 1; i < len + 1; ++i) {
 			if (buf[i] == 0xf7) {
 				tscm->on_sysex[port] = false;
 				break;
-- 
2.1.4
