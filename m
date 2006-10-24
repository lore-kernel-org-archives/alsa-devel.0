From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Problems with Realtek ALC260 codec
Date: Wed, 25 Oct 2006 09:23:55 +0930 (CST)
Message-ID: <200610242353.k9ONrtuI016925@turbo.physics.adelaide.edu.au>
References: <1161687383.8728.42.camel@leeloo.asplinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1161687383.8728.42.camel@leeloo.asplinux.ru> from "Andrew L.
	Neporada" at Oct 24, 2006 02:56:22 PM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Andrew L. Neporada" <nepal@asplinux.ru>
Cc: alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Andrew

> > > > It seems that I have a laptop with ALC260 codec that is absolutely
> > > > silent either with alsa-driver-1.0.13 or with Realtek's
> > > > alsa-driver-1.0.12-4.05b.
:
> > > > lspci -nv:
> > > > ...
> > > > 00:1b.0 Class 0403: 8086:27d8 (rev 02)
> > > >         Subsystem: 161f:2057
> > > >         Flags: bus master, fast devsel, latency 0, IRQ 3
> > > > :
> > > > cat /proc/asound/card0/codec#0 (from 1.0.13) :
> > > > 
> > > > Codec: Realtek ALC260
> > > > Address: 0
> > > > Vendor Id: 0x10ec0260
> > > > Subsystem Id: 0x161f0000
> > > > Revision Id: 0x100400
> > > 
> > > Could you please try compiling alsa-driver-1.0.13 after configuring it
> > > using
> > >   ./configure --enable-debug
> > > 
> > > Then use model=test.  Turn every control up, unmute every control, change
> > > all "pin mode" controls to "headphone" and see if you get any sound then
> > > from anywhere.  If not, try turning all the GPIO controls ON (they default
> > > to OFF).
> > > 
> > 
> > Using model=test does not change anything - still no sound. Btw, thre is
> > no "pin mode" or GPIO controls in alsamixer - here is output of "amixer
> > scontrols" (with model=test):
> > 
> > Simple mixer control 'PCM',0
> > Simple mixer control 'Front',0
> > Simple mixer control 'Front Mic',0
> > Simple mixer control 'Line',0
> > Simple mixer control 'Mic',0
> > Simple mixer control 'IEC958',0
> > Simple mixer control 'Capture',0
> > Simple mixer control 'Capture',1
> > Simple mixer control 'Caller ID',0
> > Simple mixer control 'Input Source',0
> > Simple mixer control 'Input Source',1
> > Simple mixer control 'Off-hook',0

There should be more controls than this and the ones given here have the
wrong names.  This doesn't look like the "test" model is in use.  However,
you then went on to say ...

> Oops! Please ignore my last message. I can now hear sound from Mic jack
> (!) and from Line Out jack (though very faint). There is no sound from
> internal speakers or from headphone jack.

Ok, this is a start.  It's a concern that the Line Out jack is faint;
again it seems that perhaps there's something between it and the ALC260
which is controlled by something external to the ALC260.  However, I'll
keep an open mind.  I assume that you turned everything up and unmuted
everything when doing this test.  For the "Pin mode" controls it would
also be worth changing each of them at least once - if they are already
"line-out" or "headphone" change them to something else and then back
again.  This eliminates another possible hardware-dependent issue.

I also assume that you tried turning all GPIO controls "on" at some
point and that this didn't make any difference.

> > Could you please let us know the make and model of the laptop?
> 
> It is a some kind of Taiwan OEM laptop for local Russian brand. I'll try
> to find out its real model name.

Thanks for this.  The brand/model as known in Russia would be fine.

Regards
  jonathan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
