From: Mark Brown <broonie@kernel.org>
Subject: Re: How to handle jack detection through gpios
Date: Fri, 3 Nov 2017 12:24:52 +0100
Message-ID: <20171103112452.g7d7wbxhjhtbzmec@sirena.org.uk>
References: <d8e782f1-acd9-09c4-9693-729a6ac07aa3@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7402757185190282982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 926B1266A0C
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 12:24:56 +0100 (CET)
In-Reply-To: <d8e782f1-acd9-09c4-9693-729a6ac07aa3@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, sfumato1977@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============7402757185190282982==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tr3oanaqr2inqpga"
Content-Disposition: inline


--tr3oanaqr2inqpga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 03, 2017 at 09:41:29AM +0100, Hans de Goede wrote:

> So I was wondering if there is a way to have a headphone
> switch without tying it to a card, while userspace will
> still know what to do ?

You can make a GPIO input device but obviously can't have anything
reporting through the sound card interface without a sound card.

--tr3oanaqr2inqpga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln8UgMACgkQJNaLcl1U
h9DvnAf/Uinl6021AMPyLIaJc+bJUm/9+pC3VeOa9LUyUCzUtlHFJ0sGA1xXO5dt
3+QJCpl/LMrVLY57gn3vUq5NGmdu6YSgVtclX1s2uwdC+K4R+EzAu56akHtr3q2j
7V7MjWrDqq+lFVH6IqH+xg4rPFTcLcx3qBpVPBK8XWcyHzjRfdaeEfpUyiA5o5hb
AfSjmmqyT0TI0PhwauW/eNO28JLLYheRvun6rMG0AubpArmK13QsY7OYNwYJuch8
0dggEM4rk+YBRYG/DbStxkf7c8HjfiyhWdzsiQDcgwyZBKARlNFlRS2srmXlhySj
Gd1/7KDeN7Xa/Br0j+fAqwktPwYvPQ==
=UakS
-----END PGP SIGNATURE-----

--tr3oanaqr2inqpga--

--===============7402757185190282982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7402757185190282982==--
