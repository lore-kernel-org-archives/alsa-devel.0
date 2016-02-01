From: Mark Brown <broonie@kernel.org>
Subject: Re: sound: use-after-free in snd_seq_deliver_single_event
Date: Mon, 1 Feb 2016 11:16:25 +0000
Message-ID: <20160201111625.GB4455@sirena.org.uk>
References: <CACT4Y+Zd66+w12fNN85-425cVQT=K23kWbhnCEcMB8s3us-Frw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zd66+w12fNN85-425cVQT=K23kWbhnCEcMB8s3us-Frw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 01, 2016 at 11:26:57AM +0100, Dmitry Vyukov wrote:

> The following program triggers use-after-free in
> snd_seq_deliver_single_event (run in a tight parallel loop):

I'm not sure how you're working out who to send these to but all these
reports you've been sending have been for ALSA core which I rarely look
at closely, I mostly look at ASoC.  Might be worth looking into so
people don't start zoning out things that look like misdirected stuff
(I just noticed myself doing that with this).

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWrz6IAAoJECTWi3JdVIfQ/GIH/jTuS3sYxRFfE6hl5BCyxymF
6LiL3jQC/ca1HQpzD+eC0UMHtosNocoogkdpgGipUdv7R0WN9+TwxaKgbzRYBRso
uJ+SpUqlOXwgtOM5XCep0i2V7JusuY4M8aNtz2gKkCkTMZAgKi7HJFljLUxWJ7IL
T4LeP6hX0Eed76qdP1BolkZRq+xpzy0Yvhz9Lq7cwP1qRpkt4y4uu5rOx4NvcSJY
IY+EJSezEdNjTO98BxBRVBK1HXAj4lY9+C00wdy0IdVTkDIEHv0rYUhWl5S2/VUN
mtvgtTQvFTx94ToL0yXn03jWCs3WKOnpLadRmaXAWUHIF9+/rDSG82PRs/Q2noc=
=4JXB
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
