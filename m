From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Other types of usb audio devices.
Date: Sat, 05 Jul 2003 15:27:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F06E046.2090609@superbug.demon.co.uk>
References: <Pine.LNX.4.44.0307051556170.21843-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307051556170.21843-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Sat, 5 Jul 2003, James Courtier-Dutton wrote:
> 
> 
>>Hi,
>>
>>The current snd-usb-audio driver assumes that the audio device is 
>>attached to this computer, so it only talks to this endpoint.
>>If I have an audio usb device with USB_CLASS = 0xe0, it will be a 
>>wireless device. I.E. A bluetooth headset.
>>It uses isoc's just like the current snd-usb-audio driver but adds some 
>>extra requirements, in order to open a connection, one needs to also 
>>know the bd address of the destination device  (Like a MAC address for 
>>ethernet) and keep tabs of connection number.
>>The current bluetooth stack I am using is bluez, from the current 2.4.20 
>>  kernel, and it uses network sockets for the audio. I would prefer to 
>>use alsa for sending and receiving audio to/from the headset, with all 
>>other control of the device going via the bluetooth stack.
>>So the question is: -
>>How do I get the bdaddr to alsa so that an application can use 
>>snd_pcm_open with the bluetooth headset, just as if it was a local audio 
>>card.
> 
> 
> I think that there must be a way to determine new devices with the 
> bluetooth stack, so use the same mechanism as usb or pcmcia:
> 
> Register all found audio devices and create appropriate new cards in the 
> ALSA driver. The application does not know, if it communicates with usb, 
> bluetooth, PCI or ISA devices so passing some native information for the 
> transport layer is not our goal.
> 
> 						Jaroslav

Another approach would be to use some other tool outside alsa to enter 
the bdaddr, and just present a Playback and Capture PCM to alsa lib.
I was thinking that the "card" would be the bluetooth usb dongle, and 
the pcm's would dynamically appear and disappear as the user attaches 
different bluetooth devices (e.g. headset).

Does alsa allow for PCMs to appear and disappear?
E.g. Card appears but no pcms listed in /proc/asound/card0
User runs a tool (attach-bluetooth-pcm) what sorts out a pairing of 
bluetooth devices and then creates a PCM device in /proc/asound/card0
User changes devices, and has to re-run attach-bluetooth-pcm to remove 
the old PCM, and create a new one of the new device.
OR: -
Would a new "card" have to be created for each bluetooth headset?
Is alsa happy with dynamically adding and removing cards ?

Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
