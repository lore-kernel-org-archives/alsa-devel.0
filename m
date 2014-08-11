From: Mark Brown <broonie@kernel.org>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Mon, 11 Aug 2014 18:11:33 +0100
Message-ID: <20140811171133.GG17528@sirena.org.uk>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <20140811153342.GE17528@sirena.org.uk>
 <CAKON4OyxjSL4ziaJGdGXhVXGVoL9M4qq9qdtYYuGz_hnCA3muA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8216254006847977909=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F2FBD26089A
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 19:11:51 +0200 (CEST)
In-Reply-To: <CAKON4OyxjSL4ziaJGdGXhVXGVoL9M4qq9qdtYYuGz_hnCA3muA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============8216254006847977909==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Lpe8XikNwCJTC+X"
Content-Disposition: inline


--5Lpe8XikNwCJTC+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2014 at 12:09:43PM -0400, jonsmirl@gmail.com wrote:
> On Mon, Aug 11, 2014 at 11:33 AM, Mark Brown <broonie@kernel.org> wrote:

> > No, the machine driver runs first so it can do any coordination needed
> > between the other devices.  Attempting to fiddle about with the ordering
> > is never going to be robust, someone else will always want a different
> > ordering at some point.

> I don't see how to fix this without making a machine driver that
> simply tells the cpu-dai to change the MCLK output from 22.5Mhz to
> 24.5Mhz earlier in the hw_params chain. But that's putting a generic
> piece of code into the machine driver.

That's absolutely fine, the clocking arrangements and sequencing
requirements for achieving it are in general going to depend on the
machine.  The machine may have requirements which mean that it doesn't
want to use a clock configuration it's physically possible for it to
generate, or it may want to do more extensive reparenting depending on
use case.

For things like this it is generally good practice for the machine
driver to disable all clocks (set their rates to zero) when disabling if
it wants to support reconfiguration.

> Shouldn't codec always be the last in the chain? What would be a case
> where you don't want it at the end of the chain?

How are you deciding what the ordering for "the chain" should be in the
first place?  It seems like you're just assuming that it's what you want
to set for your system which in turn appears to be derived from what
you're using as clock master, it's very common for the CODEC to be the
clock master in a system.

One could equally argue here that the master shouldn't allow itself to
have the clock rate reprogrammed when it has something deriving a clock
=66rom it (after all if that thing is running it might be disrupted).

--5Lpe8XikNwCJTC+X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6PlCAAoJELSic+t+oim93nUQAI2D1TfQSlsPi08QLZmHA0u1
4j+6um/JxrwLYGmpGijd+aJECn/VTStAM+/OkdOPnS41FJ1ENoMLsDH4dknkML00
Laoz8LT/DURUfZLhzJKy7Diln5euDpR7nA1hlqUChlUYMYCx72oggBvMAYy/mo6F
dxEOjGVOqwEq7A4WPB1DCjA0whWN4HH/0flCggJO320e/spGltogg31SmInHTI3F
DHI+cScIBf+uSenagZ00AJ5zXa4yg+KZ22fpLj10qtoOr3qcT9peBDNpR/nbdxH2
42+jwKdErV8fKcSpvNR7XN25/pN0VbTZIeud/cvJaDmaB2ZoGGyNtzrM/PFMetQA
YkAiE+rliDc5V4spq8ebhbBFb6nHNe5C/AYLVdWpvSxXpLCviYt0C9BG4VqAU6Z5
vl1sh7cK4t1CpP0ZmbweNpqJsmMFJklt8rEeinc1qILUIw+CIZ2uMNY2lPcbbEtK
lK4a+L5jKO/+rc/yTTHHIFfFJIS8xR4zltXttaDWBmez39i691wARwf03ccb2AcI
dd9KTctH1vlBwgVBC/SUtvxz4ynsYR7hgjTzQU45NtNYS+TZk233/z2KDQDNoEg1
x13PJdaM75JH+F5g8gAvay5LjBooMGM3dtkQmyLgEq+0uVsO0oBRbab8XVCHB3G0
qn/qj0rvmBcfNwtBAi93
=tl64
-----END PGP SIGNATURE-----

--5Lpe8XikNwCJTC+X--

--===============8216254006847977909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8216254006847977909==--
