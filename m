From: Werner Schweer <ws@seh.de>
Subject: Re: [ALSA - driver 0000425]: usb-usx2y: System lockup on PCM device open (OHCI)
Date: Thu, 14 Oct 2004 21:17:22 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410142117.22498.ws@seh.de>
References: <20041010133726.CBA7A2801D@server.perex-int.cz> <200410110954.06107.ws@seh.de> <200410140159.14019.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200410140159.14019.annabellesgarden@yahoo.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 13 October 2004 23:59, Karsten Wiese wrote:
> Am Montag 11 Oktober 2004 11:54 schrieb Werner Schweer:
> > On Monday 11 October 2004 00:19, Karsten Wiese wrote:
> > > Am Montag 11 Oktober 2004 01:28 schrieb Werner Schweer:
> > > > thanks!
> > > > with this patch i now get some sound out of my us122. But there are
> > > > still sequence errors (and JACK stops). After about 5 minutes of play
> > > > the system freezes. My system is a Pentium M notebook with intel ich4
> > > > chipset (UHCI usb driver).
> > >
> > > with the built-in soundcard jack runs fine?
> > >
> > > Karsten
> >
> > yes, it does
> >
> > /werner
>
> Found a bugfix inside uhci-hcd.c (2.6.9-rc2-mm4) that is not needed anymore
>
> for modern chipsets:
> >>> line 122:
>
> static inline void uhci_set_next_interrupt(struct uhci_hcd *uhci)
> {
>  uhci->term_td->status |= cpu_to_le32(TD_CTRL_IOC);
> }
> <<<
>
> On my PIII BX440 laptop, I can safely run usx2y with this function
> converted to empty:
>
>
> static inline void uhci_set_next_interrupt(struct uhci_hcd *uhci)
> {
> }
> <<<                             
>
> this leads to the interruptrate in usx2y idle mode being halved from 250/s
> to 125/s.
>
> Please check out if it helps on your laptop. cautiously, things might
> crash ;-) though definitely here its ok.
>
> thanks,
> Karsten

applied this patch in addition to linux-2.6.9-usx2y-0.8.3c from rncbc
(for kernel 2.6.9-rc4-mm1-VP-T9n).

Jack stopps after a few seconds, system log says:
...
Oct 14 21:54:48 a6 vmunix: usx2yaudio.c:624:snd_usX2Y_pcm_trigger(START)
Oct 14 21:54:48 a6 vmunix: usx2yaudio.c:624:snd_usX2Y_pcm_trigger(START)
Oct 14 21:55:23 a6 vmunix: IRQ#8 thread started up.
Oct 14 21:55:40 a6 vmunix: Sequence Error!(hcd_frame=1194 
ep=10out;wait=168,frame=169).
Oct 14 21:55:40 a6 vmunix: Most propably some urb of usb-frame 168 is still 
missing.
Oct 14 21:55:40 a6 vmunix: Cause could be too long delays in usb-hcd interrupt 
handling.
Oct 14 21:55:40 a6 vmunix: This driver definitely wants 1 interrupt per ms.
Oct 14 21:55:40 a6 vmunix: To make it work for a system that can't deliver 
interrupts reliably at that rate,
Oct 14 21:55:40 a6 vmunix: You'd have to make it work for NRPACKS > 1. To 
start, grep for NRPACKS in this code ;-)
Oct 14 21:55:40 a6 vmunix: usx2yaudio.c:268:0 f07a91c0 state=8
Oct 14 21:55:40 a6 vmunix: usx2yaudio.c:268:1 f07a9180 state=8
Oct 14 21:55:40 a6 vmunix: usx2yaudio.c:281:0 status=0 start_frame=169
...
ok, maybe its not a good idea to thread the rtc and usb irq's. After switching
threading off ("echo 0 > /proc/irq/8/rtc/threaded" etc.) MusE+JACK is now
playing for > 1h without any glitch.

/werner




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
