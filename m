From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: firewire-tascam: change type of
	valiables according to function prototype
Date: Tue, 20 Oct 2015 23:46:56 +0900
Message-ID: <1445352419-21827-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1445352419-21827-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 823DE2665CA
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 16:47:04 +0200 (CEST)
In-Reply-To: <1445352419-21827-1-git-send-email-o-takashi@sakamocchi.jp>
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

In the callback function of asynchronous MIDI port, some local variables
are declared 'unsigned int', while they're assigned to int value of return
from snd_rawmidi_transmit_peek().

This commit fixes the type.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 370f932..7c80684 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -62,10 +62,8 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 {
 	struct snd_tscm *tscm = substream->rmidi->private_data;
 	unsigned int port = substream->number;
-	unsigned int len;
-	unsigned int i;
+	int i, len, consume;
 	u8 status;
-	int consume;
 
 	len = snd_rawmidi_transmit_peek(substream, buf + 1, 3);
 	if (len == 0)
-- 
2.1.4
