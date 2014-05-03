From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mc13783: Add devicetree support
Date: Fri, 2 May 2014 18:49:34 -0700
Message-ID: <20140503014934.GB22111@sirena.org.uk>
References: <1398495423-2223-1-git-send-email-shc_work@mail.ru>
 <20140429222522.GS15125@sirena.org.uk>
 <20140430140849.GR29462@lee--X1>
 <1398867073.695596467@f224.i.mail.ru>
 <20140430141708.GS29462@lee--X1>
 <20140430180653.GB3245@sirena.org.uk>
 <20140501074253.GA32761@lee--X1>
 <20140501150653.GZ3245@sirena.org.uk>
 <20140502080944.GA5206@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6278849073951485969=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98453260799
 for <alsa-devel@alsa-project.org>; Sat,  3 May 2014 03:49:58 +0200 (CEST)
In-Reply-To: <20140502080944.GA5206@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Alexander Shiyan <shc_work@mail.ru>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6278849073951485969==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2014 at 09:09:44AM +0100, Lee Jones wrote:
> On Thu, 01 May 2014, Mark Brown wrote:

> > Sure, but I didn't see an urgent need for that immediately so I just
> > went ahead - the ack usually means that it's OK to apply.

> Hmm... I'm inclined to disagree.  The Ack is a marker that I'm okay
> with the changes, but the note after makes it pretty clear that the
> preference would be for the patch to be handled via an IB.

Right, and it's sitting on a separate branch which is (as we've seen)
very easy to add a tag to if it turns out to be needed.  This is what
all the small topic branches are there for, it makes it really easy to
cross merge, and obviously applying the patch on a branch is always
going to be the first step in creating an immutable branch.  It
certainly doesn't seem worth getting worried about.

Really, if you're not happy for something to be applied you probably
don't want to be acking it or you at least want to be really explicit
about things.

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZEslAAoJELSic+t+oim9qNgP/1eYWmEaAgSa5iAWAye0EJvN
MX2wFTUf4ciqdDWP1dbYArGqYChHIo3mFj/Oz7JLK9nspsC7x6orxgPIyzy4tU7g
zhqMgcri/dzpTBfV0DPV7T7dRAZD0DuXsTP0oggqYRoqep+IKKG2PjZMBz5+d0ry
m2AR2ZIQsR/AO6ZmYkKVra47dPBpxkH4XJgoQqurbQLzbx34J9Fh0sFJP7rCd1xJ
PlOVGHXODtnTiUSlnqY+A+JR8+PyZ5mgcF6GZrG4O3HKowTYFYwwsly1c9XdSJtw
OR8vZ6ykoKlNi1BmgvY+UOqZsV6dC9dpS+EksL5o7JcgCSssfNw+33UYULztdHK7
OufBs3AfLXbcpbesrzQJDT4vLDPjp0YgQ8VWCz84jS4ys0Flc8px8v5ut2RzvHsU
4o6ZkbSO/LeIbvku1H97XKMKEiLCrpqgdEbnCQm0jGzSctSYVNk7eksPpRow8ol6
zjYtNZVAM6IK8vxtni7IEz8PnkUHoLpe77eXZzOQQnrhGBspJwphBEpqpMTIsUDQ
suCCAUI9UutPehBFE+VLKQkXXI2NhIGi2RoFcYBOPux3q0bhCdHlioP8mjWTeDJ6
bxIJlT+nQmMNYiPIL7p7/n1G3cG1aU4pwecE0rIY+IT5fGVjrE5vget82X3HP6OV
EkV2ALXlZnv4v63VrmZM
=jjkq
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--

--===============6278849073951485969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6278849073951485969==--
