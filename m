From: Manush Dodunekov <manush@stendahls.net>
Subject: Re: unitor8/amt8 driver for alsa 0.9.0rc1
Date: Wed, 1 May 2002 12:52:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.40.0205011238180.988-100000@dunk.hq.fett.net>
References: <001001c1f100$4cab6700$0400a8c0@martijn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <001001c1f100$4cab6700$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 1 May 2002, Martijn Sipkema wrote:

> > The following patch:
> >
> > http://fett.net/m/alsa/alsa-0.9.0rc1-unitor8.patch
> >
> > implements a driver for the Emagic Unitor family of multiport MIDI
> > interfaces. Only serial connection is supported. You need to rerun the
> > autoconf toolchain after applying the patch.
> >
> > The driver is heavily based on serial-u16550.c, which may be the wrong
> > concept. A more correct concept seems to have a generic-serial.c and
> > generic-usb.c, which only implement a communication channel. The interface
> > drivers could then load&use them and only implement their own
> > init/port-select/whatever dialect. Lots of MIDI interfaces come with both
> > USB and serial connectors nowadays. Any thoughts on this?
>
> This is nice. What documentation did you use for writing the driver?

http://www.math.tu-berlin.de/~sbartels/unitor/unitor8_doc.txt

It's in German. I have a translation of it I made using some online
translation thingy a while ago, but I still find the German version a bit
more readable (and my German really sucks).


> I think a driver for interfaces like the unitor should not be in the
> kernel. The standard serial port driver already allows access to the
> device.

I agree. However, I needed something working fast =)


> Also, using a kernel driver does not allow using many different serial
> hardware, right?

I don't see why not. As long as it doesn't limit itself to a maximum of
one instance at a time.


> A solution could be alter libasound to support non-kernel drivers. Or
> use a loopback device in the kernel. Perhaps only supporting the alsa
> sequencer is an option.

I like the libasound driver idea. A while ago, there was some talk about
moving the sequencer stuff to user level too, with all that low-latency
stuff happening in the kernel nowadays. What do you ALSA guys think about
this?


> I am myself still working on a library for MIDI i/o that uses plugins
> for device access and IMHO provides a better interface than alsa
> rawmidi.

I thought of this as well, but I would like to use the alsa sequencer API
for some experiments.

-- 
Manush
