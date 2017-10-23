From: Mark Brown <broonie@kernel.org>
Subject: Prague Audio miniconference - draft schedule
Date: Mon, 23 Oct 2017 14:44:06 +0200
Message-ID: <20171023124406.khqpu4luxs2b72l2@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2817760932737269380=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2001D266A73
 for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2017 14:44:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Eric Laurent <elaurent@google.com>
List-Id: alsa-devel@alsa-project.org


--===============2817760932737269380==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ng5ugvikxp35qf75"
Content-Disposition: inline


--ng5ugvikxp35qf75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As previously announced[1] by Takashi our annual Linux audio
miniconference will be held this year at the SuSE offices in Prague on
Friday 27th October (the week of ELC-E).  Thanks again to SuSE for
sponsoring this.

Following the earlier discussion I've pulled together a list of topics.
I've put people's names against everything, mostly the people who
suggested things but sometimes also other people who should probably be
involved.  I'm proposing that we work through things in roughly this
order.  Does this make sense to people?  Any other topics?

Summary
 - API status summary (tiwai)
  - Userspace release schedule
  - Docs
  - Dropping old drivers
 - Treble overview (Eric)
 - aplay rewrite (Sakamoto-san)

ABI issues
 - USB PCM handling (tiwai)
 - mmap no IRQ (Eric)
 - TLV API issues (Sakamoto-san)
 - Obsolete dimen from struct snd_ctl_elem_info (Sakamoto-san)
 - Y2038 (tiwai)

Future stuff/internals
 - Clock handling (Peter)
  - CCF, multi-clock selection
 - Digital domains (Charles/Lars/Morimoto-san)
 - Large regmaps (Charles)

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2017-August/124623.html

--ng5ugvikxp35qf75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnt5BEACgkQJNaLcl1U
h9BKJgf/QJKoeDy+KpPR5N1iX4AirvTx3fi24I8hdVtjqMgei7cY+4Sg+2p83qqw
TIOcswFWsh+cfXV+3MmpQx9lOnhpUAkCudS/zii1Qd72wbWd/cYp9r1LFqkb/2cN
eqivW1wDoTscpytt/62lanu/d9TZ/SIvJ8gmo3mv2wEeDPjRP3CK7DHT2urtmWND
Yxuat/1LpUji3spRiUgUn5fI7+UNQrHl48mbEs/dL5KTldfzyqKXweomH88OR33D
KiTy6Y0Z8pciQejO7DE5Hg5ECq6TMYvk8Bf86a4PHrd5cYyJmmnGD9f4g7gX1Tkf
id39F4SNgRUQDOJLdLaXwDGHzkwHwA==
=i+aD
-----END PGP SIGNATURE-----

--ng5ugvikxp35qf75--

--===============2817760932737269380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2817760932737269380==--
