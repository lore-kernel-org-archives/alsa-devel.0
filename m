From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ALSA: tascam: clear extra MIDI byte of
	asynchronous transaction
Date: Sun, 18 Oct 2015 19:02:18 +0900
Message-ID: <1445162538-12293-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1445162538-12293-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 26B5B26168C
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

When MIDI buffer stores two or more MIDI messages, TASCAM driver
transfers asynchronous transactions including one MIDI message and
extra bytes in second MIDI message.

This commit fixes this bug by clear needless bytes in the buffer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 4ffaa8a..4bedfe4 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -130,6 +130,9 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
 		buf[0] = (port << 4) | (buf[1] >> 4);
 	}
 
+	if (len < 3)
+		memset(buf + 1, 0, 3 - len);
+
 	return len;
 }
 
-- 
2.1.4
