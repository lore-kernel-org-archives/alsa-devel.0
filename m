From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: HDA/ALC260: dealing with DC offset during record
Date: Thu, 22 Sep 2005 16:25:53 +0930 (CST)
Message-ID: <200509220655.j8M6trQ0016158@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi all

I have observed a significant (-40 dB) DC offset when recording using a
laptop equipped with an ALC260 codec.  Note that this is a straight DC
offset which in my case results in a (near) constant value of around 0x0f0 /
0x102 on left/right channels when the input to the ADC has been muted - it
is not noise.  Similar DC offsets have been observed with other codecs. 
>From information I've seen on the net and tests I've done on two laptops,
it's clear that this offset is coming from an opamp inside the codec and
isn't due to an error (or chip misprogramming) in the ALSA driver as
it stands.

It appears that the drivers for other operating systems incorporate logic to
detect and anull such offsets so the resultant recording has close to zero
DC offset.  I would like to implement something similar for the ALC260.  My
question: what place within ALSA would be deemed acceptable by the
developers?

My initial thought is to have a DC level detection carried out as part of
the card initialisation sequence.  My observations suggest that while the
actual value differs from chip to chip, it remains fairly consistant for a
given chip.  This offset could then be applied to all incoming data.

There are issues with this which I still need to solve - for example, the
correction factor changes (in a predictable away) when the capture mixer
setting; a change to this control would mean the correction factor would
need to be recalculated.  The effect of different bit depths needs to be
dealt with (although I'm not sure whether the ALC260 HDA driver currently
supports depths different from 16 bits).

Therefore, before coding anything I have a question: would something like
this be acceptable in the ALSA driver itself (possibly activated with a
module parameter)?  The only other place I can see would be alsa-lib, but it
may be difficult to do there in a seemless, transparent way.

Thoughts/suggestions welcome.

Regards
  jonathan


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
