From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [BAD PATCH] ice1712: Add support for Philips
 PSC724 Ultimate Edge
Date: Tue, 13 Mar 2012 22:25:54 +0100
Message-ID: <4F5FBB62.4020300@ivitera.com>
References: <201203132159.19733.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CCFD1041A8
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 22:26:01 +0100 (CET)
In-Reply-To: <201203132159.19733.linux@rainbow-software.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 13.3.2012 21:59, Ondrej Zary napsal(a):
> Hello,
> I'm trying do implement support for Philips PSC724 Ultimate Edge card, which 
> is based on VT1722 + WM8776 + WM8766 chips. I've examined the connections
> and commented them in the code. The patch is heavily based on se.c.
> 
> When trying to play a sound, the player runs but no sound comes from the
> output, no matter what I do with alsamixer.
> 
> The interesting thing is that recording works - I can record something from
> e.g. line-in and play it on another machine. Recording source selection
> in alsamixer works too (if line-in is deselected, only silence is recorded).
> So WM8776 I2C control works.
> 
> I'm missing something but don't know what. Any ideas?
> 

I always found that a simple proc interface listing all register values
of the chips onboard greatly helped with troubleshooting. E.g.
http://git.alsa-project.org/?p=alsa-kmirror.git;a=blob;f=i2c/other/ak4xxx-adda.c;h=cef813d23641afcd39b56a57c5fc8058cb99bfb0;hb=HEAD#l879

http://git.alsa-project.org/?p=alsa-kmirror.git;a=blob;f=i2c/other/ak4114.c;h=fdf3c1b65e388414c995a597ef2b351b4ec2a220;hb=HEAD#l451


Regards,

Pavel.
