From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio - Silence
Date: Thu, 14 Jul 2005 16:21:16 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507141549090.16721-100000@studcom.urz.uni-halle.de>
References: <200507141422.59852.luca_ing@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200507141422.59852.luca_ing@libero.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Smery <luca_ing@libero.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Smery wrote:
> On Thu, Jul 14, 2005 at 11:24:27AM +0200, Clemens Ladisch wrote:
> > Smery wrote:
> > >         I have an USB device with one Audio Class interface.
> > > snd_usb_audio detects it and register the corresponding card:
> > > Also recording sems to work fine:
> > >
> > > The problem is that I obtain a file does not contain anything other than a
> > > sequence of "40 00" (hex) bytes.
> >
> > What is the output of "amixer -c 3 contents" and "lsusb -v" for your
> > device?
>
> [luca@luca ~]$ amixer -c 3 contents
> numid=1,iface=MIXER,name='PCM Capture Switch'
>   ; type=BOOLEAN,access=rw---,values=1
>   : values=on
> numid=2,iface=MIXER,name='PCM Capture Volume'
>   ; type=INTEGER,access=rw---,values=1,min=0,max=3,step=0
>   : values=2

Looks OK.

> Bus 001 Device 005: ID 06e1:a708 ADS Technologies, Inc.
> ...
>   bcdUSB               2.00

Please note that ALSA versions earlier than 1.0.9 might synchronize
with a wrong sample rate with USB 2.0 devices, and that Linux kernels
earlier than 2.6.13 have a serious bug in the EHCI driver that will
corrupt data in high-speed audio transfers.

>       ...
>       bInterfaceNumber        0
>       bInterfaceClass       255 Vendor Specific Class

The first interface uses some vendor-specific protocol for the video
stuff.  It might be possible that video capture has to be enabled for
audio capture to work.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
