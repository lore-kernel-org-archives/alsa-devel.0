From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: fix powerup/down of
	micbias-voltage
Date: Thu, 11 Jan 2018 16:19:47 +0000
Message-ID: <20180111161947.GD7834@sirena.org.uk>
References: <1515660031-9183-1-git-send-email-fischerc@swissphone.de>
 <20180111150704.GC7834@sirena.org.uk>
 <DD64F087E8F0B540A1C9216D6716FFBDF9947CB6@defrsexc01.swissphone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4245954921480616489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F77F266E6D
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 17:19:49 +0100 (CET)
In-Reply-To: <DD64F087E8F0B540A1C9216D6716FFBDF9947CB6@defrsexc01.swissphone.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Fischer, Christian" <fischerc@swissphone.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>, "bhumirks@gmail.com" <bhumirks@gmail.com>, "richard.leitner@skidata.com" <richard.leitner@skidata.com>
List-Id: alsa-devel@alsa-project.org


--===============4245954921480616489==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 11, 2018 at 04:14:31PM +0000, Fischer, Christian wrote:
> Hi Mark,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> Testing:
> arecord -D "hw:0,1" -c 2 -f S16_LE -t wav test_recording.wav
> Recording WAVE 'test_recording.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
> ==> no event was fired

Has your board connected the bias to the microphone widget it defines?
Unless your board says that the bias is in use on a given board it won't
be enabled.

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpXjqIACgkQJNaLcl1U
h9B11wf/WCtPxz5BRF+sLMbaTNQCKxkdAbJ/3/3WQC5SPXC4syvb++oZUmgdFQTq
tFjwS6y3hTy5E5UglQUvEyBNV4S7D12N/VqAJ9RCMu3lzSTwYmDMZGHrAVZj3yn1
8TEayYo/ccodiG5afyvOuR0uUKt0gYK3CE6C/U9RumgA5vdSRqhRVxqBCao5igsY
S5/aRvBkbTGMWkZL8c1cAB3vL1Q1f4L+QauO29hbggyq3R8ebBNqdMahgeXmoM5H
IUmzwq/laF7qSM9IBhjzBiziaSr+wUP6pCEhnFRbg5dkiP5iQ0Bt5goWIGfoNxVn
hC+VgbJOHp2lxB1KjhQE7UyT21OiaA==
=ZFfX
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--

--===============4245954921480616489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4245954921480616489==--
