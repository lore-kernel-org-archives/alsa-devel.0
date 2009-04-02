From: Ernesto Torres <skullmate@gmail.com>
Subject: Re: how to use mcbsp for i2s?
Date: Thu, 2 Apr 2009 11:27:13 -0600
Message-ID: <fb44c3530904021027r7a1387cag8507c4a1a88811ca@mail.gmail.com>
References: <fb44c3530904011129s7dd5cf1fgcf266fac3fb059d3@mail.gmail.com>
	<bd7b27490904020048h672ce810j3c79868a7f5ef4e0@mail.gmail.com>
	<bd7b27490904020320i714cd812i49bd834676ce4dee@mail.gmail.com>
	<20090402195653.0bcfb59e.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f132.google.com (mail-qy0-f132.google.com
	[209.85.221.132])
	by alsa0.perex.cz (Postfix) with ESMTP id CAB28103877
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 19:27:14 +0200 (CEST)
Received: by qyk38 with SMTP id 38so1247214qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 02 Apr 2009 10:27:13 -0700 (PDT)
In-Reply-To: <20090402195653.0bcfb59e.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

thank you, I'll try it and let you know how it went

On Thu, Apr 2, 2009 at 10:56 AM, Jarkko Nikula <jhnikula@gmail.com> wrote:

> On Thu, 2 Apr 2009 13:20:36 +0300
> Jarkko Nikula <jhnikula@gmail.com> wrote:
>
> > > Grrr... cannot find the hack, I'm too keen to delete temporary
> > > hacks. I was
> > pretty sure I had
> > it somewhere.
> >
> > Basically it was adding necessary pin multiplexing configuration into
> > arch/arm/plat-omap/include/mach/mux.h and arch/arm/mach-omap2/mux.c
> > and then using omap_cfg_reg(...) in omap3beagle.c to change pin
> > configuration from
> > GPIOs to McBPS[1 | 3] pins.
> >
> Yes, I found it. Hack attached :-)
>
> Now I don't have here Beagle to test but hack still applies on top of
> linux-omap. Then you will need CONFIG_OMAP_MUX=y and following lines
> into omap3beagle.c or board-omap3beagle.c.
>
> omap_cfg_reg(AF6_3430_MCBSP3_DX);
> omap_cfg_reg(AE6_3430_MCBSP3_DR);
> omap_cfg_reg(AF5_3430_MCBSP3_CLKX);
> omap_cfg_reg(AE5_3430_MCBSP3_FSX);
>
>
> Jarkko
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>


-- 
___________
EhTd
