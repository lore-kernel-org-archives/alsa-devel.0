From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: On OMAP1 and OMAP2420
 only 16bit format is supported
Date: Fri, 26 Oct 2018 09:00:44 +0300
Message-ID: <20181026060044.GA12256@bitmer.com>
References: <20181025134824.16527-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (50-87-157-213.static.tentacle.fi [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B2AD2679C6
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2018 08:00:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20181025134824.16527-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, aaro.koskinen@iki.fi
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 25, 2018 at 04:48:24PM +0300, Peter Ujfalusi wrote:
> For samples sizes of 20/24/32 bit the DRR2/DXR2 registers must be used to
> receive or transmit the most significant part of the 32bit sample.
> We can not trick the system by using the DRR2/DXR2 register offset and use
> 32bit element size since these (and other McBSP) registers are 16bit ones.
> 
> We would need support for port_window in cyclic mode from the sDMA driver,
> but it is not straight forward as we would need to have the sDMA frame to
> cover the 32bit (DRR2+DRR1/DXR2+DXR1), but the frames must cover the ALSA
> period to be able to receive periodic interrupts.
> 
> Since the 32bit samples are not working (DMA timeout), just remove it in
> case we have McBSP with reg_size of 2.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> I have noticed that on Nokia n810 32bit samples just don't work at all for audio
> 
> Regards,
> Peter
> 
>  sound/soc/omap/omap-mcbsp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
I guess this same holds for OMAP1 too as it has 16-bit McBSP registers
too.

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
