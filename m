From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: ASoC: fsl_ssi: How do I gracefully restart after a
 channel slip is detected?
Date: Mon, 2 Nov 2015 09:41:35 -0800
Message-ID: <20151102174135.GB4068@Asurada-CZ80>
References: <CAG5mAdyuxR-YiwjJ+OXAYEH3YU0=PWbJiickFJidxMcXPjTVHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id C77862619D8
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 18:41:39 +0100 (CET)
Received: by pacfv9 with SMTP id fv9so161171365pac.3
 for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2015 09:41:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAG5mAdyuxR-YiwjJ+OXAYEH3YU0=PWbJiickFJidxMcXPjTVHQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 02, 2015 at 07:53:42AM -0800, Caleb Crome wrote:
> Hi Again,
>   I'm definitely making progress towards a fully working FSL SSI port
> in TDM mode.  The TX seems to be fairly robust.  However, there is a
> new problem now.  The Rx can overrun, and what happens, I get an Rx
> channel slip.  The DMA consuming data from the fifo is out of sync.

Are you still using dual FIFO mode with 8 watermark and 8 burst size
configurations? You may try 4 wm/8 burst or 8 wm/16 burst.

I remember that 8 wm with 16 burst couldn't work for your TX although
it works for me. I think you might need to confirm if your kernel is
really using dual FIFO mode with dual FIFO DMA script:
1) Check use_dual_fifo in the SSI driver.
2) Check "case IMX_DMATYPE_SSI_DUAL" in the DMA driver (imx-sdma.c)

> I can detect this with the Rx overrun ISR.  The question is, how do I
> restart everything gracefully?  I somehow need to tell the DMA to
> restart on a frame boundary, and I need to restart the SSI, correct?

I am not sure what's your test case right now but you should be okay
if testing Rx only. The problem could be caused by either:

	DMA request isn't been enabled prior to Rx start.
Or
	Not in Dual FIFO mode. Single FIFO only has 15 depth while
	your case uses 16 data per frame. With single FIFO, it will
	be simply overrun.

> I don't see any similar method to do this in the ESAI driver.

ESAI has 128 depth which is fairly large enough since Rx FIFO grows
from 0 (far away overrun state), not like Tx one being consumed from
0 (nearly underrun state) so it's easily got underrun.
