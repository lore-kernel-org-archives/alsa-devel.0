From: Peter Oehry <peter.oehry@gmx.li>
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Sun, 13 Aug 2006 23:48:25 +0200
Message-ID: <20060813214825.5654969E159@zeus.olymp.home>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
	<1155056548.23266.267914050@webmail.messagingengine.com>
	<20060808184722.6627D55E2E7@zeus.olymp.home>
	<20060808222250.kgpv3965ss0oowoo@webmail.supelec.fr>
	<20060808214138.419D4DE279@zeus.olymp.home>
	<20060809000741.7zournuj4c0wcwc8@webmail.supelec.fr>
	<20060810213340.A53144FA617@zeus.olymp.home>
	<20060811112018.8j3chcuqg4c444w4@webmail.supelec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060811112018.8j3chcuqg4c444w4@webmail.supelec.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Aug 2006 11:20:18 +0200
Thibault Le Meur <Thibault.LeMeur@supelec.fr> wrote:

I was able to get some sound in with real 24-Bit :-)

> 
> If the  Interfaces/AltSets mappings are exactly the same for your 
> device and the audiophile usb, why not try to recompile the usbaudio.c 
> driver with:
> * the big-endian patch (adding your usb_id to the previously mentionned 
> function)
> * add your usb_id (already used for the audiophile usb) to the following code:
> + + /* audiophile usb: skip altsets incompatible with device_setup + */ 
> + if (chip->usb_id == USB_ID(0x0763, 0x2003) && + 
> audiophile_skip_setting_quirk(chip, iface_no, altno)) + continue;t

The problem, why your patch didn't work in the first try has different reasons:

1. The mapping of the altsets is not the same:
The Fast Track Pro has an aditional 96k altset, the 16-Bit alstest ist 1 (or 4)...
and so on. You can see it in the lsusb that I posted.

2. Another interesting thing is that in fact the device sensds the data little endian in 16-Bit mode and big endian in 24-Bit mode.

It ist possible that the unused digital input caused some sync problems. But I can not fully test this. I found two solutions to get the desired mode working.

1. Is the way you were going. With some parameters given to the module, the driver decides which settings are kept and which are thrown away. This will result to a working device in the given mode.

2. It was also possible to enter the right mode by doing the same thing the windows driver does. First reset all interfaces to altset zero. And then initialize ALL interfaces used for the desired mode with the right altset.

For what I think it should be possible to switch modes without restarting the kernel module and switch on and off the device. It should be possible to switch the mode by resetting all interfaces and setting up the new altsets like the windows driver does. This would eventually need a new proc interace that reads the configuration word instead of the module parameter. Would this be an idea for you.

It will take me some more time to do testing in different modes. I'll also complete as much of the different settings as I can so that I can post an almost complete patch to support the Fast Track Pro. I'd have most problems with thesting the digital interface.

How do I know if I also need a quirk for the midi devices? The devices are regonized by alsa now without any quirk but I was not able to test them if they are working.

Regards,
Peter Oehry

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
