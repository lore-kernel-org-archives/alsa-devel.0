From: Andrew Burgess <aab@cichlid.com>
Subject: Re: snd-usb-audio hacking
Date: Thu, 17 Jul 2003 08:18:03 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307171518.h6HFI3w11165@athlon.cichlid.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Playback sort of works at this rate, using OSS emulation - it looks like 
>the device down-samples to 48kHz.  I occasionally get oopses under 
...
>Is this the right place to be asking these questions, (or should I go 
>off to the usb dev lists etc.?)..

My philosophy is to check the oops backtrace. If it dies in usb then
bug the usb guys to make it more robust so even if it is an alsa
bug, usb should print an error rather than oops. Vice versa if it
dies in alsa.

USB/ALSA bugs are tough because of two distinct developer camps.

I have a Griffin USB iMic that hard hangs 2.4.21ac just by running arecord and
then ^C. I got no response here a few weeks ago...



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
