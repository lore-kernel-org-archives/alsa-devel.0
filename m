From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: tascam us-122 : invalid synch pipe
Date: Mon, 27 Oct 2003 23:34:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310272334.51538.annabellesgarden@yahoo.de>
References: <200309251806.20116.ws@seh.de> <s5hd6ci7w4l.wl@alsa2.suse.de> <20031027214310.GA826@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031027214310.GA826@tuba.home>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>, Takashi Iwai <tiwai@suse.de>
Cc: Werner Schweer <ws@seh.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Montag, 27. Oktober 2003 22:43 schrieb Martin Langer:
> On Mon, Oct 27, 2003 at 12:33:46PM +0100, Takashi Iwai wrote:
> > At Tue, 21 Oct 2003 23:52:55 +0200,
> >
> > Martin Langer wrote:
> > > ... at http://www.langerland.de/us122/driver.html
> >
> > any chance to merge us122 driver with us428 driver?
> > they look quite similar...
>
> Yes, a common tascam driver should be possible .... somehow.
>
> It's my goal to merge them together. But maybe someone else is more
> interested in this job than I. Karsten? Or any other volunteer?
>
>
> bye,
> martin
I'll check the merge on the us428, but prefer to actually code still missing 
features like spdif, 24bit and MIDI-Client for the us428's lights.
If somebody is willing to code the merge, would you, Takashi, setup a seperate 
cvs subdir alsa-driver/usb/usx2y for it? If the merge is finished, we could 
then discard usb/us428.
And... Is it possible for the merger (and the checker ;-) to have 
non-anonymous cvs-access (== shorter turn around times)?
I mean, just complete read-access + write-acces to alsa-driver/usb/usx2y only 
would be fine.

regards,
Karsten



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
