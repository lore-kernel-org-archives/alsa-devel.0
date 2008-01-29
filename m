From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: DSP2000 Midi In - Not a correct fix??
Date: Tue, 29 Jan 2008 23:22:29 +0000
Message-ID: <200801292322.29394.gineera@aspect135.co.uk>
References: <200801291029.59425.gineera@aspect135.co.uk>
	<Pine.LNX.4.61.0801291202130.11819@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FBD72442C
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 00:03:03 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0801291202130.11819@tm8103.perex-int.cz>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tuesday 29 January 2008 11:09, Jaroslav Kysela wrote:
> On Tue, 29 Jan 2008, Alan Horstmann wrote:
> >
> > re: Hoontech DSP2000 Midi In non-functional
> >
> >    see :  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=55
> >              https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1161
> >              https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1846
> >
> > From my testing, it seems the only part necessary is:-
> >
> > 	-       for (box = 0; box < 4; box++) {
> > 	+       for (box = 0; box < 1; box++) {
> >
> > as it is successful without the rest.
> >
> > However I feel this is not really a correct fix, preventing use of
> > multiple boxes in code that originally allowed it.  
>
> Do you have configuration with mutiple boxes? If yes, we can continue to
> work on a proper fix. Othewise, I would just keep a working configuration
> for single box only.

I can understand your sentiment and it is true I have only a single box (which 
can be set to any of box[0] to [3]), but it seems a regression to prevent 
correct configuring of audio on multiple boxes (which has worked fine in the 
past) just because of a problem in the Midi part.  The next better step than 
the patch on 1.0.16rc1 is to only allow midi config on box[0] with
	 if (box == 0)
in front of
	 snd_ice1712_stdsp24_box_midi(..)

However, things have moved on here, in that I do now have a proposed 
alternative.  One step on from the above approach is to call this function 
only if 
	ICE1712_STDSP24_BOX_MIDI1
is set for that particular box, rather than setting the parameter 'activate'.  
This approach does create a complete and effective solution, which I have 
tested here, being able (using the boxconfigs) to set channels and Midi In on 
any box designated 0-3, and Midi out 1 & 2 are active for all boxes once set 
on any.

Soon I will put this together into a patch for review, so that there is at 
least something definite to discuss.

And
On Tuesday 29 January 2008 11:25, Clemens Ladisch wrote:
> Alan Horstmann wrote:
> > Clemens, can you remember anything about this change:
> >
> > 	http://hg.alsa-project.org/alsa-kernel/rev/a42043505e46
> >
> > -was it someone else's patch or did you work on this?
>
> That change is based on the Windows driver source code (which I no
> longer have) and some guesswork; I never had the hardware.

Thanks Clemens, that is useful to know.

Alan
