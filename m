From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/9] ASoC: cygnus: Update bindings for
	audio clock changes
Date: Wed, 16 Aug 2017 11:59:54 +0100
Message-ID: <20170816105954.ve434zeeqinweo5a@sirena.org.uk>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
 <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
 <20170815171424.whcy4mftex6sgzgj@sirena.org.uk>
 <d7e7144b-26c7-b96a-663d-03744bb60c36@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4049168930419354795=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C398266B1C
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 13:00:06 +0200 (CEST)
In-Reply-To: <d7e7144b-26c7-b96a-663d-03744bb60c36@broadcom.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lori Hikichi <lori.hikichi@broadcom.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4049168930419354795==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hu3g6i46vczsjiqa"
Content-Disposition: inline


--hu3g6i46vczsjiqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2017 at 12:29:44PM -0700, Lori Hikichi wrote:

> I have put the mux assignment in DT because the assignment is a
> static property and did not need run time programmability from the
> machine driver.

Why is this a static property, what prevents something wanting to change
things at runtime?  You might be running with simpler setups now but
perhaps you'll run into a more complex use case later?

--hu3g6i46vczsjiqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmUJaoACgkQJNaLcl1U
h9DBVQf/QYakhCkjI6NH7WGhvsWA5pimykDByuAWlb1OYQtKrfLZOI8PypKA3Qxv
3l94ooRw/VJyaQ+EN8mGfAJHhKRkSOKyBbTaPZgYG1xfO++2q+bOgUF4rmI2tvgZ
MohWccAMean5OUpvIHRjWGdmjRYPh04HhMQB8sa1lKqVy8NTSkSPxOCUnOFV7PSz
oX2L9haenpow4IuaUXZuWGpG/dqmHt+GAjF2/2IwEsClKvFL1DhclVoP6NMLQQcq
irKN9eAkWaJ/4hDczz+/rDDdEkBf07lSxJKaJCk5vqL8bPmqN5Zx1XMl14wM/N7Z
EZRJPW36rJLHv/xsmKsc0PL2aXB/IA==
=o7VN
-----END PGP SIGNATURE-----

--hu3g6i46vczsjiqa--

--===============4049168930419354795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4049168930419354795==--
