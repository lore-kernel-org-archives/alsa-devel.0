From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: capture buffers on SBLIVE...
Date: Sun, 30 Jun 2002 11:05:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1EC9DA.BE535918@folkwang-hochschule.de>
References: <Pine.LNX.4.44.0206291658100.22066-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Fernando Pablo Lopez-Lezcano wrote:
> =

> > i'm tracking down a nasty problem i have with jack. is there any way =
to
> > increase the periods-per-hardware-buffer setting on an sblive for
> > capture ? jackd refuses to do that, and i wonder whether it's a hardw=
are
> > limitation.
> =

> Has to be, apparently the playback and record channels of the sblive ar=
e
> not symetric. For recording you can only use two periods and that's it
> (but for playback you can use more). I assume the alsa driver reflects =
the
> underlying hardware as usual.

ok. i need to know this just for comparison. if i can be sure that no
application can get more than 2 periods on capture, i can compare jack
and non-jack apps under equal circumstances...  =


thanks,

j=F6rn


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
