From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Wed, 23 May 2018 10:49:28 +0100
Message-ID: <20180523094928.GE4828@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
 <fb9aebba-919a-2e80-aec7-2fd44e5e1861@linux.intel.com>
 <CABXOdTd5+QJHOZ6BcSO-TfJCqcLzdd+Gbnf4HYh9i9cG+UH+1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7227279949561204545=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C93EE26705D
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 11:49:34 +0200 (CEST)
In-Reply-To: <CABXOdTd5+QJHOZ6BcSO-TfJCqcLzdd+Gbnf4HYh9i9cG+UH+1g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guenter Roeck <groeck@google.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "Patel, Chintan M" <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============7227279949561204545==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 02:59:50PM -0700, Guenter Roeck wrote:

> Most people are not aware that they have a backwards compatibility problem
> with the topology file. They will typically notice and report that it is
> impossible to get audio working with an upstream kernel on a recent
> Chromebook, and as users they rarely know about development mailing lists.
> Some technical discussions are at

> https://github.com/GalliumOS/galliumos-distro/issues/379
> https://github.com/GalliumOS/galliumos-distro/issues/274

> though I had seen others earlier. Guess next time I'll have to preserve
> links. Anyway, I am not really much interested in an argument/discussion
> about my use of the term "widely". I'll rephrase that paragraph in the ne=
xt
> version of the patch, should it come to that.

Right, looks like the disconnect I thought it was - this has been
discussed a lot within your distro (and possibly others) but not outside
it so the rest of us are all a bit surprised. =20

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFOScACgkQJNaLcl1U
h9ApxQf/SJ5Eu72VC7VhHmf/bojOTotPNUtRXqeIrMmuJBSuSiJsY85LqExG4eKC
RgTqp0eUyCi0xIv7kWXhzl1xP6XV6wINyoe+PIQE0u6Ehf5/uaxlqnX79ms8cxLH
P855j2hijGgkLaDjqf3lKC8JdrPM4b7BaM8+wjY/es5Q1uTeLw8JvCHHZW6QROYG
2/2SUXhzskJ7fri5t8EH5BmzyupWcOE5vEncGJ0677gMD1A8nA2mBcf648jUF+qK
1TvpTwKiN8DY5LtSHuu7cKV27Wz95tNhyYSMibvTExzOOx04fyfhDic4giMJPi09
NRdMaRPo9QUVkDojwpxSPDuKHQ/67w==
=y/9D
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--

--===============7227279949561204545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7227279949561204545==--
