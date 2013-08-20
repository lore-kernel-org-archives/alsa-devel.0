From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v8 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Tue, 20 Aug 2013 10:28:59 +0800
Message-ID: <20130820022858.GB13169@MrMyself>
References: <cover.1376912873.git.b42378@freescale.com>
 <a5b34243c0323e7692fab6a52a7adf4e3e8a5844.1376912873.git.b42378@freescale.com>
 <52128FBE.4080103@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 by alsa0.perex.cz (Postfix) with ESMTP id CCCBC26517A
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 04:39:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <52128FBE.4080103@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, Pawel Moll <pawel.moll@arm.com>, festevam@gmail.com, s.hauer@pengutronix.de, Kumar Gala <galak@codeaurora.org>, timur@tabi.org, rob.herring@calxeda.com, tomasz.figa@gmail.com, broonie@kernel.org, p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 19, 2013 at 03:35:58PM -0600, Stephen Warren wrote:
> > +	"core"		The core clock of spdif controller
> > +	"rxtx<0-7>"	Clock source list for tx and rx clock.
> > +			This clock list should be identical to
> > +			the source list connecting to the spdif
> > +			clock mux in "SPDIF Transceiver Clock
> > +			Diagram" of SoC reference manual. It
> > +			can also be referred to TxClk_Source
> > +			bit of register SPDIF_STC.
> 
> So, the HW block has 1 clock input, yet there's a mux somewhere else in
> the SoC which has 8 inputs?
> 
> If so, I'm not completely sure it's correct to reference anything other
> than the "core" clock in this binding. I think the other clocks would be
> more suitably represented in the system-level "sound card" binding that
> I guess patch 2/2 (which I haven't read yet) adds, since I assume those
> clock are more to do with system-level clock tree setup decisions, and
> might not even exist in some other SoC that included this IP block.
> 
> What do others think, assuming I'm correct about my HW design assumptions?

The core clock is being only needed when accessing registers of this IP.
Thus, in the driver, I let regmap handle it.

While the other 8 clocks are actual reference clocks for Tx. Tx clock needs
to select one of them that can easily derive a child clock matching the tx
sample rate. This is essential for the IP, so I don't think it's nicer to 
put into machine driver.

Thank you
Nicolin
