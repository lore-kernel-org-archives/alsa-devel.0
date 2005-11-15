From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Multi ice1712 .asoundrc problem
Date: Tue, 15 Nov 2005 15:16:52 +0000
Message-ID: <20051115151652.GA4404@localhost.localdomain>
References: <E1EbIYV-00019A-4u@localhost.localdomain> <20051113223105.GA4822@localhost.localdomain> <1131923292.27215.1.camel@mindpipe> <20051114003718.GA5041@localhost.localdomain> <1131960635.27215.16.camel@mindpipe> <20051114121701.GA4044@localhost.localdomain> <20051114155513.GO10146@edu.joroinen.fi> <20051114190647.GA4797@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051114190647.GA4797@localhost.localdomain>
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

On Mon, Nov 14, 2005 at 07:06:47PM +0000, John Rigg wrote:
> On Mon, Nov 14, 2005 at 05:55:13PM +0200, Pasi K=E4rkk=E4inen wrote:
> > I was reading jackd alsa-driver source, and found out, that the "poll=
 time
> > out" messages come from poll() system call while jackd is waiting for=
 data
> > from alsa.. so the problem is most propably in alsa.. multi plugin?
>=20
> A reasonable assumption.

On second thoughts I think it's driver related. It appears to be impossib=
le to=20
set the channel count. eg.:

jackd -d alsa -d -C -i8 hw:0

results in the following message:
ALSA: cannot set channel count to 8 for capture
(the code that generates this message is in drivers/alsa/alsa_driver.c)

The docs say that channel count can be set to anything up to maximum
(which is default). They also say that the number of slaves channels in
multi definition can be set to any number up to maximum.
We should be able to define one multi device with say 10 slaves channels
per card, and one set of bindings, and have it work in duplex mode.

What we actually have is a slaves channel count which can only be set to =
the
maximum, ie. 12 for capture or 10 for playback.
The multi plugin requires the number of slaves channels to be explicitly
defined, but doesn't allow separate definition for capture and playback
(unlike jackd, eg. `jackd -d alsa -d -C -i12 -P -o10 hw:0').

John




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
