From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 4/4] pxa-ssp: switch from network mode to
	psp
Date: Thu, 5 Mar 2009 14:21:26 +0100
Message-ID: <20090305132126.GE28878@buzzloop.caiaq.de>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<1236197820-21022-3-git-send-email-daniel@caiaq.de>
	<1236197820-21022-4-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 91A9024468
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 14:21:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236197820-21022-4-git-send-email-daniel@caiaq.de>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Tim Ruetz <tim@caiaq.de>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 09:17:00PM +0100, Daniel Mack wrote:
> +		switch (priv->dai_fmt & SND_SOC_DAIFMT_FRAME_FORMAT_MASK) {
> +		case SND_SOC_DAIFMT_FF_I2S_32:
> +			/* These values are all found out by trying and
> +			 * failing a lot. PXA's SSP is all black magic and
> +			 * does not work like described in any datasheet.
> +			 */
> +			sspsp |= SSPSP_SFRMWDTH(32);
> +			sspsp |= SSPSP_SFRMDLY(32 * 2);
> +			sspsp |= SSPSP_EDMYSTOP(3);
> +			sspsp |= SSPSP_DMYSTOP(3);
> +			sspsp |= SSPSP_DMYSTRT(1);
> +			break;

*sigh*

I just saw that one of these bit fields we write to here is only
available on PXA3xx - so we probably need the whole logic to be
different for PXA2xx which makes everthing a lot more complicated.

Anyway, could the patch below be taken?

Thanks,
Daniel


>From 44ef06d5209b498249da5c0cc7e0bc86355f9904 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Thu, 5 Mar 2009 14:13:11 +0100
Subject: [PATCH] pxa-ssp: add two more bitfields

Add two more bitfields for the PSP register. As they seem to exist
for PXA3xx only, define them conditionally.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/include/mach/regs-ssp.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-ssp.h b/arch/arm/mach-pxa/include/mach/regs-ssp.h
index a9ee355..018f6d6 100644
--- a/arch/arm/mach-pxa/include/mach/regs-ssp.h
+++ b/arch/arm/mach-pxa/include/mach/regs-ssp.h
@@ -109,6 +109,11 @@
 #define SSSR_TINT		(1 << 19)	/* Receiver Time-out Interrupt */
 #define SSSR_PINT		(1 << 18)	/* Peripheral Trailing Byte Interrupt */
 
+#if defined(CONFIG_PXA3xx)
+#define SSPSP_EDMYSTOP(x)	((x) << 28)     /* Extended Dummy Stop */
+#define SSPSP_EDMYSTRT(x)	((x) << 26)     /* Extended Dummy Start */
+#endif
+
 #define SSPSP_FSRT		(1 << 25)	/* Frame Sync Relative Timing */
 #define SSPSP_DMYSTOP(x)	((x) << 23)	/* Dummy Stop */
 #define SSPSP_SFRMWDTH(x)	((x) << 16)	/* Serial Frame Width */
-- 
1.6.1.3
