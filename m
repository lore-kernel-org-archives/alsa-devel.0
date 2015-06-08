From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/11] ALSA: bebob: expand timeout for DM1500
	quirk
Date: Mon,  8 Jun 2015 23:31:05 +0900
Message-ID: <1433773868-17505-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1433773868-17505-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5016E2604BA
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 16:31:17 +0200 (CEST)
In-Reply-To: <1433773868-17505-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: kim@incendio.no, alsa-devel@alsa-project.org, jh1ood@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Behringer FCA610 and UFX1604 is confirmed to require more time till
transmitting packets after establishing connections. This seems to
be a quirk of DM1500 ASIC which ArchWave produced.

For this quirk, this commit extends the time to wait up to 2 seconds
for such devices. As a result, in worst cases, below userspace
functions require 2 seconds to return.
 - snd_pcm_prepare()
 - snd_pcm_hw_params()
 - snd_pcm_recover()

Tested-by: Kim Tore Jensen <kim@incendio.no>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 5335c30..9c810f9 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -8,7 +8,7 @@
 
 #include "./bebob.h"
 
-#define CALLBACK_TIMEOUT	1000
+#define CALLBACK_TIMEOUT	2000
 #define FW_ISO_RESOURCE_DELAY	1000
 
 /*
-- 
2.1.4
