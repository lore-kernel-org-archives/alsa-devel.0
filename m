From: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: mediatek: Add AFE platform driver
Date: Fri, 12 Jun 2015 16:24:48 +0800
Message-ID: <1434097488.29733.0.camel@mtksdaap41>
References: <1433946276-25969-1-git-send-email-koro.chen@mediatek.com>
	 <1433946276-25969-2-git-send-email-koro.chen@mediatek.com>
	 <1434006187.24094.40.camel@x220> <1434074158.10969.5.camel@mtksdaap41>
	 <1434094677.2271.125.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434094677.2271.125.camel@x220>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2015-06-12 at 09:37 +0200, Paul Bolle wrote:
> On Fri, 2015-06-12 at 09:55 +0800, Koro Chen wrote:
> > On Thu, 2015-06-11 at 09:03 +0200, Paul Bolle wrote:
> > > (What does negating a bool twice do?)
> > > 
> > Because bool actually can be unsigned char, although actually in this
> > driver, the caller always passes "true" or "false" to this function.
> 
> bool is _Bool in the kernel (see include/linux/types.h). So whenever you
> see a bool in the kernel you can assume it's either 0 or 1. Are there
> any cases where this conveniently simple rule doesn't hold?
> 
> But here the discussion is moot, because as you say, the function will
> only be passed false or true so we know "enable" is either 0 or 1 and
> double negating will do nothing.
> 
> > Do you think if this is the case, should I still need to do !!?
> 
> So you should not, as it's confusing at best.
> 
OK, thank you. I will drop it in the next version of patch.
> Thanks,
> 
> 
> Paul Bolle
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
