From: Martin Langer <martin-langer@gmx.de>
Subject: Re: usbus428 0.0.7 patch against release alsa-driver 0.9.6 (was Re: tascam gives a go for us428 @ alsa ...)
Date: Sat, 23 Aug 2003 02:34:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030823003455.GB16228@tuba.home>
References: <200304301356.34023.annabellesgarden@yahoo.de> <s5h3cgdle87.wl@alsa2.suse.de> <20030820175811.GA876@tuba.home> <200308202029.12896.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200308202029.12896.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net, us428@drehmoment.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 20, 2003 at 08:29:12PM +0200, Karsten Wiese wrote:
> Am Mittwoch 20 August 2003 19:58 schrieb Martin Langer:
> >
> > Stupid question: Why do we need synchronisation??
> to avoid crackles in Audio Out. goal: feeding Audio Out exactly as many frames 
> as it can digest.

I see.

> > Isn't it the job of the FPGA? We know that each signal is routed across the
> > FPGA and that's why the config data should be loaded into for standalone
> > usage or nothing will work on our USxxx. Without an internal
> > synchronisation there would be no standalone usage possible or do I make a
> > mistake here.
> What do you mean with standalone usage?

I can use my us122 in a direct mode. There I can receive the audio signal
from Audio-In on the Audio-Out jacks. But I have to load both firmwares and
some USB power is neccessary. And without firmware there is no signal on
Audio Out.

> You have the 122s circuit diagram?

No, I don't have a circuit diagram. But lots of fantasy;-)

> What I know so far is: there are no crackles in audio anymore if we feed 
> "Audio Out" at exactly the frame-rate we have received from "Audio In" just 
> before.
> this is what I mean by synchronisation. 

Thanks for explaining it. Now I know what you mean here.

> would you try the us428 audio part on the us122? I could send you a special 
> version for 2 Audio Ins & 2 Audio Outs. We could then build a snd-usb-usx2x 
> module ;-) None the less you'd first have to extract the second stage 
> firmware. have you already?

Yes, we should try out this possibility of a common snd-usb-usx2x! 

Sorry, Tascam FPGA firmware loader development is still not finished: 
More (cvs/mail) on http://sourceforge.net/projects/usb-midi-fw/


martin


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
