From: Mark Brown <broonie@kernel.org>
Subject: Re: How to handle jack detection through gpios
Date: Fri, 3 Nov 2017 17:40:27 +0000
Message-ID: <20171103174027.iu556xlqmp2owtmd@sirena.co.uk>
References: <d8e782f1-acd9-09c4-9693-729a6ac07aa3@redhat.com>
 <20171103112452.g7d7wbxhjhtbzmec@sirena.org.uk>
 <27d3a7cc-d67d-28e0-c615-f6e9a56f9de1@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8490125992049347553=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EC121266CFB
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 18:40:35 +0100 (CET)
In-Reply-To: <27d3a7cc-d67d-28e0-c615-f6e9a56f9de1@redhat.com>
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


--===============8490125992049347553==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="alyxwcxkqv4yylwb"
Content-Disposition: inline


--alyxwcxkqv4yylwb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 03, 2017 at 01:09:37PM +0100, Hans de Goede wrote:
> On 03-11-17 12:24, Mark Brown wrote:

> > You can make a GPIO input device but obviously can't have anything
> > reporting through the sound card interface without a sound card.

> Ok, so I could make the driver generate evdev events
> of type EV_SW with code SW_HEADPHONE_INSERT. Does userspace
> do anything useful with this like automatically switching
> between headphones and speakers as a headphone-jack which
> is part of the sound card would do ?

Depends on your userspace, you can also do an extcon which Android
listens to IIRC.

> If not, then is there a way to get a list of registered
> soundcards from a driver, then pick one of the cards
> based on some heuristics and then do the snd_soc_card_jack_new,
> etc. on the picked card?

> I assume that the approach from:
> https://github.com/me176c-dev/kernel_asus_me176c/commit/498116d7e7b4718fa0655c4879e59a163b1dd85b

> Where the struct snd_soc_card byt_rt5640_card is made
> non-static and exported is not acceptable ?

Why not have the sound card claim the GPIO and provide the jack?

--alyxwcxkqv4yylwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln8qgoACgkQJNaLcl1U
h9BeCwf+NvjBFQQLM859t/ZsUqCSdG2bQ+/zq+Aw3bqvI8cVETe3qrdhF0kX8YBt
3/89/TJcPHOVuYdGQBSvpxQsDpQuI3qrgBQDA9ifs4px3IdGe+CWFYGEwH/bPTYT
l7rRqLiioZRNaLUHO57SNjoExi2d2Ymn1aIzWZH7RBCS15KZwOragkAS1mcIQf9N
TsIrhkLBL/eQHMRXdUwWcAEw5jkC3KkmoOb1EMhIxV7aWesdi5R2JSQFV6cTn5d6
lW2x6KVORPAZRuXl3xuClZRFeeSE//lQ8JLi2iD0H+3urslrhaqPXOQPfvEl7Gm4
KLjV4W6oIOknHXY/NENGoivJMBOBDg==
=UnU6
-----END PGP SIGNATURE-----

--alyxwcxkqv4yylwb--

--===============8490125992049347553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8490125992049347553==--
