From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 09/20] OMAP3: McBSP: Lower the maximum
 buffersize for McBSP1, 3, 4, 5
Date: Fri, 31 Jul 2009 10:58:23 +0300
Message-ID: <20090731075823.GB27083__20340.8511625186$1249108197$gmane$org@esdhcp037198.research.nokia.com>
References: <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
	<20090730215721.a899e2f4.jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20090730215721.a899e2f4.jhnikula@gmail.com>
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
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 30, 2009 at 08:57:21PM +0200, ext Jarkko Nikula wrote:
> On Thu, 30 Jul 2009 15:49:32 +0300
> Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> 
> > From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > 
> > Do not allow applications to use the full buffer found on
> > McBSP1,3,4,5. Using the full buffer in threshold mode causes
> > the McBSP buffer to run dry, which can be observed as channels
> > are switching (in reality the channels are shifting).
> > 
> ...
> > --- a/arch/arm/mach-omap2/mcbsp.c
> > +++ b/arch/arm/mach-omap2/mcbsp.c
> > @@ -129,7 +129,7 @@ static struct omap_mcbsp_platform_data
> > omap34xx_mcbsp_pdata[] = { .rx_irq		=
> > INT_24XX_MCBSP1_IRQ_RX, .tx_irq		=
> > INT_24XX_MCBSP1_IRQ_TX, .ops		= &omap2_mcbsp_ops,
> > -		.buffer_size	= 0x7F,
> > +		.buffer_size	= 0x6F,
> >  	},
> 
> Is it possible that also McBSP2 would require that maximum burst
> transmit size should be 0x10 smaller than size of internal buffer/fifo?

That's already not at full size. There is room for 1024+256 places on mcbsp2.

> 
> -- 
> Jarkko

-- 
Eduardo Valentin
