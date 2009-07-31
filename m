From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 02/20] OMAP: McBSP: Wakeups utilized
Date: Fri, 31 Jul 2009 10:56:22 +0300
Message-ID: <20090731075622.GA27083__27161.0187752687$1249108187$gmane$org@esdhcp037198.research.nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<20090730215602.8fdcbaf1.jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20090730215602.8fdcbaf1.jhnikula@gmail.com>
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

On Thu, Jul 30, 2009 at 08:56:02PM +0200, ext Jarkko Nikula wrote:
> On Thu, 30 Jul 2009 15:49:25 +0300
> Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> 
> > --- a/arch/arm/plat-omap/mcbsp.c
> > +++ b/arch/arm/plat-omap/mcbsp.c
> > @@ -257,6 +257,23 @@ int omap_mcbsp_request(unsigned int id)
> >  	clk_enable(mcbsp->iclk);
> >  	clk_enable(mcbsp->fclk);
> >  
> > +#ifdef CONFIG_ARCH_OMAP34XX
> > +	/*
> 
> I'm sure there is a way to avoid all of these added ifdefs in this patch
> and in patches 7 and 8 as well.

hmmm.. these ifdef's are required because I've put the extra field (for
34xx only) inside an ifdef on their declaration in mcbsp.h. We can remove it
there, but will leave a few extra bytes on !omap3xx binaries.

> 
> 
> -- 
> Jarkko

-- 
Eduardo Valentin
