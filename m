From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: Question regarding the CS4205 driver (used in all current Dell notebooks)
Date: Tue, 30 Apr 2002 17:57:58 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <aan475$a6k$2@main.gmane.org>
References: <20020430122051.GA4044@shaftnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020430122051.GA4044@shaftnet.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Stuffed Crust' <pizza@shaftnet.org>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

First off, thank you for your reply.

Well, for starters, getting full duplex to work surely would help, since
without it it pretty much kills any kind of real-time audio usefulness
and/or audio monitoring.

Here's the behavior description:

My config:
RH 7.2 (no mods)
Kernel: 2.4.7

Inspiron 8200
P4 1.6GHz
G4Go 440
CS4205 Soundcard

OSS/Free
Sound works (single stream otherwise /dev/dsp resource busy error greets
the user). When trying to do Duplex, it simply reports error that it
fails to open the device in the duplex mode.

OSS/Commercial
Sound output works, and duplex works but sounds like crap, so one could
say that it really does not work. The output is just bunch of clicks
that have appropriate volume envelope, but that is about it. If two
streams are attempted to be played simultaneously, the second one
distorts the first one for a second or two, then stops and after the
first stream is done I get bunch of errors and noise close to white
noise.

ALSA (0.9.12)
Sound output works, and duplex behaves like OSS/Commercial. Ina
addition, there are a bunch of loud clicks every time sound kicks in. In
addition. Snd app is completely unusable in terms of recording (cannot
select mic input or the signal is so quiet that even if I tap directly
on the built-in mic the level gauge barely moves).

At this point I am guessing maybe I need to investigate:

1) try a distro with the 2.4.18 kernel/ RH 7.3 (which should be due
soon)

2) see if the P4 mobo chipset has anything to do with this since 4100
series still run only P3's.

3) pester people on this message board some more ;-)

4) Give up on it

Any help is utmostly appreciated!

Ico




> -----Original Message-----
> From: Stuffed Crust [mailto:pizza@shaftnet.org]
> Sent: Tuesday, April 30, 2002 8:21 AM
> To: Ivica Bukvic
> Cc: alsa-devel@lists.sourceforge.net; alsa-user@lists.sourceforge.net
> Subject: Re: [Alsa-devel] Question regarding the CS4205 driver (used
in
> all current Dell notebooks)
> 
> On Tue, Apr 30, 2002 at 01:06:01AM -0400, Ivica Bukvic wrote:
> > I've been trying to get the Crystal Sound (CS4205) notebook (Dell
> > Inspiron 8200) soundcard to work with both OSS and Alsa (although I
> > would prefer to get Alsa working rather than OSS), but it seems that
> > both drivers have insufficient info about this card to get it to
work. I
> > did get it to "spit-out" sound, but that is the extent of it. I am
using
> > intel8x0 audio driver (since CS4205 seems to be just the AC97 codec
> > while the Intel's chip does the work), but it only allows me
non-duplex
> > operation which is horrible for any kind of serious audio purposes.
> 
> So it works, but it doesn't work?
> 
> I have an Inspiron 4100, which also has a cs4205.   I've never tried
full-
> duplex operation, but it otherwise outputs sound like a champ.  (I'm
> also the one who wrote the sp/dif support code for it..)
> 
> So, we need a little more information about what does and what doesn't
> work.   Hell, I'm listening to a mp3 right now...
> 
>  - Pizza
> --
> Solomon Peachy
pizzaATfucktheusers.org
> I ain't broke, but I'm badly bent.                           ICQ#
1318344
> Patience comes to those who wait.
>     ...It's not "Beanbag Love", it's a "Transanimate Relationship"...



_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
