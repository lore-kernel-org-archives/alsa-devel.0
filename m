From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]snd-usb-usx2y 0.8.1 against alsa-kernel cvshead: OHCI doesn't crash anymore
Date: Wed, 20 Oct 2004 02:28:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410200228.16228.annabellesgarden@yahoo.de>
References: <200409302046.29798.annabellesgarden@yahoo.de> <200410181406.43903.annabellesgarden@yahoo.de> <s5hlle2j0hz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlle2j0hz.wl@alsa2.suse.de>
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

Am Dienstag 19 Oktober 2004 15:33 schrieb Takashi Iwai:
>
> I'm afraid it's still racy.
> In usX2Y_urbs_start(), the complete callback may be called between
> usb_submit_urb() and the loop of schedule_timeout().
> So, the loop should check at first the condition before sleeping like
> below:
>
> 	while (atomic_read(&subs->state) != state_PREPARED) {
> 		timeout = schedule_timeout(timeout);
> 		if (signal_pending(current))
> 			...
> 		if (! timeout)
> 			...
> 	}
>
<click, beep, ring> ok, thanks!
But there is still a small race window between 
	while (atomic_read(&subs->state) != state_PREPARED) {
and   /* right here  the complete callback may be called */
		timeout = schedule_timeout(timeout);
no?
Is there a trick to avoid even this small race window?
>
> Regarding the new config stuff:
> Let's kill CONFIG_SND_USB_USX2Y_NRPACKS_VARIABLE option.
> No one will want to disable such a module option.
>
Well, me wants to disable it as it works best with nrpacks=1 here and I'd like 
the machine code to not contain the unneeded loops then...
(gcc optimizes those loops away if it reads "#define nrpacks 1")
Can I keep some (commented out?) define switch inside the source (invisible to 
KConfig) to suit my needs?

> Also, please avoid the Kconfig int value as much as possible if you
> want to support the driver for 2.2/2.4 kernels, too.  I believe it's
> ok to put a hardcoded value 4 like usbaudio.c if you describe the
> module option properly in the document.
>
Erm, which document?
And I'm not too keen to do the driver (sup/back)port for 2.2/2.4 kernels 
myself. I'll avoid the Kconfig int value, making it simpler for volunteers.

Karsten


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
