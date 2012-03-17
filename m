From: Adam Williamson <awilliam@redhat.com>
Subject: Re: Internal speaker output from Sony Vaio Z (2010
 model) lost somewhere between 3.1.0 and 3.2.6
Date: Fri, 16 Mar 2012 19:51:10 -0700
Message-ID: <1331952670.1841.4.camel@adam>
References: <1331939409.22414.29.camel@adam>
	<CAN8ccibZfNEd05FDwcb2XENaW7VFkkun2GFJ2xxGmLyKgzdw-g@mail.gmail.com>
	<1331950527.1841.1.camel@adam>
	<CAN8cciafudunXn-=DZaJHKQ5bBsLUhp2EGmsH+mYJW38QqJxWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by alsa0.perex.cz (Postfix) with ESMTP id C516D24572
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 03:51:15 +0100 (CET)
In-Reply-To: <CAN8cciafudunXn-=DZaJHKQ5bBsLUhp2EGmsH+mYJW38QqJxWQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2012-03-17 at 10:40 +0800, Raymond Yau wrote:
> 2012/3/17, Adam Williamson <awilliam@redhat.com>:
> > On Sat, 2012-03-17 at 10:04 +0800, Raymond Yau wrote:
> >> 2012/3/17, Adam Williamson <awilliam@redhat.com>:
> >> > Welp, pretty much as the topic says.
> >> >
> >> > I just noticed today that sound is no longer playing from the internal
> >> > speakers of my laptop, a 2010 model Sony Vaio Z. Plugging in headphones
> >> > causes sound to be played fine through those. There are three possible
> >> > choices for 'Connector' - 'Analog Speakers', 'Analog Output', and
> >> > 'Analog Headphones' - but none of these seems to make sound come out of
> >> > the internal speakers. The default is 'Analog Speakers', and when it's
> >> > set to this, headphone output does work when headphones are plugged in.
> >> >
> >> > I've verified that it's broken on Fedora 16 kernels 3.2.6-4, 3.2.8-3 and
> >> > 3.2.10-1. It's also broken in a very recent Fedora 17 kernel, 3.3.0rc6
> >> > or so. It works on a Fedora 16 live image, with kernel 3.1.0-1.
> >> > Unfortunately the kernels before 3.2.6 have been trashed from Fedora's
> >> > buildsystem archives, I think, so it's hard to narrow things down any
> >> > further :/
> >> >
> >> > the alsa-info output is
> >> > http://www.alsa-project.org/db/?f=368e2359757b537d4daa0f5399830d3942540196
> >> > .
> >> >
> >>
> >> it is a bug if sound preference allow user to select speaker when
> >> auto-mute mode is enabled (the speaker is automatically muted by the
> >> driver when you plug the headphone)
> >
> > Then I guess that's another bug :) Because yes, the laptop does
> > auto-mute by default. When the speakers are actually working, if I plug
> > in headphones, the speakers get muted and the headphones work. No need
> > to manually select an output.
> 
> http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm#multistream
> 
> AFAIK, multistreaming is not yet implemented for desktop using realtek codecs
> 
> The ALC889 provides ten DAC channels that simultaneously support 7.1
> sound playback, plus 2 channels of independent stereo sound output
> (multiple streaming) through the front panel stereo outputs.

I think maybe you're misunderstanding the problem?

It's a very simple, straightforward problem. In the simplest possible
configuration - I turn the laptop on, with absolutely default settings
of everything (I've tested from a clean boot of a freshly written F17
live image), and nothing connected to *any* of the jacks, and attempt to
play any kind of sound - I hear nothing. PA is running and shows the app
playing sound, everything reports as if sound was being played, but no
sound is heard over the internal speakers.

With kernel 3.1.0, it works fine: I do the above, and I hear sound. It's
simply some kind of regression in the mapping for this chipset that
occurred between 3.1.0 and 3.2.6.

I am not expecting to hear sound through both the internal speakers and
the headphone jack. That's not what I'm saying.
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | identi.ca: adamwfedora
http://www.happyassassin.net
