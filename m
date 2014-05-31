From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC] [PATCH] firewire-lib: Use IEC 61883-6 compliant
 labels for Raw Audio/
Date: Sat, 31 May 2014 16:15:24 +0900
Message-ID: <5389818C.7080205@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080304000609090409040804"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id C55752650C2
 for <alsa-devel@alsa-project.org>; Sat, 31 May 2014 09:15:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080304000609090409040804
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi Clemens,

Would I request you to comment this patch?

I don't touch this label issue with my patchset because there is a bit
possibility to cause a regression. But now, I have a confidence that
this modification is reasonable. In detail, please see an attached patch.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

--------------080304000609090409040804
Content-Type: text/x-diff;
 name="0001-firewire-lib-Use-IEC-61883-6-compliant-labels-for-Ra.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-firewire-lib-Use-IEC-61883-6-compliant-labels-for-Ra.pa";
 filename*1="tch"

>From 7aa1bd8e3ba3a1217cba14ba3a1be322874b29a2 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Sat, 31 May 2014 15:56:32 +0900
Subject: [PATCH] firewire-lib: Use IEC 61883-6 compliant labels for Raw Audio
 data

According to AM824 in IEC 61883-6:2002, 2 bits in LSB of label for Raw Audio
data means Valid Length Code (VBL). Ths value is:
- b00 for 24 bits sample (label is 0x40)
- b01 for 20 bits sample (label is 0x41)
- b10 for 16 bits sample (label is 0x42)

But current firewire-lib apply 24 bits label for both of 16/24 bits samples.

As long as I investigate with BeBoB/Fireworks and OXFW, all of them have a
behaviour to ignore this label, it can generate correct sound even if
firewire-lib gives 0xff for the label. This is also confirmed to IEC 60958
data channel as I described to this comment:

ALSA: bebob: Improve comments about stream format
51fa31d462f32e1ffdf957802dcab1dc20d2f243

So I believe there're no regressions.

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


--------------080304000609090409040804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080304000609090409040804--
