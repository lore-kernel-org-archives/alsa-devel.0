From: Artem Makhutov <artem@makhutov.org>
Subject: Re: Huawei K3715 UMTS stick and alsa
Date: Wed, 29 Jul 2009 11:33:31 +0200
Message-ID: <20090729093331.GB26953@titan.makhutov-it.de>
References: <20090726224300.GA26953@titan.makhutov-it.de>
	<4A6EAA7E.4090207@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bane.moelleritberatung.de (bane.moelleritberatung.de
	[77.37.2.25]) by alsa0.perex.cz (Postfix) with ESMTP id E2618103852
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 11:33:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A6EAA7E.4090207@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

On Tue, Jul 28, 2009 at 09:36:30AM +0200, Clemens Ladisch wrote:
> Artem Makhutov wrote:
> > i am wondering if it is possible to write a quirk in usbquirks.h for a Huawei
> > K3715 UMTS stick to make the audio interfaces available in linux.
> 
> What kind of audio does this UMTS stick have?

This is a good question. In Windows you can use the Huawei "Mobile Partner"
software to make voice calls using the UMTS stick. You just start the software
and can dial a phone number from there. Then you can use your Headset and/or
Noteboot Microphone to talk with the other partie.
 
> > This two interfaces are used for audio (I have sniffed in Windows):
> > 
> > bEndpointAddress     0x83  EP 3 IN
> > bEndpointAddress     0x02  EP 2 OUT
> 
> The lsusb output shows that these are bulk endpoints.  The snd-usb-audio
> driver is designed for isochronous endpoints; a simple quirk would not
> suffice.

Ok, thank you for the info.

I did some more tests and have seen that Windows is creating 3 serial ports
(COM15, COM16, COM17) for the UMTS stick. It sends the AT commands to COM17 and
(I believe) receives and sends audio over COM16. It is not possible to send any
AT commands to COM16.

If you create a dialup connection then COM15 will be used for it.

In Linux the option module is also creating 3 serial ports (/dev/ttyUSB0,
/dev/ttyUSB1 and /dev/ttyUSB2).

I have done some small test with some AT commands using Windows and was trying
to get audio to COM16 without the "Mobile Partner" software. But it did not
worked.

> > The payload of this interfaces is 320 bytes.
> 
> How many bytes per second?

Unfortunately I did not had much time to do more detailed test.
I will do some more test and will report this.

Thanks and best regards, Artem

PS: What is a good software for doing USB reverse engineering?
I have seen usb-robot and USB Snoopy on Linux, but USB Snoopy is from the year 2000...
