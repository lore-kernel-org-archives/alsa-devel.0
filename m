From: Kevin Puetz <puetzk@iastate.edu>
Subject: Re: Re: Phase Reversal on Santa Cruz (cs46xx)
Date: Fri, 22 Nov 2002 09:35:55 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211220935.55174.puetzk@iastate.edu>
References: <200211170056.11190.puetzk@iastate.edu> <200211172241.14373.puetzk@iastate.edu> <3DDD75AC.9030408@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DDD75AC.9030408@cucumelo.org>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 21 November 2002 18:09, Benny Sjostrand wrote:
> Thanks, that explication makes sense.
>
> If it was that simple that Santa Cruz where the only card in the world with
> this problem, but there's the same problem is reported for other cs46xx
> based card's
> too.
>
> >well, how did it work before (0.9.0rc1 worked for sure, I guess I should
> > try to identify the specific version that developed this problem)? Were
> > we using the DSP to invert it previosly, did we lose some Santa Cruz
> > specific bittwiddling (the 'fix' consists of just negating all the levels
> > for one stereo channel). Any guesses?
>
> I would like know why the problem does not apear with rc1,  but the
> problem does not
> apear  forme with any release, so I cant reproduce the problem with my
> equipment, which
> dont make things easy ...

no, that would be annoying indeed :-)

> The main diference between the old DSP code and the new is that the old DSP
> is based on a static parameter setup. The new DSP code is  a attempt to
> manage
> tasks and resources in the DSP dynamically.
>
> I dont find any reason to why the DSP would invert one of the channels,
> in theory
> the parameter setup made when playing one PCM channel is the same as it is
> in the old DSP code static loaded (discarding unknown bugs)
>
> Finally, the "volume" could be possible, speculating: if the output sample
> is the product of volume * sample, and the volume is negative the sample
> would
> be negated. The "volume" in a DSP SCB for each channel is 16 bit value
> where 0x8000 is the maximum volume and 0xffff is cero, and lower then
> 0x8000 dont know. This part now actually differs a little bit from the old
> static DSP setup.
> Have you tested my latest patch ??

no, I haven't, since the patch is quite mangled in the www archive and I 
wasn't subscribed then, I didn't go through th trouble of fixing it up. Is it 
merged into cvs now, and if not, could you send it my way? I'd be happy to 
give it a shot.

> >Just as another question, do anyone know if it's possible to use the
> > internal SPDIF connector to feed CD audio into the card instead of the
> > analog input? I can't find anything in the mixer that seems to recieve
> > that input.
>
> The cs4630 chip got only one SDPIF input interface, you should see it
> the mixer with
> the new DSP code. And if that interface is wired to the internal SPDIF
> conector without
> any GPIO story it should just work (however the sounds gets
> distorcionated (out-of-sync)
> sometimes with the SPDIF input) ...

Hmm, OK. Guess I'll reboot to windows and see if that connection even works 
there :-P Maybe I just screwed it up.

> /Benny

oh, for anybody using this
 http://ophelia.student.iastate.edu/~puetzk/arts_phaseinvert-0.7.tgz

fixing yet another silly glitch Weijia found. (This is an aRts effect filter 
which introduces a phase inversion between the channels on purpose, which 
either fixes or introduces the problem, depending on whether you had it 
already).


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
