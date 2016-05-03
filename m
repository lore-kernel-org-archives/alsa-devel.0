From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 3/7] ARM: davinci: da850: add clocks for mcbsp0 and 1
Date: Tue, 3 May 2016 18:43:45 +0530
Message-ID: <5728A409.40506@ti.com>
References: <1461327617-11435-1-git-send-email-petr@barix.com>
 <1461327617-11435-4-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461327617-11435-4-git-send-email-petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Friday 22 April 2016 05:50 PM, Petr Kulhavy wrote:
> Add clock definitions "davinci-mcbsp.0" and "davinci-mcbsp.1" in order
> to make McBSP driver work on the DA850 platform.
> 
> The McBSP 0 and 1 interfaces were not defined for the DA850 platform.
> Neither were the related clocks. In order to make the use of McBSP via
> devicetree the clocks need to be defined.
> 
> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
> ---
> v1: initial
> v2: no change
> v3: no change
> v4: no change
> 
>  arch/arm/mach-davinci/da850.c | 16 ++++++++++++++++
>  arch/arm/mach-davinci/psc.h   |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 97d8779a9a65..2b9d972e30ac 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -306,6 +306,20 @@ static struct clk mcasp_clk = {
>  	.flags		= DA850_CLK_ASYNC3,
>  };
>  
> +static struct clk mcbsp0_clk = {
> +	.name		= "mcbsp0",
> +	.parent		= &pll1_sysclk2,
> +	.lpsc		= DA850_LPSC1_McBSP0,
> +	.gpsc		= 1,
> +};

Can you please rebase this to the master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git?

We now have a clock called async3 which is to be used for all clocks in
async3 domain.

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
