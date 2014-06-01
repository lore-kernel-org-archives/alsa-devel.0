From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] firewire-lib: Use IEC 61883-6 compliant labels
	for Raw Audio data
Date: Mon,  2 Jun 2014 01:50:16 +0900
Message-ID: <1401641416-14127-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id C74CC26545D
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 18:50:26 +0200 (CEST)
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

According to AM824 in IEC 61883-6:2002, 2 bits in LSB of label for Raw Audio
data means Valid Length Code (VBL). Ths value is:
- b00 for 24 bits sample (label is 0x40)
- b01 for 20 bits sample (label is 0x41)
- b10 for 16 bits sample (label is 0x42)

But current firewire-lib apply 24 bits label for both of 16/24 bits samples.

As long as developers investigate BeBoB/Fireworks/OXFW/Dice, all of them
have a behaviour to ignore the label. They can generate correct sound even
if firewire-lib gives wrong label (i.e. 0xff). On BeBoB, this is not only
for Raw Audio data channel, but also for IEC 60958 Conformant data channel.

So there is little possibility of regression.

Acked-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 31dd1cf..f96bf4c 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -418,7 +418,7 @@ static void amdtp_write_s16(struct amdtp_stream *s,
 	for (i = 0; i < frames; ++i) {
 		for (c = 0; c < channels; ++c) {
 			buffer[s->pcm_positions[c]] =
-					cpu_to_be32((*src << 8) | 0x40000000);
+					cpu_to_be32((*src << 8) | 0x42000000);
 			src++;
 		}
 		buffer += s->data_block_quadlets;
-- 
1.8.3.2
