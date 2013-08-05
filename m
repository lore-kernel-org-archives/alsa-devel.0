From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v3 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Mon, 5 Aug 2013 19:28:05 +0800
Message-ID: <20130805112804.GA6770@MrMyself>
References: <1375687781-23225-1-git-send-email-b42378@freescale.com>
 <1375687781-23225-2-git-send-email-b42378@freescale.com>
 <1375697222.4000.59.camel@pizza.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 by alsa0.perex.cz (Postfix) with ESMTP id EBF17264F3D
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 13:33:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1375697222.4000.59.camel@pizza.hi.pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi Philipp,

   Thanks for the comments! I'll revise it and send a v4.
   Here is my reply to some parts of your question.

On Mon, Aug 05, 2013 at 12:07:02PM +0200, Philipp Zabel wrote:
> This looks to me like a case of configuration data in the device tree.
> Couldn't the tx/rx clock source be determined automatically or at least
> the SoC specific clock sources to the mux be known to the driver, so
> that we can use clock phandles here?
> 
> What happens if a different tx-clk-source is needed for 48 kHz than for
> 44.1 kHz?

You are right about the case. I'll try to figure out a nicer way, including
for the different sample-rate.


> Do we already have anything for this in the kernel?
> It could also be done using:
> 
> 	u8 tmp = input;
> 
>         tmp = ((tmp & 0b10101010) >> 1) | ((tmp << 1) & 0b10101010);
>         tmp = ((tmp & 0b11001100) >> 2) | ((tmp << 2) & 0b11001100);
>         tmp = ((tmp & 0b11110000) >> 4) | ((tmp << 4) & 0b11110000);
> 
> 	return tmp;

I was also wondering this question but I couldn't find it.
And obviously your algorithm is better :)


> In principle, it should also be possible to let the SDMA engine only
> take the FIFOs' MSBs for S16_LE. Is this a limitation of the SDMA ROM
> script?

You are right about the idea and the inference.
