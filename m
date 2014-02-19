From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Make sure we only build SST
	drivers on X86
Date: Thu, 20 Feb 2014 01:02:57 +0900
Message-ID: <20140219160257.GL2669@sirena.org.uk>
References: <1392818784-6248-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392818784-6248-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140219150040.GD2669@sirena.org.uk>
 <1392823461.2351.61.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6027258117925567294=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7845F265A32
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:03:19 +0100 (CET)
In-Reply-To: <1392823461.2351.61.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6027258117925567294==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7d9D9O5VQHkAXyI1"
Content-Disposition: inline


--7d9D9O5VQHkAXyI1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2014 at 03:24:21PM +0000, Liam Girdwood wrote:
> On Thu, 2014-02-20 at 00:00 +0900, Mark Brown wrote:

> > But lots of architectures do actually have these operations, I suspect
> > looking at some of the existing users depending on PCI is enough if
> > excessively strict (this will improve build coverage which tends to be
> > useful even if the driver can't be run).

> I know that the other architectures will implement their own ops, but no
> other architecture other than X86 will have Intel SST.=20

Yes, it should be something like

	depends on (X86 || COMPILE_TEST) && WHATEVER

if there's a WHATEVER needed to guarantee the operation is there (I
think PCI does the job).  That way only people actively looking to build
test will see the option on !X86 but people doing wider scale work can
get build coverage more easily.

> I can either send a new patch that additionally includes linux/io.h or
> send a V2 ?

The include of linux/io.h is needed no matter what - if it's being
implicitly included on x86 then someone could change the headers and
break it later on.  If you can send a new patch right now that'd be
great.

--7d9D9O5VQHkAXyI1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBNWtAAoJELSic+t+oim9udgP/RNoOsFkifOUIrjatxn2sEaM
ot/uG9BmvoQXY39iywS0MSPNVybdpnNaVvDI20sI3YMCCYksyia+mVYBH5/Xzjpc
Vg+g5+u+V7YcsRRmtw9idZQKu6C/Wpe+N5zpEZVe/Luw5BF04S/06J1QMyRk9okm
ZXvrupjXREyqM3Ag3Ec6P/hKfg+ncWWJkyQ/hIIrNcDwijSbym9xV+/wzXZa6bye
TZcZnEHRK+Lz5L2oHxJbOCCMxZcLdiOXBwt4X0YFAnksLHx7myrwoSP1SQMPx+8V
84d8soyoSnfjCZ7wv09PjRdfWmvje/uzq2G1boiMr9wovAC5T8Rv4sqCxHTTpTs4
2nbaEtCsbOIpYOVeaTCNTaE1lU+w2XIYNZtXLiewTELpR1wWKJqse/LMkE3ZAIjz
2OR896qXHG/rrkweXJz+4PiIzToh8OHbhBjawVTTYOT/ywGv30Mo46a4ghNwFtri
TWfPMCzzHDZi60nKQBY627lwzlBaMMXBcpUbGdESxQSFtbKVXhcAx+rq9T/FIrpf
Wk6nHfEIMv9/j1NsPZkCiYybBwtOy3Z0qHW3fHktTfuLcQVLzNALOb/V0eVjVX8J
whNLFHpmQNhfxylCOB1vs9Fg/k1TKLtg4i1razFFo9KJeEZMY29wCGF6jnPokJ9x
7rNwr4kdpAT/Qk4TZCMJ
=eo+S
-----END PGP SIGNATURE-----

--7d9D9O5VQHkAXyI1--

--===============6027258117925567294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6027258117925567294==--
