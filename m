From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Alsa and dmix
Date: Fri, 4 Jun 2004 13:17:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040604111724.GD11182@sunrise.pg.gda.pl>
References: <200406012111.i51LBcv5018979@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200406012111.i51LBcv5018979@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matthias Sauppe <matthias.sauppe@gmx.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 01, 2004 at 11:04:18PM +0200, Matthias Sauppe wrote:
> I tried various configurations of alsa, but couldn't run both xmms and
> Quake. Could you please give me a hint how you managed that? I didn't
> find any useful information with Google :/
I must generate patch for latest ALSA CVS sources but I have no time for
it now.
But meantime you can download my version of aoss-lib which seems
to work with ALSA-1.0.5 too:

 http://www.pg.gda.pl/~atlka/_O_/alsa-20040302-aoss.tgz

Try: configure; make; make install 

I tested it with quake1, quake2, quake3, bzflag, JavaSoundDemo, mozilla,
xmms, mpg123 and it seems to work.
Of course it is not perfect and has bugs for sure.

For example ShogoDemo disables sound after playing part of
starting song. If I start it with ALSA_OSS_DEBUG I get SDL sound timeout
error:
write(7, 0x80c8660, 16384) -> 16384Orig enter SELECT nfds: 8, timeout: 10.000000wfds: 00000001
Changed enter SELECT nfds: 9, timeout: 10.000000
rfds: 000000001
wfds: 000000000
Changed exit SELECT nfds: 9, timeout: 10.000000
rfds: 000000001
wfds: 000000000
Orig exit SELECT nfds: 8, timeout: 10.000000
wfds: 00000000
SDL: Audio timeout - buggy audio driver? (disabled)

CHANGES: OSS buffer size is fixed - if you take a look at OSS doc you
should notice that an app could get buffer size and num of fragments
before setting dsp params and after that operation they cannot change.
ALSA can change its buffer size while we change sound format or speed
so it is not compatible with OSS behaviour in this case.
OSS mixer calls on opened dsp stream are not emulated so far because
of problem with determining proper mixer element. Also in dmix case
we have no virtual mixer.

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
