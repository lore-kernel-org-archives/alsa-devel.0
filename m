From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Mon, 14 Aug 2006 11:57:35 +0200
Message-ID: <20060814115735.by78lvrhbd4484ww@webmail.supelec.fr>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
	<1155056548.23266.267914050@webmail.messagingengine.com>
	<20060808184722.6627D55E2E7@zeus.olymp.home>
	<20060808222250.kgpv3965ss0oowoo@webmail.supelec.fr>
	<20060808214138.419D4DE279@zeus.olymp.home>
	<20060809000741.7zournuj4c0wcwc8@webmail.supelec.fr>
	<20060810213340.A53144FA617@zeus.olymp.home>
	<20060811112018.8j3chcuqg4c444w4@webmail.supelec.fr>
	<20060813214825.5654969E159@zeus.olymp.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060813214825.5654969E159@zeus.olymp.home>
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
To: Peter Oehry <peter.oehry@gmx.li>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> On Fri, 11 Aug 2006 11:20:18 +0200
> Thibault Le Meur <Thibault.LeMeur@supelec.fr> wrote:
>
> I was able to get some sound in with real 24-Bit :-)

Great news..

> The problem, why your patch didn't work in the first try has 
> different reasons:
>
> 1. The mapping of the altsets is not the same:
> The Fast Track Pro has an aditional 96k altset, the 16-Bit alstest 
> ist 1 (or 4)...
> and so on. You can see it in the lsusb that I posted.

Yes I should have been able to see, but I was too busy (and lazy) to 
have a look ;-) sorry.


> 2. Another interesting thing is that in fact the device sensds the 
> data little endian in 16-Bit mode and big endian in 24-Bit mode.

Strange... but M-Audio is used to having strange usb device ;-)

The issue, here, is that the current usbaudio driver expect a device to 
be fully big endian or little endian. I haven't seen anywhere a support 
for partially big-endian devices... this will require a small bit of 
code to change that.

> It ist possible that the unused digital input caused some sync 
> problems. But I can not fully test this.

This will not be an issue if the correct Interfaces/AltSet are activated.

> I found two solutions to get the desired mode working.
>
> 1. Is the way you were going. With some parameters given to the 
> module, the driver decides which settings are kept and which are 
> thrown away. This will result to a working device in the given mode.

This is not really beautiful but this was the smallest and simplest 
patch I found ;-)

> 2. It was also possible to enter the right mode by doing the same 
> thing the windows driver does. First reset all interfaces to altset 
> zero. And then initialize ALL interfaces used for the desired mode 
> with the right altset.

That would be really great, I would be very interested in such a patch, 
and it could be adapted to the audiophile usb as well.

> For what I think it should be possible to switch modes without 
> restarting the kernel module and switch on and off the device. It 
> should be possible to switch the mode by resetting all interfaces and 
> setting up the new altsets like the windows driver does.

should work (unless I had no luck in trying such thing)

> This would eventually need a new proc interace that reads the 
> configuration word instead of the module parameter. Would this be an 
> idea for you.

For me it would be fantastic, but I'm not the maintainer of the module: 
Clemens and Takashi will have better reply on this.

However I remember a talk with Takashi just before posting my patch, at 
that time he would have prefered a completly new module driver for the 
audiophile usb device. He finally accepted my patch because it was 
small and didn't change things for other devices.

I'm just afraid that your new patch would be much longer, so that the 
question to add it to the general module or to create a new specific 
one (as it had been done for the us-12x driver) might be at stake.

If a new driver is planned, It would be great to make it generic for 
M-Audio usb devices since they should have the same constraints.

> It will take me some more time to do testing in different modes. I'll 
> also complete as much of the different settings as I can so that I 
> can post an almost complete patch to support the Fast Track Pro. I'd 
> have most problems with thesting the digital interface.

Same for me... I had to find other users of the device on the Internet 
to get feedbacks on this.

> How do I know if I also need a quirk for the midi devices? The 
> devices are regonized by alsa now without any quirk but I was not 
> able to test them if they are working.

Why not ? Don't you have a midi device ?
As far as the audiophile usb is concerned MIDI is working without any 
new patch, and I would be surprised if M-Audio had choosen a different 
MIDI implementation for the FastTrack Pro interface, but who knows...

Regards,
Thibault


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
