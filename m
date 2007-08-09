From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: Re: [PATCH 1/2] Xlinx ML403 AC97 Controller Reference
	device driver
Date: Thu, 09 Aug 2007 22:01:40 +0200
Message-ID: <1186689700.28843.76.camel@localhost>
References: <1186655810.7420.26.camel@localhost>
	<fa686aa40708091049m46607037jafe4b479ae52db43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 764CF10386F
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Aug 2007 22:01:42 +0200 (CEST)
In-Reply-To: <fa686aa40708091049m46607037jafe4b479ae52db43@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, Lorenz Kolb <lorenz.kolb@lkmail.de>, "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi Grant,

On Thu, 2007-08-09 at 11:49 -0600, Grant Likely wrote:
> > diff --git a/sound/ppc/Makefile b/sound/ppc/Makefile
> > index eacee2d..827f2f5 100644
> > --- a/sound/ppc/Makefile
> > +++ b/sound/ppc/Makefile
> 
> Couldn't this end up on MicroBlaze too?  If so, sound/ppc is the wrong place.

Well, I don't know. The only arch depended calls I use (am aware of) are
in/out_be32(), so this _might_ work for mb, too. (I won't be able to
test that in the next few months ...)

On Thu, 2007-08-09 at 11:17 -0700, Stephen Neuendorffer wrote: 
>  I second grant here... this should eventually work on microblaze, too,
> so putting it drivers/ and using XILINX_DRIVERS instead of XILINX_VIRTEX
> (based on the patch Wolfgang recently posted) would probably be preferable.
> 
> > +
> > +config SND_ML403_AC97CR
> > +       tristate "Xilinx ML403 AC97 Controller Reference"
> > +       depends on SND && XILINX_VIRTEX
> 
> Steve

So, like Stephen Neuendorffer said, I should move it to sound/drivers,
right? Takashi?


On Thu, 2007-08-09 at 11:49 -0600, Grant Likely wrote:
> > +snd-ml403_ac97cr-objs := ml403_ac97cr.o
> 
> This line is only needed if you're compiling multiple .c files into one .ko

Ah, well, then I have to rename the main .c file. But all the other ALSA
drivers seem to _not_ include the "snd-" in front of it (ok, except the
new PS3 driver and maybe other new ones?)

> I'll try adding your patches to my tree this afternoon.

I made patch against your tree, too (like a said before). Tell me, then
I post it ...

 Joachim
