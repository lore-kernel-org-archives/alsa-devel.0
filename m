From: Werner Schweer <ws@seh.de>
Subject: Re: [ALSA - driver 0000425]: usb-usx2y: System lockup on PCM device open (OHCI)
Date: Sun, 10 Oct 2004 23:28:54 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410102328.54798.ws@seh.de>
References: <20041010133726.CBA7A2801D@server.perex-int.cz> <200410101939.00958.ws@seh.de> <200410102024.49380.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200410102024.49380.annabellesgarden@yahoo.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Karsten Wiese <annabellesgarden@yahoo.de>
List-Id: alsa-devel@alsa-project.org

On Sunday 10 October 2004 18:24, Karsten Wiese wrote:
> Am Sonntag 10 Oktober 2004 21:39 schrieb Werner Schweer:
> > On Sunday 10 October 2004 13:37, bugtrack@alsa-project.org wrote:
> > ...
> >
> > > ----------------------------------------------------------------------
> > >  karsten - 10-10-2004 15:37 CEST
> > > ----------------------------------------------------------------------
> > > This one makes a difference:
> > > usx2y_linux-2.6.9-rc3-mm3-VP-T3_041010.tar.gz After switching to my
> > > via-chipset-baset PC, I suddenly found myself in the club of the
> > > "sequence error" victims ;-)
> > > On that via system its ok now: no "sequence error" no more.
> > > also made two real crash bugs vanish.
> > > So please test this and forget the
> > > usx2y_linux-2.6.9-rc2-mm4-S7_041008.tar.gz.
> > > As before setup a 2.6.9xyz kernel, cp the tar's content into it and
> > > build everything inside the kernel.
> > > The rawusb version isn't yet done.
> >
> > where can i find usx2y_linux-2.6.9-rc3-mm3-VP-T3_041010.tar.gz ?
> > I also have this "sequence error" bug on my new notebook+us122 and want
> > to try out
> > this patch.
>
> https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000425

thanks!
with this patch i now get some sound out of my us122. But there are still 
sequence errors (and JACK stops). After about 5 minutes of play the system 
freezes. My system is a Pentium M notebook with intel ich4 chipset (UHCI usb 
driver).

/werner




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
