From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Thu, 3 Jan 2013 22:57:59 +1030
Message-ID: <20130103122759.GB20962@marvin.atrad.com.au>
References: <20121228135207.GA24779@marvin.atrad.com.au>
 <s5hhamyr1ne.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 2318D2615E6
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2013 13:28:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhamyr1ne.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, jwoithe@just42.net
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 03, 2013 at 11:39:33AM +0100, Takashi Iwai wrote:
> At Sat, 29 Dec 2012 00:22:07 +1030,
> Jonathan Woithe wrote:
> > 
> > Having been running kernel 3.3.5 for a while, I decided to upgrade to 3.7.1
> > tonight.  Unfortunately there have been a number of HDA-related regressions
> > between these two kernels when running on a Fujitsu S7020 laptop which are
> > clearly related to the HDA rewrite which has been going on recently.  This
> > laptop utilises the Realtek ALC260 codec.
> > 
> > Testing was initially done with alsa-lib 1.0.24 and alsa-utils 1.0.24.  I
> > upgraded to version 1.0.26 of both but the behaviour remained the same under
> > 3.3.5 and 3.7.1.
> > 
> > Under 3.3.5, sound works perfectly.
> > 
> > Under 3.7.1 there are a number of regressions:
> > 
> >  - there is no alsamixer control for the internal speaker.  I have a "PCM"
> >    volume control which appears to do nothing.  Previously there was a
> >    speaker control, the PCM control affected every output (from memory), as
> >    did the master volume.
> > 
> >  - no audio comes out of the internal speaker regardless of the "auto mute"
> >    setting.
> > 
> >  - there are no pin mode (re-tasking) controls for the mic or headphone jack
> >    in alsamixer.  On this laptop the mic jack should have various bias
> >    options as well as line-in.  The headphone jack should include headphone
> >    (aka output amplifier on), line-out (output amplifier off), line-in and
> >    mic options.
> > 
> > The second ADC does show up in alsamixer as a second capture device, but
> > probably due to the lack of retasking support it is not possible to select
> > the headphone jack as an input option.
> 
> The jack retasking of the headphone input is still an open issue.
> I can provide a patch to add the support via "Headphone Jack Mode"
> enum, but David didn't like that approach.

What alternative has been proposed?  On this laptop the headphone jack can
be retasked as an input and there doesn't appear too many other options
other than to expose this to the user via a mode control of some kind. 
Similarly, the mode of the "line in" jack can also be changed between
various "mic" modes with different biases and - most importantly for me - a
line in mode.  JFTR I also recall that on other laptops the "line in" jack
could be set to function as an output (this doesn't work on the S7020 due to
the circuit used for that jack).

> > Audio does come out of the headphone jack.  However, as noted above it is
> > not possible to switch this from headphone to line-out.  The volume of the
> > headphone output is affected by the "master" and "headphone" volume
> > controls.
> 
> OK, this should be added similarly via "Headphone Jack Mode" enum.

Agreed.  But if a "Headphone Jack Mode" enum is not the preferred option,
how else can we make this happen?

> > The inability to set the pin modes is a showstopper for me - I need to be
> > able to do this and thus will be stuck on older kernels until this is fixed.
> > 
> > At the end of this post I have included the /proc/asound/card0/codec#0
> > output under 3.3.5 (which works well) and 3.7.1 (which is broken as
> > described above).
> > 
> > What needs to be done to restore the functionality for the S7020 that has
> > been working for years?  It seems that some form of model quirk needs to be
> > ported into the new HDA framework from earlier kernels, but since this sort
> > of thing appears to have been removed with the rewrite (at least for realtek
> > codecs) it's difficult to see where to begin.
> 
> At best, please give alsa-info.sh outputs on both old and new kernels.

I will post these in a follow-up within a few minutes.

> We won't add any longer too much machine-specific code.  In the long
> run, (most of) all codec drivers will be merged to a single driver.
> So, let's fix the easier one, the auto-mute breakage at first, and
> proceed to add the missing mixer enums for introducing the finer jack
> retasking.

Ok.  Personally I don't care for auto-mute at all: I need to be sure that
the speakers will never output audio even if the headphone jack is pulled. 
That is, my normal mode of operation will be to have auto-mute disabled
which should - I assume (once the bug is fixed) - produce separate headphone
and speaker mixer controls as it always has.

As a general comment, sometimes it is essential to maintain full manual
control over the mixer hardware so it doesn't get automagically reconfigured
for some odd reason in the middle of an event, resulting in unintended audio
routing.  I certainly don't mind the provision of a more automated system
which works for the common case, so long as it doesn't result in the removal
of manual control for those of us who need it.

Regards
  jonathan
