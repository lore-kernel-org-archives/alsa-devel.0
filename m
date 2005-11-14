From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: Multi ice1712 .asoundrc problem
Date: Mon, 14 Nov 2005 17:55:13 +0200
Message-ID: <20051114155513.GO10146@edu.joroinen.fi>
References: <E1EbIYV-00019A-4u@localhost.localdomain> <20051113223105.GA4822@localhost.localdomain> <1131923292.27215.1.camel@mindpipe> <20051114003718.GA5041@localhost.localdomain> <1131960635.27215.16.camel@mindpipe> <20051114121701.GA4044@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051114121701.GA4044@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Rigg <ad@sound-man.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 14, 2005 at 12:17:01PM +0000, John Rigg wrote:
> On Mon, Nov 14, 2005 at 04:30:34AM -0500, Lee Revell wrote:
> > On Mon, 2005-11-14 at 00:37 +0000, John Rigg wrote:
> > > Is there another way, eg. a way to start multi_playback and
> > > multi_capture devices with a single jackd command?
> >=20
> > Yes, for example:
> >=20
> > jackd -d alsa -C hw:0,2 -P hw:0,3
>=20
> I tried the following:
>=20
> jackd -d alsa -C multi_capture -P multi_playback -p 128
>=20
> This gives the same poll time out. I tried different values of -p
> but it just changes the length of the time out.
>

I was reading jackd alsa-driver source, and found out, that the "poll tim=
e
out" messages come from poll() system call while jackd is waiting for dat=
a
from alsa.. so the problem is most propably in alsa.. multi plugin?
=20
- Pasi K=E4rkk=E4inen

> Starting capture-only using the following works:
> jackd -d alsa -C multi_capture -p 128
> Likewise for playback:
> jackd -d alsa -C multi_playback -p 128
>=20
> John
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. Dow=
nload
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
