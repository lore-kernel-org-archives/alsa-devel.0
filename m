From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Wed, 09 Aug 2006 00:07:41 +0200
Message-ID: <20060809000741.7zournuj4c0wcwc8@webmail.supelec.fr>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
	<1155056548.23266.267914050@webmail.messagingengine.com>
	<20060808184722.6627D55E2E7@zeus.olymp.home>
	<20060808222250.kgpv3965ss0oowoo@webmail.supelec.fr>
	<20060808214138.419D4DE279@zeus.olymp.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060808214138.419D4DE279@zeus.olymp.home>
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

> Thank you for all this information!

You're welcome, I had that much difficulties in finding these mapping 
that I'm happy to see it can be usefull for other devices ;-)

> I'll need some time to check what is needed for the Fast Track Pro.

In fact it's not that tricky: just install a usb sniffer under windows, 
then play with the control panel and check the SELECT_INTERFACE 
messages for Interface/AlternateSetting. With the audiophile USB, it 
only changes:
* if you change the bit depth
* if you change the sampling rate
* if you enable/disable the SPDIF input

> I think there is a big chance that many things are handled the same 
> way like Audiophile. At least the number of Channels and also the 
> mapping of digital an analog interfaces are the same. I tried to 
> connect directly to the 24-Bit mode after startup of the USB device 
> and I had the same "wrong" signal on both channels. This makes me 
> positve to believe that the byte alignement (like you described) gets 
> mixed up after mode switching.

Yes that sounds exactly the same...

> The distortion I head on both channels could have something to do 
> with endianess. Instead of a sine wave I had a 3rd Harmonic at level 
> of about -55dB (in the range of one byte) and the noise level was 
> about -80dB (the range of the second byte).

The relevant section in usbaudio.c is the "is_big_endian_format" function.
Maybe just testing by adding your usb_id in this function will correct 
endianness ?

See:

2297 /* 2298 * check if the device uses big-endian samples 2299 */ 2300 
static int is_big_endian_format(struct snd_usb_audio *chip, struct 
audioformat *fp) 2301 { 2302 switch (chip->usb_id) { 2303 case 
USB_ID(0x0763, 0x2001): /* M-Audio Quattro: captured data only */ 2304 
if (fp->endpoint & USB_DIR_IN) 2305 return 1; 2306 break; 2307 case 
USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */ 2308 return 1; 
2309 } 2310 return 0; 2311 }


Regards,
Thibault


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
