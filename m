From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: USB disconnect/connect messages
Date: Mon, 21 Jul 2003 19:03:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F1C2AF1.1030106@superbug.demon.co.uk>
References: <3F1B2870.3070505@superbug.demon.co.uk> <s5hoeznj405.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoeznj405.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 21 Jul 2003 00:40:32 +0100,
> James Courtier-Dutton wrote:
> 
>>Hi,
>>
>>Is there any way to tell if a USB sound card has been disconnected or not?
> 
>  
> IIRC, this is not notified to the application.
> the app simply would get an error at the further access.
> it sounds not bad to notify the status change to the application by
> some way.
> perhaps we can add a new control element for this purpose.
> and after disconnection, only this element survives to communicate
> with the application...
> 
So, the app gets an error. Which error?
How do I test to see if the error is due to a non-existant device, or 
just underrun/overrun etc.
I would be happy if there was a reliable way to tell.
This would only give us the "disconnect" event.
How would one know if the device was connected again?
Maybe a tidy way to do this would be a new alsa events device.
So, we open the "events" device, and it can then inform us of hardware 
changes. I know that USB is the only form of device that 
connects/disconnects via a user action at the moment, but I am sure 
others will come along. E.g. Bluetooth etc.
For USB, usbaudio.c definitely gets informed about usb device 
removal/addition, how can we get that message passed up to the application?

Cheers
James






-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
