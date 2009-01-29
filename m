From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [2.6.29-rc3][PATCH 1/1] ASoC: OMAP: Initialize XCCR
	and RCCR registers in McBSP DAI driver
Date: Thu, 29 Jan 2009 13:29:46 +0200
Message-ID: <1233228586-8894-2-git-send-email-jarkko.nikula@nokia.com>
References: <1233228586-8894-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 12741103887
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 12:30:13 +0100 (CET)
In-Reply-To: <1233228586-8894-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "ext Lopez Cruz,
	Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

From: ext Lopez Cruz, Misael <x0052729@ti.com>

This patch explicitly initializes McBSP Transmit Configuration
Control Register (XCCR) and Receive Configuration Control
Register (RCCR) to their reset values. Reset values are 26 ns
of DX delay and Transmit DMA disabled for XCCR register;
receive full cycle mode enabled and Receive DMA disabled for
RCCR register.

This patch requires a counterpart in OMAP McBSP driver before
to apply it. The required changes in McBSP were sent and approved
in linux-omap mailing list and patch is going upstream
(commit 3127f8f8595a064b3f1a1837fea2177902589ac3 from linux-omap-2.6
tree).

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
[ jarkko.nikula@nokia.com: Commit id for counterpart patch corrected ]
Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index ec5e18a..05dd5ab 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -302,6 +302,10 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	regs->spcr1	|= RINTM(3);
 	regs->rcr2	|= RFIG;
 	regs->xcr2	|= XFIG;
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		regs->xccr = DXENDLY(1) | XDMAEN;
+		regs->rccr = RFULL_CYCLE | RDMAEN;
+	}
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-- 
1.5.6.5
