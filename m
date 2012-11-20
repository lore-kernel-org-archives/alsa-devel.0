From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 03/10] ASoC: kirkwood-i2s: fix DCO lock
	detection
Date: Tue, 20 Nov 2012 12:18:32 +0000
Message-ID: <E1Tamme-0007XB-5j@rmk-PC.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 9D7A4265370
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:18:34 +0100 (CET)
In-Reply-To: <20121120121726.GN3290@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Liam Girdwood <lrg@ti.com>, Rabeeh Khoury <rabeeh@solid-run.com>
List-Id: alsa-devel@alsa-project.org

This is part of a patch found in Rabeeh Khoury's git tree for the
cubox, which is further attributed to Sebastian Hesselbrath.

Rather than masking the KIRKWOOD_DCO_SPCR_STATUS register contents
against the registers virtual address, let's actually use the bit
definition for the locked status, as required in the documentation.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 542538d..485af80 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -95,7 +95,7 @@ static inline void kirkwood_set_dco(void __iomem *io, unsigned long rate)
 	do {
 		cpu_relax();
 		value = readl(io + KIRKWOOD_DCO_SPCR_STATUS);
-		value &= KIRKWOOD_DCO_SPCR_STATUS;
+		value &= KIRKWOOD_DCO_SPCR_STATUS_DCO_LOCK;
 	} while (value == 0);
 }
 
-- 
1.7.4.4
