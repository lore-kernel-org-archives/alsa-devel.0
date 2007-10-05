From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASoC v2 on PowerPC
Date: Fri, 5 Oct 2007 11:26:06 -0400
Message-ID: <9e4733910710050826h25d29827radec93e9eef17782@mail.gmail.com>
References: <9e4733910710041012vb8e2a25w7a3b2cc7be80426d@mail.gmail.com>
	<1191582477.12060.243.camel@localhost.localdomain>
	<9e4733910710050555u5189efdp424fded7fe5f16c0@mail.gmail.com>
	<4706444F.7000606@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by alsa0.perex.cz (Postfix) with ESMTP id EB7D2243E5
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Oct 2007 17:26:07 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so108713rvb
	for <alsa-devel@alsa-project.org>; Fri, 05 Oct 2007 08:26:06 -0700 (PDT)
In-Reply-To: <4706444F.7000606@freescale.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/5/07, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
> > On 10/5/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
> >> A good place to start would be looking at the other supported
> >> architectures and codecs and see what fits in best with your target SoC
> >> CPU. Fwiw, Timur Tabi has some working PPC code, although I'm not sure
> >> if it will work on Efika.
> >
> > Efika is STAC9766, ac97 with no i2c control. I dug into the imx ac97
> > driver and discovered that it isn't finished.
>
> A lot of the i.MX code just sits in BSPs and is never forwarded to the main
> repositories.

Aren't you fixing that?

> > Timur, we may need to get some Bestcomm tasks written. I haven't
> > explored this yet but I've been told that no one can get anything
> > except the general DMA task working for audio. This mean all audio
> > input has to be 32b. Isn't Bestcomm capable of expanding 16/24 bit
> > data? Our target hardware is i2s, not ac97, so I need to get i2s
> > running too.
>
> I'm working on an audio driver for the 8610, but I'm going to target ASoC V1
> first, just so that I can get a better feel for how V2 is different (a sort of
> "trial by fire").

I started looking at v2 because of the posts about modularizing it and
using open firmware to identify and load the codecs. There doesn't
seem to be that much difference.

> I don't know much about Bestcomm, but the DMA engine on the the 8610 is much
> simpler, from what I've heard.  I only work on 83xx, 85xx, and 86xx, so I
> really can't answer any Bestcomm questions.

We are on 5200 because it is cheaper and 5200 has all the peripherals
we need. Now that I am writing code for it I see that BestComm adds a
lot of complexity. Hopefully I can get i2s working on it, I'd hate to
switch CPUs after doing all this work.

> As for requiring all audio to be 32b, that's not such a bad thing.  Any
> application that uses the standard ALSA interface will have format-conversion
> plug-ins automatically invoked.  The overhead will be minor, since it has to
> do a byte-copy anyway.
>
> --
> Timur Tabi
> Linux Kernel Developer @ Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
