From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]snd-usb-usx2y 0.8.1 against alsa-kernel cvshead: OHCI doesn't crash anymore
Date: Thu, 21 Oct 2004 20:21:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410212021.22349.annabellesgarden@yahoo.de>
References: <200409302046.29798.annabellesgarden@yahoo.de> <200410200228.16228.annabellesgarden@yahoo.de> <s5hacuhivfb.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_h4/dB71hGB6YnOq"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacuhivfb.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Rui Nuno Capela <rncbc@rncbc.org>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_h4/dB71hGB6YnOq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Mittwoch 20 Oktober 2004 11:35 schrieb Takashi Iwai:
> At Wed, 20 Oct 2004 02:28:15 +0200,
>
> Karsten Wiese wrote:
> > Am Dienstag 19 Oktober 2004 15:33 schrieb Takashi Iwai:
> > > I'm afraid it's still racy.
> > > In usX2Y_urbs_start(), the complete callback may be called between
> > > usb_submit_urb() and the loop of schedule_timeout().
> > > So, the loop should check at first the condition before sleeping like
> > > below:
> > >
> > > 	while (atomic_read(&subs->state) != state_PREPARED) {
> > > 		timeout = schedule_timeout(timeout);
> > > 		if (signal_pending(current))
> > > 			...
> > > 		if (! timeout)
> > > 			...
> > > 	}
> >
> > <click, beep, ring> ok, thanks!
> > But there is still a small race window between
> > 	while (atomic_read(&subs->state) != state_PREPARED) {
> > and   /* right here  the complete callback may be called */
> > 		timeout = schedule_timeout(timeout);
> > no?
>
> Oh yes, sure.
>
> > Is there a trick to avoid even this small race window?
>
> As I wrote before, use spinlock around it or completion.
> The latter might be easier although it's UNINTERRUPTIBLE only.
>
I used the wait_event macro in this version. Its also used in snd_card_free(), 
so I hope stuff is not too hard to port to 2.4 and 2.2 kernels.

> > > Regarding the new config stuff:
> > > Let's kill CONFIG_SND_USB_USX2Y_NRPACKS_VARIABLE option.
> > > No one will want to disable such a module option.
> >
> > Well, me wants to disable it as it works best with nrpacks=1 here and I'd
> > like the machine code to not contain the unneeded loops then...
> > (gcc optimizes those loops away if it reads "#define nrpacks 1")
> > Can I keep some (commented out?) define switch inside the source
> > (invisible to KConfig) to suit my needs?
>
> Then it's ok.  Having a new stuff in Kconfig would make it difficult
> to build for older systems.
>
> > > Also, please avoid the Kconfig int value as much as possible if you
> > > want to support the driver for 2.2/2.4 kernels, too.  I believe it's
> > > ok to put a hardcoded value 4 like usbaudio.c if you describe the
> > > module option properly in the document.
> >
> > Erm, which document?
>
> Create a new one for your driver ;)
>
> > And I'm not too keen to do the driver (sup/back)port for 2.2/2.4 kernels
> > myself. I'll avoid the Kconfig int value, making it simpler for
> > volunteers.
>
> Ok, thanks.
>
version 0.8.5 patch is attached.

thanks,
Karsten

patch header:
>>>>
Summary: Fixes crashes that occured when communicating over ohci usb-hcds.

Work on this started, when rumors spread that ohci equipped machines would 
crash.
This was due to me missing two facts:
1) Ohci has a bigger usb frame number wrap around.
2) It only supports URB_ISO_ASAP when submitting iso urbs.
Fixed now.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
<<<<


--Boundary-00=_h4/dB71hGB6YnOq
Content-Type: application/x-bzip2;
  name="snd-usb-usx2y.patch.0.8.5.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.8.5.bz2"

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

--Boundary-00=_h4/dB71hGB6YnOq--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
