From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Other types of usb audio devices.
Date: Sat, 05 Jul 2003 12:23:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F06B532.5040207@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

The current snd-usb-audio driver assumes that the audio device is 
attached to this computer, so it only talks to this endpoint.
If I have an audio usb device with USB_CLASS = 0xe0, it will be a 
wireless device. I.E. A bluetooth headset.
It uses isoc's just like the current snd-usb-audio driver but adds some 
extra requirements, in order to open a connection, one needs to also 
know the bd address of the destination device  (Like a MAC address for 
ethernet) and keep tabs of connection number.
The current bluetooth stack I am using is bluez, from the current 2.4.20 
  kernel, and it uses network sockets for the audio. I would prefer to 
use alsa for sending and receiving audio to/from the headset, with all 
other control of the device going via the bluetooth stack.
So the question is: -
How do I get the bdaddr to alsa so that an application can use 
snd_pcm_open with the bluetooth headset, just as if it was a local audio 
card.
I will probably be writing a new usb-audio.c file and probably call it 
usb-wireless.c in order to handle all the bluetooth specific stuff.

Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
