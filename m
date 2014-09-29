From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: byt-rt5640: Remove IN2N
 pin from DAPM route table
Date: Mon, 29 Sep 2014 19:45:23 +0100
Message-ID: <20140929184523.GA16977@sirena.org.uk>
References: <1411999096-1867-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2495998340968917967=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 06EE126064B
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 20:45:30 +0200 (CEST)
In-Reply-To: <1411999096-1867-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2495998340968917967==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRyyN4gAPkNkeCwp"
Content-Disposition: inline


--wRyyN4gAPkNkeCwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 29, 2014 at 04:58:15PM +0300, Jarkko Nikula wrote:
> I tested couple byt-rt5640 based platforms and they have single-ended
> headset microphone connection to IN2P only. I guess IN2N was either defined
> by accident or some early platform had floating ground for headset. It's
> better to remove IN2N and add a custom route for such a platform if needed.

Applied both, thanks.  I've got a feeling we may at some point want
infrastructure for the DMI stuff but that's not at all urgent.

--wRyyN4gAPkNkeCwp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKajDAAoJECTWi3JdVIfQ1kcH/29U0yloo08YS0QXFaTa64Bw
PWfMPZ+epO0NWqMHj65f9oAaddkjhoHdLG5VTRm7RsnQC0ePD1hkkbmoOXD6BGSg
RmL1IdNAG0LR1V851FIb4qWPKzyE0cb3rjl6z9b7vzpxchWxqrfQdfbtwpfke4N7
EqvdOaSzZMOfyqYEu6nCYEleUc6ixEJRc4c5owIALFFU06nRIpCLYsi1Zr+tU9hs
8HJ3tR4GXMWCy9tLFkm5AlwjIjXjEYgh1jZTpPszQEZI7tSLcqsYYhkPvL33z16Y
X5+bpKCSgJa9s4/9h4XgUxUXqn48AcIygUcD1qfJioO7THoczXi+gTLf4+fp4w8=
=iL/X
-----END PGP SIGNATURE-----

--wRyyN4gAPkNkeCwp--

--===============2495998340968917967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2495998340968917967==--
