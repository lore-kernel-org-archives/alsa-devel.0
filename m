From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/11] ASoC: rt5651: Fix bias_level
 confusion / overcurrent detection deps
Date: Thu, 22 Feb 2018 10:52:05 +0000
Message-ID: <20180222105205.GB5905@sirena.org.uk>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-3-hdegoede@redhat.com>
 <20180221114045.GB8334@sirena.org.uk>
 <361a97ba-4af8-8a99-f092-4c63c5570348@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0979686108425592763=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 55D8026768F
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 11:52:09 +0100 (CET)
In-Reply-To: <361a97ba-4af8-8a99-f092-4c63c5570348@redhat.com>
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
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============0979686108425592763==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2018 at 08:43:47PM +0100, Hans de Goede wrote:
> On 21-02-18 12:40, Mark Brown wrote:

> > This is now only enabling the LDO and bias when the jack is inserted -
> > is that enough?

> Yes, we only need to do OVCD on an insertion event to differ between
> headset vs headphones.

Is there not a fault protection aspect to this?  The naming and the
separate control makes this seem like it's got some wider purpose.

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqOoNQACgkQJNaLcl1U
h9A4Zwf+I1LjM9rjvBX9gh6JUCR+xbxp4PpOh25H3T0B+Q3skPaUw4INSUudZsNC
4tJGR2t2+exWx2ARERaxJ5o6/OkNNLM2qJnjvniicF7+IrI5uI1RE9EYCWmZg3Rx
qxTjquw0+XpJtkBQT9Rr9KxvGXM8x+ZJgLbKFc8rjkrFw4ElTYuXlooJH/QGEAoa
VaLVdXqXzYKBgYiDllzV5ESzjDKMtl7ouDejT3bqiT3CLTpD4tJLFtTNoUqqpWCm
TVPvOxAFGJ9fENmi3inFya+RIzM0abLFW/gxw96wqpu1HqSQ52n6RSGS0lqFDpPJ
UgtKybnH5XWJyBwCX/Mqkjy23Y/lkA==
=Wo+S
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--

--===============0979686108425592763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0979686108425592763==--
