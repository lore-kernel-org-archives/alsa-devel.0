From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: Error: firmware not found
Date: Tue, 25 Jan 2005 14:19:39 +0100
Message-ID: <m2acqxabo4.fsf@vador.mandrakesoft.com>
References: <XFMail.20050125093227.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20050125093227.pochini@shiny.it> (Giuliano Pochini's
 message of "Tue, 25 Jan 2005 09:32:27 +0100 (CET)")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini <pochini@shiny.it> writes:

> > > This is not good because some cards (in my case the Layla3G and
> > > the Gina3G) have the same PCI card, but different external
> > > module.
> > 
> > you mean that you've one of this card and that hotplug loads the
> > wrong module ?
> 
> Yes.
> 
> > if yes, this is a driver bug indeed.
> 
> No, it isn't, because those devices use the same PCI card, that is
> the kernel reports the same PCI ID/subID's. The driver has to load
> the firmware and then it asks the DSP what (if any) external box is
> attached. If it is the wrong driver it exits with -ENODEV.

:-(

are these cards rare or not?

b/c this is a big issue for hw auto configuring (eg as we do in
mandrakelinux).

would it be possible to create a snd-echoaudio frontend driver that
would try sub-drivers (gina*, layla*, ...) which would load the
firmware & ask DSP ?

this what they do for some dvb cards.

this would save distro :-)



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
