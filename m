From: Marek Peca <marek@tynska.cuni.cz>
Subject: Re: Audigy 2 ZS Notebook -- can not hear nor record analog in [was:
 does a sound capture (recording) work?]
Date: Thu, 9 Mar 2006 21:23:40 +0000 (   )
Message-ID: <Pine.LNX.4.10.10603092043480.12936-100000@tynska.cuni.cz>
References: <440ED05F.1000509@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <440ED05F.1000509@superbug.co.uk>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thank you for your information.

On Wed, 8 Mar 2006, James Courtier-Dutton wrote:
> > So, I'm asking, whether the analog sound capture work at this card --
> > can anyone here tell me? I'd really like to know this before buy.
> >
> The status is still "Untested".
> I was working towards getting the Audigy2 ZS notebook working, and got 
> as far as getting some output on my speakers and checked in that code to 
> the alsa tree. My Linux machines have been out of action since then due 
> to hardware failures as a result of a power surge. So, I never got round 
> to testing the sound capture.

I've just bought a card for the testing.

Playback of PCM works well, but, I cannot hear analog input, even
if setting numerous controls in mixer. The only thing I did not set,
is the control numid=32,iface=PCM,name='Captured FX8010
Outputs',device=2, set now to
  :
values=off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off,off
-- I'm not sure, if this can influence volume of analogue input in
resulting output sound.

Recording of current playback (PCM) works, but recording of analog
input does not.

I tried the card in M$Windows with the same source (sine generator)
and there the sound is audible after selecting in mixer without
problems.

Can you, please, give me any suggestions how to continue? Is it
possible to extract settings from the working card configuration in
M$Windows and to analyze them? Can you give me some pointers, whether
to try to alter ALSA sourcecode somewhere, or to try something
before?


/* Unfortunately, I'm in a big hurry with one project needing it
working -- double side analogue modulator using 2-channel soundcard
and it should work on notebook... Yesterday it was late :) */


Thank you very much.
Marek P.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
