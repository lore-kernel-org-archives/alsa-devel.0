From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 02/20] OMAP: McBSP: Wakeups utilized
Date: Thu, 30 Jul 2009 21:56:02 +0300
Message-ID: <20090730215602.8fdcbaf1.jhnikula__22627.2166044966$1248980129$gmane$org@gmail.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@vger.kernel.org, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 30 Jul 2009 15:49:25 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -257,6 +257,23 @@ int omap_mcbsp_request(unsigned int id)
>  	clk_enable(mcbsp->iclk);
>  	clk_enable(mcbsp->fclk);
>  
> +#ifdef CONFIG_ARCH_OMAP34XX
> +	/*

I'm sure there is a way to avoid all of these added ifdefs in this patch
and in patches 7 and 8 as well.


-- 
Jarkko
