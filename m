From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: how to use mcbsp for i2s?
Date: Thu, 2 Apr 2009 13:20:36 +0300
Message-ID: <bd7b27490904020320i714cd812i49bd834676ce4dee@mail.gmail.com>
References: <fb44c3530904011129s7dd5cf1fgcf266fac3fb059d3@mail.gmail.com>
	<bd7b27490904020048h672ce810j3c79868a7f5ef4e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 57DE3103831
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 12:20:37 +0200 (CEST)
Received: by fxm18 with SMTP id 18so461762fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 02 Apr 2009 03:20:36 -0700 (PDT)
In-Reply-To: <bd7b27490904020048h672ce810j3c79868a7f5ef4e0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ernesto Torres <skullmate@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 2, 2009 at 10:48 AM, Jarkko Nikula <jhnikula@gmail.com> wrote:

>
> But by default McBSP1 and 3 which available in Beale pin header are muxed
> to GPIO
> so you need to mux those pins for McBSP by the bootloader and with
> linux-omap
> kernel multiplexing support.
>
> I may have a hack patch somewhere... I'll try to find it and post it here
> for reference.
>
> Grrr... cannot find the hack, I'm too keen to delete temporary hacks. I was
pretty sure I had
it somewhere.

Basically it was adding necessary pin multiplexing configuration into
arch/arm/plat-omap/include/mach/mux.h and arch/arm/mach-omap2/mux.c and
then using omap_cfg_reg(...) in omap3beagle.c to change pin configuration
from
GPIOs to McBPS[1 | 3] pins.


Jarkko
