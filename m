From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCHv2 1/4] ARM: ep93xx: DMA: fix channel_disable
Date: Sun, 10 Oct 2010 20:10:40 +0300
Message-ID: <717416e653baf477e55883c1ffab4a1be6e7e3e4.1286729843.git.mika.westerberg@iki.fi>
References: <cover.1286729843.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id F3F5E24554
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Oct 2010 19:10:43 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id 18so1626098bwz.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 10:10:43 -0700 (PDT)
In-Reply-To: <cover.1286729843.git.mika.westerberg@iki.fi>
In-Reply-To: <cover.1286729843.git.mika.westerberg@iki.fi>
References: <cover.1286729843.git.mika.westerberg@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: martinwguy@gmail.com, broonie@opensource.wolfsonmicro.com, hsweeten@visionengravers.com, ryan@bluewatersys.com, Mika Westerberg <mika.westerberg@iki.fi>, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

When channel_disable() is called, it disables per channel interrupts and
waits until channels state becomes STATE_STALL, and then disables the
channel. Now, if the DMA transfer is disabled while the channel is in
STATE_NEXT we will not wait anything and disable the channel immediately.
This seems to cause weird data corruption for example in audio transfers.

Fix is to wait while we are in STATE_NEXT or STATE_ON and only then
disable the channel.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/dma-m2p.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ep93xx/dma-m2p.c b/arch/arm/mach-ep93xx/dma-m2p.c
index 8904ca4..a696d35 100644
--- a/arch/arm/mach-ep93xx/dma-m2p.c
+++ b/arch/arm/mach-ep93xx/dma-m2p.c
@@ -276,7 +276,7 @@ static void channel_disable(struct m2p_channel *ch)
 	v &= ~(M2P_CONTROL_STALL_IRQ_EN | M2P_CONTROL_NFB_IRQ_EN);
 	m2p_set_control(ch, v);
 
-	while (m2p_channel_state(ch) == STATE_ON)
+	while (m2p_channel_state(ch) >= STATE_ON)
 		cpu_relax();
 
 	m2p_set_control(ch, 0x0);
-- 
1.5.6.5
