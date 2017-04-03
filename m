From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-motu: remove invalid bitshift
	for register value
Date: Mon,  3 Apr 2017 21:13:50 +0900
Message-ID: <20170403121350.19579-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id D06072669D7
 for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2017 14:13:56 +0200 (CEST)
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

In protocol version 3, drivers can read current sampling clock status from
register 0x'ffff'f000'0b14. 8 bits of LSB of this register represents type
of signal as source of clock.

Current driver code includes invalid bitshift to handle the parameter. This
commit fixes the bug.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 5992e30034c4 ("ALSA: firewire-motu: add support for MOTU 828mk3 (FireWire/Hybrid) as a model with protocol version 3")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu-protocol-v3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/firewire/motu/motu-protocol-v3.c b/sound/firewire/motu/motu-protocol-v3.c
index b463da9..ddb6472 100644
--- a/sound/firewire/motu/motu-protocol-v3.c
+++ b/sound/firewire/motu/motu-protocol-v3.c
@@ -14,7 +14,6 @@
 #define  V3_CLOCK_RATE_MASK		0x0000ff00
 #define  V3_CLOCK_RATE_SHIFT		8
 #define  V3_CLOCK_SOURCE_MASK		0x000000ff
-#define  V3_CLOCK_SOURCE_SHIFT		8
 
 #define V3_OPT_IFACE_MODE_OFFSET	0x0c94
 #define  V3_ENABLE_OPT_IN_IFACE_A	0x00000001
@@ -101,7 +100,7 @@ static int v3_get_clock_source(struct snd_motu *motu,
 		return err;
 	data = be32_to_cpu(reg);
 
-	val = (data & V3_CLOCK_SOURCE_MASK) >> V3_CLOCK_SOURCE_SHIFT;
+	val = data & V3_CLOCK_SOURCE_MASK;
 	if (val == 0x00) {
 		*src = SND_MOTU_CLOCK_SOURCE_INTERNAL;
 	} else if (val == 0x01) {
-- 
2.9.3
