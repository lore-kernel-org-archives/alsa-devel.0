From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Multi ice1712 .asoundrc problem
Date: Mon, 14 Nov 2005 19:06:47 +0000
Message-ID: <20051114190647.GA4797@localhost.localdomain>
References: <E1EbIYV-00019A-4u@localhost.localdomain> <20051113223105.GA4822@localhost.localdomain> <1131923292.27215.1.camel@mindpipe> <20051114003718.GA5041@localhost.localdomain> <1131960635.27215.16.camel@mindpipe> <20051114121701.GA4044@localhost.localdomain> <20051114155513.GO10146@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051114155513.GO10146@edu.joroinen.fi>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 14, 2005 at 05:55:13PM +0200, Pasi K=E4rkk=E4inen wrote:
> I was reading jackd alsa-driver source, and found out, that the "poll t=
ime
> out" messages come from poll() system call while jackd is waiting for d=
ata
> from alsa.. so the problem is most propably in alsa.. multi plugin?

A reasonable assumption. The symptoms are exactly the same whether or not=
 asym=20
plugin is used, so it's unlikely to be that, and the cards work individua=
lly=20
in duplex mode. All that's left is the multi plugin. Either it's being us=
ed
incorrectly or it doesn't allow what we're trying to do.

John


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Downl=
oad
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
