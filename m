From: Martin Langer <martin-langer@gmx.de>
Subject: Re: usbus428 0.0.7 patch against release alsa-driver 0.9.6 (was Re: tascam gives a go for us428 @ alsa ...)
Date: Tue, 12 Aug 2003 21:19:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030812191940.GB571@tuba.home>
References: <200304301356.34023.annabellesgarden@yahoo.de> <s5hfzntcz7q.wl@alsa2.suse.de> <200307302133.37883.annabellesgarden@yahoo.de> <s5h3cgdle87.wl@alsa2.suse.de> <20030810232609.GA478@tuba.home> <s5hoeyuj0g1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hoeyuj0g1.wl@alsa2.suse.de>
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

On Tue, Aug 12, 2003 at 06:38:22PM +0200, Takashi Iwai wrote:
> At Mon, 11 Aug 2003 01:26:09 +0200,
> Martin Langer wrote:
> > 
> > I've looked into my US122 and there I've found an EZUSB chip. The US428
> > might be the same.
> > 
> > I think the first download step which also changes the ID has to be the ezusb
> > firmware. 
> > 
> > After comparing that sniffed log with some available windows binaries from
> > Tascam, I finally found the data in US122DL.SYS/US428DL.SYS/US224DL.SYS.
> > Instead of loading the sniffed file it could also be an extract from 
> > USx2xDL.SYS (it should be similar to the MidiSport firmware extract and
> > loading procedure).
> 
> it's nice.  could you compare the stuff with the one in Karsten's
> patch?
> 
> > That could be an easy way to move the first firmware part away from the driver
> > directory. And we won't need another ok from Tascam for including
> > sniffed us224/us122 firmware...
> 
> yep.  that would be far much better.
> 

Success. US122 behaves like a normal ezusb device. And the whole USx2x
family is using the same loader. I think we are at a point where we can
remove that firmware stuff of "us428fw8000.h" and use fxload with an
extracted firmware. Ok, a final test on us428 should be done before.

Pedro's Tascam USx2x extractor/loader is already here and Clemens is on the
way to create an sf project for this wonderful ezusb stuff for MidiSport,   
Tascam devices (and maybe more in the future).

> 
> * what's the reason of the independent snd-usb-us428-dl module?
>   this module seems doing only feeding the firmware to the interface,
>   so why not in snd-usb-us428 itself?  this will reduce the use of
>   inter_module_* stuffs which are obsolete in 2.6 kernels.

I think the main reason was a different PCI ID for loading us428fw8000.h.
And the other firmware part was originally in snd-usb-us428 IIRC!
Ok, removing the sniffed ezusb firmware is a good reason to forget the 
snd-usb-us428-dl idea completely! I agree.


martin


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
