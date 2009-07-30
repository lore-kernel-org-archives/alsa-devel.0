From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 09/20] OMAP3: McBSP: Lower the maximum
 buffersize for McBSP1, 3, 4, 5
Date: Thu, 30 Jul 2009 21:57:21 +0300
Message-ID: <20090730215721.a899e2f4.jhnikula__18369.9587396861$1248980205$gmane$org@gmail.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
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
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@vger.kernel.org, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 30 Jul 2009 15:49:32 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Do not allow applications to use the full buffer found on
> McBSP1,3,4,5. Using the full buffer in threshold mode causes
> the McBSP buffer to run dry, which can be observed as channels
> are switching (in reality the channels are shifting).
> 
...
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -129,7 +129,7 @@ static struct omap_mcbsp_platform_data
> omap34xx_mcbsp_pdata[] = { .rx_irq		=
> INT_24XX_MCBSP1_IRQ_RX, .tx_irq		=
> INT_24XX_MCBSP1_IRQ_TX, .ops		= &omap2_mcbsp_ops,
> -		.buffer_size	= 0x7F,
> +		.buffer_size	= 0x6F,
>  	},

Is it possible that also McBSP2 would require that maximum burst
transmit size should be 0x10 smaller than size of internal buffer/fifo?

-- 
Jarkko
