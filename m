From: Tim Small <tim@buttersideup.com>
Subject: snd-usb-audio hacking
Date: Thu, 03 Jul 2003 19:13:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F04723C.2040401@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

I've got a USB device which nearly works with ALSA cvs-current.  It's an 
Abit UA11, and is a pretty simple device, with one SPDIF optical in, and 
one optical out.  I'm trying to use it with an offboard HiFi DAC.  The 
particular problem with it is related to setting the sample rate, after 
being told a particular rate, the device reports a very high sample rate 
back (approx 128k). 

Playback sort of works at this rate, using OSS emulation - it looks like 
the device down-samples to 48kHz.  I occasionally get oopses under 
2.4.21, I can't get any output from the device under 2.5.74 ("cannot 
submit datapipe for urb 0, err = -22").  My other USB audio device - a 
stereo-link SL1200, doesn't give any output on this kernel either.

I'm going to try to get the device working with 2.4.22-pre2, but I just 
wanted to check if this sounded like a sensible thing to do?   My test 
hardware is a Celeron 300, on an Intel 440LX motherboard (uhci).  The 
device works pretty well under Windows2000, and Windows98 on the same 
hardware (although the sample rate seems to wander about a bit, and this 
causes reclocking problems with one of my DACs), and I've got a setup 
USB trace under w98, using snoopypro  - 
http://sourceforge.net/projects/usbsnoop/

Is this the right place to be asking these questions, (or should I go 
off to the usb dev lists etc.?)..

Cheers,

Tim.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
