From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 1/2] wss_lib: move cs4231_lib into wss_lib
Date: Tue, 24 Jun 2008 18:47:40 +0200
Message-ID: <20080624184740.b927c3c4.krzysztof.h1@poczta.fm>
References: <20080619230718.044b7905.krzysztof.h1@poczta.fm>
	<485EECB5.4070808@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 25E2F24A1A
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jun 2008 18:44:13 +0200 (CEST)
In-Reply-To: <485EECB5.4070808@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Jun 2008 02:22:13 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 19-06-08 23:07, Krzysztof Helt wrote:
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Move the file sound/isa/cs423x/cs4231_lib.c 
> > into sound/isa/cs423x/wss_lib.c
> > This is the first step toward merging all libraries
> > for Windows Sound System compatible chips
> > into a single library.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Acked-by: Rene Herman <rene.herman@gmail.com>
> 
> Only small request:
> 
> > diff -urNp linux-alsa/sound/isa/wss/Makefile linux-mm/sound/isa/wss/Makefile
> > --- linux-alsa/sound/isa/wss/Makefile	1970-01-01 01:00:00.000000000 +0100
> > +++ linux-mm/sound/isa/wss/Makefile	2008-06-15 22:38:44.705642447 +0200
> > @@ -0,0 +1,10 @@
> > +#
> > +# Makefile for ALSA
> > +# Copyright (c) 2008 by Krzysztof Helt <krzysztof.h1@wp.pl>
> > +#
> > +
> > +snd-wss-lib-objs := wss_lib.o
> > +
> > +# Toplevel Module Dependency
> > +obj-$(CONFIG_SND_WSS_LIB) += snd-wss-lib.o
> > +
> 
> Could you maybe "donate" the copyright on this Makefile to Jaroslav Kysela?
> 

I don't mind. I'll repost the patch with only this change.

Regards,
Krzysztof

----------------------------------------------------------------------
Mieszkasz w USA? Zobacz portal dla Polonii!
kliknij >>> http://link.interia.pl/f1e36
