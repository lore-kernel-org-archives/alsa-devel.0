From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [ALSA - driver 0000425]: usb-usx2y: System lockup on PCM device open (OHCI)
Date: Thu, 14 Oct 2004 01:59:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410140159.14019.annabellesgarden@yahoo.de>
References: <20041010133726.CBA7A2801D@server.perex-int.cz> <200410110219.45061.annabellesgarden@yahoo.de> <200410110954.06107.ws@seh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200410110954.06107.ws@seh.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Werner Schweer <ws@seh.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Montag 11 Oktober 2004 11:54 schrieb Werner Schweer:
> On Monday 11 October 2004 00:19, Karsten Wiese wrote:
> > Am Montag 11 Oktober 2004 01:28 schrieb Werner Schweer:
> > > thanks!
> > > with this patch i now get some sound out of my us122. But there are
> > > still sequence errors (and JACK stops). After about 5 minutes of play
> > > the system freezes. My system is a Pentium M notebook with intel ich4
> > > chipset (UHCI usb driver).
> >
> > with the built-in soundcard jack runs fine?
> >
> > Karsten
>
> yes, it does
>
> /werner

Found a bugfix inside uhci-hcd.c (2.6.9-rc2-mm4) that is not needed anymore 
for modern chipsets:

>>> line 122:
static inline void uhci_set_next_interrupt(struct uhci_hcd *uhci)
{
	uhci->term_td->status |= cpu_to_le32(TD_CTRL_IOC); 
}
<<<

On my PIII BX440 laptop, I can safely run usx2y with this function converted 
to empty:

>>>
static inline void uhci_set_next_interrupt(struct uhci_hcd *uhci)
{
}
<<<

this leads to the interruptrate in usx2y idle mode being halved from 250/s to 
125/s.

Please check out if it helps on your laptop. cautiously, things might 
crash ;-) though definitely here its ok.

thanks,
Karsten


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
