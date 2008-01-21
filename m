From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Support for Compaq Presario F700 - model
	755US	-	NVidia MCP67 Audio - Codec Conexant 5051
Date: Mon, 21 Jan 2008 08:11:28 -0800
Message-ID: <1200931888.30379.36.camel@razman.gruemaster.com>
References: <200801181655.05217.philippe@paravicini.com>
	<200801192123.29589.herton@mandriva.com.br>
	<s5h1w8bfnjx.wl%tiwai@suse.de>
	<200801211343.33892.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 8813F2455C
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 17:11:31 +0100 (CET)
In-Reply-To: <200801211343.33892.herton@mandriva.com.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Claudio Matsuoka <cmatsuoka@gmail.com>, alsa-user@alsa-project.org, Philippe Paravicini <philippe@paravicini.com>
List-Id: alsa-devel@alsa-project.org

I already did.  They said they'd submit a patch sometime soon.  As a
matter of fact, I just got a message in my inbox from them, that I'll
forward.

Tobin

On Mon, 2008-01-21 at 13:43 -0200, Herton Ronaldo Krzesinski wrote:

> Em Monday 21 January 2008 09:03:30 Takashi Iwai escreveu:
> > At Sat, 19 Jan 2008 21:23:29 -0200,
> >
> > Herton Ronaldo Krzesinski wrote:
> > > Em Saturday 19 January 2008 12:45:52 Claudio Matsuoka escreveu:
> > > > On Jan 19, 2008 9:56 AM, Tobin Davis <tdavis@dsl-only.net> wrote:
> > > > > I have already requested documentation and a development board from
> > > > > Conexant, so I should be able to get a fully functional driver going
> > > > > soon.  In the meantime, I'll try to get a test patch out to you as
> > > > > soon as possible.
> > > >
> > > > If this is the Hermosa codec (see
> > > > http://helllabs.org/codecgraph/out/hp-spartan-ng.svg), Herton has just
> > > > finished fully functional support to it, based on the HP "Spartan 1.1"
> > >
> > > Yes, it was working, but there were some things to sort out, like the
> > > Spartan 1.1 doesn't have to switch between capture source as each mic
> > > (int, ext) has its own adc, and I hacked it without removing the capture
> > > source from mixer.
> > >
> > > Also I worked on the same code provided by hsfmodem, that already has
> > > support for 5051, but I don't know why it wasn't sent upstream yet by
> > > Conexant/hsfmodem people.
> > >
> > > > laptop (subdevice ID is 14f1:5051).
> > > >
> > > > Herton, did you submit the patches for Hermosa support to the list?
> > >
> > > No, as I didn't fixed the patches for proper submission, and the part of
> > > hsfmodem probably Conexant/Linuxant people should send with proper
> > > Signed-offs etc. But anyway I'll attach here the patches for reference,
> > > that are not ready for inclusion and will not apply to current alsa tree.
> >
> > Thanks.  Do you happen to know how linuxant guys think of the patch
> > submission?  Of couse, the HSF modem part can be never merged to the
> > upstream, but the sane GPL'ed part could be good to merge.
> 
> Hi, don't know too, I'll try to contact Linuxant and ask about submission for 
> Hermosa support.
> 
> >
> >
> > Takashi
> 
> --
> []'s
> Herton
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
