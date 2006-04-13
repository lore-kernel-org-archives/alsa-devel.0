From: John Rigg <ad@sound-man.co.uk>
Subject: Re: 16-channel recording w/ LAYLA, ALSA, JACK, ARDOUR
Date: Thu, 13 Apr 2006 20:39:47 +0100
Message-ID: <20060413193947.GA2738@localhost.localdomain>
References: <20060412200957.GA4090@hurl.ugcs.caltech.edu> <1144873089.27496.22.camel@mindpipe> <1144878001.27496.33.camel@mindpipe> <20060413031705.GA9160@hurl.ugcs.caltech.edu> <1144898970.10666.139.camel@localhost.localdomain> <20060413053945.GB11100@hurl.ugcs.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060413053945.GB11100@hurl.ugcs.caltech.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lance Blisters <geoff@hurl.ugcs.caltech.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 12, 2006 at 10:39:45PM -0700, Lance Blisters wrote:
> On Wed, Apr 12, 2006 at 11:29:30PM -0400, Paul Davis wrote:
> > On Wed, 2006-04-12 at 20:17 -0700, Lance Blisters wrote:
> > 
> > > ALSA: cannot configure playback channel
> > > cannot load driver module alsa
> > 
> > i don't believe that "multi" will work without the MMAP_COMPLEX patch to
> > JACK that has been outstanding for months and months. its available in
> > the patch tracker at jackit.sf.net if you want to try it; otherwise i
> > intend to merge it next week or the week after.
> 
> So the only way to get 16 channels from the LAYLA is via 
> MMAP_COMPLEX and multi?
> 
> Do you think the above problem is a direct result of lacking
> MMAP_COMPLEX functionality, and .asoundrc might be otherwise 
> correct?
> 
> > this command: 
> > 
> >    jackd -d alsa -P hw:0 -C hw:1
> > 
> > opens different devices for capture and playback
> 
> Great! I was thrown by the single Interface selection
> in qjackctl, and my assumption that different cards
> for input and output would present similar drift and
> synch problems as outputting to multiple cards.

Analog and digital inputs and outputs on the same physical card use the
same word clock even if you have separate virtual devices defined.

Another thing: if you try to use -o2 ALSA doesn't like it.
Anything other than the full number of channels (the default)
doesn't work, which seems to defeat the object of the -o option. Just
leave the -o option out (same applies to -i).

Since your analogue and digital in/outs are different logical devices
you might have to remove the linking code that was added to pcm_multi.c
between alsa-lib versions 1.0.8 and 1.0.9rc1. This broke duplex jackd
operation with multiple cards; it's possible that it affects your
multiple devices too. You might also need MMAP_COMPLEX support in jackd.

John


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
