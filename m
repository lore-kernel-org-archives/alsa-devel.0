From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [RFC PATCH] ES938 support for ES18xx driver
Date: Mon, 16 Sep 2013 18:14:44 +0200
Message-ID: <201309161814.45080.linux@rainbow-software.org>
References: <20130915184902.GA23480@rhlx01.hs-esslingen.de> <201309152304.27585.linux@rainbow-software.org> <20130915212358.GB32375@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130915212358.GB32375@rhlx01.hs-esslingen.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: alsa-devel@alsa-project.org, krzysztof.h1@wp.pl, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sunday 15 September 2013 23:23:58 Andreas Mohr wrote:
> On Sun, Sep 15, 2013 at 11:04:26PM +0200, Ondrej Zary wrote:
> > On Sunday 15 September 2013 22:35:20 Andreas Mohr wrote:
> > > What!?!? I didn't quite expect any kernel dev to have that one, too ;)
> >
> > Don't remember where I got it from but it looked nice so I bought it :)
>
> Yup, e.g. the builtin amp is quite nice.
>
> > > Thanks for hinting at the TLV control dB values thingy! Didn't know
> > > that such thing existed, thus azt3328 does not have it (yet?).
> >
> > It's a nice thing, especially for cards that can go above 0 dB. You then
> > know that the sound can be distorted when you set e.g. PCM volume too
> > high.
>
> Hmm, any hint how to precisely do dB values normalization scaling,
> for a card where this is not documented? Or perhaps that's actually easy -
> haven't thought about it...

Perhaps with 3 sound cards: one for recording, one with known dB values and 
one unknown.
First play some test signal at known dB value and record that.
Then play the signal using on the unknown card and ajdust its mixer so that 
the recording revel is the same as before.
Repeat a few times to find out the dB value of mixer step.

> > > Is there any chip ID/version register to be identified?
> >
> > No, there are only 8 registers, all(? - haven't tested) R/W.
>
> OK, but possibly they happen to be creating another virtual register
> mapping range? (i.e. index/data register combo?)

Datasheet says that there are no more registers - just 0..7 (2,3,4 are 
reserved).

-- 
Ondrej Zary
