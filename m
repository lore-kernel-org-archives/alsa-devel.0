From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Other types of usb audio devices.
Date: Sat, 5 Jul 2003 15:58:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307051556170.21843-100000@pnote.perex-int.cz>
References: <3F06B532.5040207@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F06B532.5040207@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 5 Jul 2003, James Courtier-Dutton wrote:

> Hi,
> 
> The current snd-usb-audio driver assumes that the audio device is 
> attached to this computer, so it only talks to this endpoint.
> If I have an audio usb device with USB_CLASS = 0xe0, it will be a 
> wireless device. I.E. A bluetooth headset.
> It uses isoc's just like the current snd-usb-audio driver but adds some 
> extra requirements, in order to open a connection, one needs to also 
> know the bd address of the destination device  (Like a MAC address for 
> ethernet) and keep tabs of connection number.
> The current bluetooth stack I am using is bluez, from the current 2.4.20 
>   kernel, and it uses network sockets for the audio. I would prefer to 
> use alsa for sending and receiving audio to/from the headset, with all 
> other control of the device going via the bluetooth stack.
> So the question is: -
> How do I get the bdaddr to alsa so that an application can use 
> snd_pcm_open with the bluetooth headset, just as if it was a local audio 
> card.

I think that there must be a way to determine new devices with the 
bluetooth stack, so use the same mechanism as usb or pcmcia:

Register all found audio devices and create appropriate new cards in the 
ALSA driver. The application does not know, if it communicates with usb, 
bluetooth, PCI or ISA devices so passing some native information for the 
transport layer is not our goal.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
