From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: usbus428 0.0.7 patch against release alsa-driver 0.9.6 (was Re: tascam gives a go for us428 @ alsa ...)
Date: Wed, 20 Aug 2003 20:29:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308202029.12896.annabellesgarden@yahoo.de>
References: <200304301356.34023.annabellesgarden@yahoo.de> <s5h3cgdle87.wl@alsa2.suse.de> <20030820175811.GA876@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030820175811.GA876@tuba.home>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net, us428@drehmoment.org
List-Id: alsa-devel@alsa-project.org

Am Mittwoch 20 August 2003 19:58 schrieb Martin Langer:
> On Thu, Aug 07, 2003 at 04:44:08PM +0200, Takashi Iwai wrote:
> > At Wed, 30 Jul 2003 21:33:37 +0200,
> >
> > Karsten Wiese wrote:
> > > i agree that its a reasonable goal to integrate the us428 audio part
> > > into ALSA usb-audio. is there such a mechanism to syncronize the
> > > playback-pipe by the capture-pipe allrteady in usb-audio.c? the us428
> > > definitly needs such a beast.
> >
> > i'm not sure what you mean here, but i guess it's not implemented.
> > (is it a standard USB audio feature? if not, we don't have it :)
>
> Stupid question: Why do we need synchronisation??
to avoid crackles in Audio Out. goal: feeding Audio Out exactly as many frames 
as it can digest.
>
> Isn't it the job of the FPGA? We know that each signal is routed across the
> FPGA and that's why the config data should be loaded into for standalone
> usage or nothing will work on our USxxx. Without an internal
> synchronisation there would be no standalone usage possible or do I make a
> mistake here.
What do you mean with standalone usage?
>
> What about removing synchronisation stuff and replacing it with some
> talking to the FPGA buffer??? I guess that will not fit into USB AUDIO
> class, but anyhow my USxxx is vendor specififc.
how would you do that? You have the 122s circuit diagram?
What I know so far is: there are no crackles in audio anymore if we feed 
"Audio Out" at exactly the frame-rate we have received from "Audio In" just 
before.
this is what I mean by synchronisation. 
would you try the us428 audio part on the us122? I could send you a special 
version for 2 Audio Ins & 2 Audio Outs. We could then build a snd-usb-usx2x 
module ;-) None the less you'd first have to extract the second stage 
firmware. have you already?

karsten






-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
