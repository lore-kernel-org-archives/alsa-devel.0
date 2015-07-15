From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 9/9] ASoC: sti: Add IEC control
Date: Wed, 15 Jul 2015 12:03:37 +0100
Message-ID: <20150715110337.GM11162@sirena.org.uk>
References: <1434983473-25092-1-git-send-email-arnaud.pouliquen@st.com>
 <1434983473-25092-10-git-send-email-arnaud.pouliquen@st.com>
 <20150710180647.GW11162@sirena.org.uk> <55A62F12.5000100@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2304328569279016126=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA2AC265CC7
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 13:03:48 +0200 (CEST)
In-Reply-To: <55A62F12.5000100@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org


--===============2304328569279016126==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H8by9uLkH0tJPK9x"
Content-Disposition: inline


--H8by9uLkH0tJPK9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2015 at 11:59:46AM +0200, Arnaud Pouliquen wrote:
> On 07/10/2015 08:06 PM, Mark Brown wrote:
> >On Mon, Jun 22, 2015 at 04:31:13PM +0200, Arnaud Pouliquen wrote:
> >>Add control to configure IEC60958 settings.

> >I had one question on the rest of the series but basically everything
> >else looks reasonable - I've applied some of the earlier patches, where
> >there were comments can you please send incremental fixes for them?

> Incremental fix means V4 or additional patches?

It means any patches should apply against my current tree.

> >With this one there's no technical problem exactly but it seems like
> >something we should have a standard userspace interface for so I'd like
> >to check what's going on there and propose something standard if there
> >isn't anything.  It should at most affect the control naming.

> i not quite sure i follow you, this IEC control is not already standard?
> Userland applications like Gstreamer seem already use it...
> The only limitation i saw is that i did not succeed in associated control to
> PCM device, only to CPU DAI. As i will have one additional IEC control for
> HDMI, i will need to manage control index, aligned to CPU DAI index, but not
> to PCM device index.

Right, the PCM association bit is part of it.

--H8by9uLkH0tJPK9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpj4IAAoJECTWi3JdVIfQd7AH/RxNCTJR5+QbRSiZKzG6xxy8
KrmRjY4btDfJnKlrFcNbYDLd42lgHcZMxri2o1vmSk3cgFW8W4M205ksdlDwzmTV
02cJXAnId1NtOOE40dJftyNPtDf3SUc0CWFCQMBcBiQDzvGoSWHz2fDi4T5nAv1N
CsxDP1H9PXQwntDNCnG5IKjGZa31CEbh8OfNEYGb0xnag9rm2RDXms5F7GJL3wRt
UKYt3kyGFB+s41k+DBDS5bXd+t2YGi1sLfJW/PYqfUXqi5XxPD7VU9AxMTzAlxyW
DKcXbj6Eu6tHTaaHyk3vj24v/2XDeNjQKSPXeBtm5ujbXilPZyq7GDku27MtIQA=
=H/G7
-----END PGP SIGNATURE-----

--H8by9uLkH0tJPK9x--

--===============2304328569279016126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2304328569279016126==--
