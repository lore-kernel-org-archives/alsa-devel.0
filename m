From: Martin Langer <martin-langer@gmx.de>
Subject: Re: usbus428 0.0.7 patch against release alsa-driver 0.9.6 (was Re: tascam gives a go for us428 @ alsa ...)
Date: Mon, 11 Aug 2003 01:26:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030810232609.GA478@tuba.home>
References: <200304301356.34023.annabellesgarden@yahoo.de> <s5hfzntcz7q.wl@alsa2.suse.de> <200307302133.37883.annabellesgarden@yahoo.de> <s5h3cgdle87.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h3cgdle87.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net, us428@drehmoment.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 07, 2003 at 04:44:08PM +0200, Takashi Iwai wrote:
> At Wed, 30 Jul 2003 21:33:37 +0200,
> Karsten Wiese wrote:
> > 
> > new here is:
> > - both firmware-downloads are handled now by the snd-usb-us428-dl module (this 
> > functionality should move further on into userspace via libusb ? volunteers?)
> 
> yes, definitely it's the right way to go.
> 

I've looked into my US122 and there I've found an EZUSB chip. The US428
might be the same.

I think the first download step which also changes the ID has to be the ezusb
firmware. 

After comparing that sniffed log with some available windows binaries from
Tascam, I finally found the data in US122DL.SYS/US428DL.SYS/US224DL.SYS.
Instead of loading the sniffed file it could also be an extract from 
USx2xDL.SYS (it should be similar to the MidiSport firmware extract and
loading procedure).

That could be an easy way to move the first firmware part away from the driver
directory. And we won't need another ok from Tascam for including
sniffed us224/us122 firmware...

I will check it on us122 if I've little bit more time.... 


martin



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
