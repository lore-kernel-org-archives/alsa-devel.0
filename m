From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: mixer device
Date: Thu, 13 May 2004 17:34:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040513153457.GE6913@sunrise.pg.gda.pl>
References: <1084218706.31496.72.camel@shrek.bitfreak.net> <Pine.HPX.4.33n.0405121735410.26780-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0405121735410.26780-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, May 12, 2004 at 05:40:55PM +0200, Clemens Ladisch wrote:
> Ronald S. Bultje wrote:
> > for a given alsa device ("default", "dmix", "plughw:N", "hw:N,M",
> > "dspN", etc.), how do I automatically obtain the right device to use as
> > a audio mixer with that device?
> 
> Depends on your definition of "right device".  In the general case
> this isn't possible because many cards don't have any mixer controls,
> or don't have the controls you want to use.  Or the pcm device uses
> several cards, or none.
> 
> What do you want to do with the mixer?
Hmm - typically people just want to control PCM volume.
When using OSS you can just do mixer ioctl's on the opened PCM fd.
Simple and clear. With many virtual PCM streams it is working
too (non-free version).
If we haven't hardware volume control this function is emulated.
It is not working with ALSA OSS emulation nor aoss.
So how a program could in a simple way obtain information which control to
use to set the volume level of particular stream?

ALSA is complicated and we have no good manual describing proper use
of its api. You can easily prove this: many programs have ALSA output
modules but they are working worse then when using OSS.
For example mplayer with OSS synchronizes video and sound much faster
in case of network streaming. XMMS is broken too.
In ALSA you could play/record samples in many ways: just read/write,
callbacks, poll, memory mapping. Not all ways are good working.
Some are working poorly in some conditions. So maybe we should have
simpler API but working good enough. My opinion is that lib can be
written no so clearly but API shuld be as clean and easy to use
as possible. It should be constructed from user point of view.
How easy is to use it and which functionality it gives us.

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
