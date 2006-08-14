From: peter.oehry@gmx.li
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Mon, 14 Aug 2006 14:14:16 +0200
Message-ID: <20060814141416.nkc3usnogk0w044o@zeus.oda.li>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
	<1155056548.23266.267914050@webmail.messagingengine.com>
	<20060808184722.6627D55E2E7@zeus.olymp.home>
	<20060808222250.kgpv3965ss0oowoo@webmail.supelec.fr>
	<20060808214138.419D4DE279@zeus.olymp.home>
	<20060809000741.7zournuj4c0wcwc8@webmail.supelec.fr>
	<20060810213340.A53144FA617@zeus.olymp.home>
	<20060811112018.8j3chcuqg4c444w4@webmail.supelec.fr>
	<20060813214825.5654969E159@zeus.olymp.home>
	<1155554196.1617.268317929@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1155554196.1617.268317929@webmail.messagingengine.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net, Thibault Le Meur <Thibault.LeMeur@supelec.fr>
List-Id: alsa-devel@alsa-project.org

Quoting Clemens Ladisch <cladisch@fastmail.net>:

> Peter Oehry wrote:
>> Thibault Le Meur <Thibault.LeMeur@supelec.fr> wrote:
>> 2. Another interesting thing is that in fact the device sensds the data
>> little endian in 16-Bit mode and big endian in 24-Bit mode.
>
> IIRC other M-Audio devices to that, too.  The reasons seems to be that
> the device is basically big-endian, but the 16-bit interfaces are
> designed to work with Windows' usbaudio.sys.
>
>> For what I think it should be possible to switch modes without restarting
>> the kernel module and switch on and off the device. It should be possible
>> to switch the mode by resetting all interfaces and setting up the new
>> altsets like the windows driver does. This would eventually need a new
>> proc interace
>
> Why proc?
>
> If the configuration needs to be changed at runtime, and if the driver
> cannot do this automatically, a mixer control would be the best solution.
>

This sounds good to me :-) Is the mixer interace good to understand or  
is there some documentation on it? So I could try to do some testing  
on that.

Would such a solution be accepted in the driver?

>> How do I know if I also need a quirk for the midi devices?
>
> You need a quirk when there aren't any class-specific descriptors for
> the MIDI port.

Thank you. That will mean that it should work with the Fast Track.  
I'll organise a MIDI device and thest this. :-)

>
>
> Regards,
> Clemens
>
>
>



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
