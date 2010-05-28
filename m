From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Subject: Re: [PATCH] ALSA,
 hda: Add support for Lenovo ThinkPad Edge 13 in conexant codec
Date: Fri, 28 May 2010 08:21:02 +0200
Message-ID: <20100528062102.GF10254@alberich.amd.com>
References: <20100527160656.GE10254@alberich.amd.com>
	<s5htyps3788.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EDBD103AC5
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 08:21:06 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 5so70862eyb.16
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 23:21:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5htyps3788.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jerone Young <jerone.young@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Borislav Petkov <borislav.petkov@amd.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 28, 2010 at 07:50:31AM +0200, Takashi Iwai wrote:
> At Thu, 27 May 2010 18:06:56 +0200,
> Andreas Herrmann wrote:
> > 
> > From: Andreas Herrmann <andreas.herrmann3@amd.com>
> > 
> > On a Thinkpad Edge 13 I had the problem that speakers played sound
> > although headphones were plugged.
> > 
> > Using "model=olpc-xo-1_5" solved this problem. So it seems sensible to
> > add this quirk. (Using other models, like ideabad did not fix it.)
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> > ---
> >  sound/pci/hda/patch_conexant.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > I don't know whether adding this quirk is the right/complete solution
> > to support sound on Thinkpad Edge. But at least it solves this
> > annoying problem.
> 
> Well, Jerone Young already sent a quirk patch but he took
> model=ideapd.  Could you guys check which one is really better?

Hi Jerone,

there are two different models of Thinkpad Edge (one with Intel CPU/chipset,
one with AMD CPU/chipset). I tested on the AMD version but from

https://bugs.launchpad.net/ubuntu/+source/linux-backports-modules-2.6.32/+bug/549289

it seems that using  model=olpc-xo-1_5 works for both versions of that Thinkpad.

I also tried ideapad -- because looking at the quirk table
for cxt5066 there is this entry

        SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT5066_IDEAPAD),

and adding 

        SND_PCI_QUIRK(0x17aa, 0x21b3, "Thinkpad Edge", CXT5066_IDEAPAD),

seems to be conclusive.

But as I said that did not solve the problem of speakers still playing
audio if headphones are plugged in for me. Have you explicitely tested
this?  Maybe I have to retest with some newer code from the alsa tree?


Regards,
Andreas
