From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 12/20] OMAP: McBSP: Configure NO IDLE mode
 for DMA mode different of threshold
Date: Thu, 6 Aug 2009 15:00:08 +0300
Message-ID: <20090806120008.GB14093__21996.8645986684$1249626263$gmane$org@esdhcp037198.research.nokia.com>
References: <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
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
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

Tony and Jarkko,

On Thu, Jul 30, 2009 at 02:49:35PM +0200, Valentin Eduardo (Nokia-D/Helsinki) wrote:
> Use dma mode property to configure NO IDLE or SMART IDLE of McBSPs.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 6c535b3..11cfcfe 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -376,7 +376,15 @@ int omap_mcbsp_request(unsigned int id)
>  
>  		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
>  		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
> -		syscon |= (ENAWAKEUP | SIDLEMODE(0x02) | CLOCKACTIVITY(0x02));
> +
> +		spin_lock_irq(&mcbsp->lock);
> +		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
> +			syscon |= SIDLEMODE(0x02);
> +		else
> +			syscon |= SIDLEMODE(0x01);
> +		spin_unlock_irq(&mcbsp->lock);
> +
> +		syscon |= (ENAWAKEUP | CLOCKACTIVITY(0x02));

Because of this piece of code that patch 0002 is using ifdefs.

>  		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
>  
>  		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, WAKEUPEN_ALL);
> -- 
> 1.6.2.GIT

-- 
Eduardo Valentin
