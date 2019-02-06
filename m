From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/20] ALSA: Drop superfluous PCM
 preallocation error checks
Date: Wed, 6 Feb 2019 14:50:57 +0000
Message-ID: <20190206145057.GA17630@sirena.org.uk>
References: <20190205194221.25924-1-tiwai@suse.de>
 <697e40c0-d0ea-9e50-277e-bba82945c46b@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7722518936925176897=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D327267002
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 15:50:59 +0100 (CET)
In-Reply-To: <697e40c0-d0ea-9e50-277e-bba82945c46b@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7722518936925176897==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 06, 2019 at 10:07:21AM +0100, Jaroslav Kysela wrote:
> Dne 5.2.2019 v 20:42 Takashi Iwai napsal(a):

> > So, Mark, please give your ACK if the changes to ASoC drivers are OK.

Acked-by: Mark Brown <broonie@kernel.org>

> With all respects, do we really need to split those elementary changes
> to single patches inside the sound tree? I would really prefer to have
> this inside one patch or maybe few patches (core/pci/asoc/others). Just
> my two cents.

FWIW it does mean that life is easier for people doing backports when
things are split up as there's less chance that some file that wasn't
added in the kernel version you were interested in was touched by the
patch.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxa9FAACgkQJNaLcl1U
h9C/3Qf+P1D+kRJiEYoJhmq2r+EqI8AHSv0DTU/WcZsMllgfvp7klRKBlFd1Q9fA
AzVOeHjs/4rHEyc733l5wemXZxQ9V1L4fpjHbh+QZwrYUMasxDv7xs/6vRVVfWMc
TnMG1HMGy9sLgFDVIQFA2MpPjnoLIF5sywJaFwzz5G0ksozVzO5CF0dKdKnoA9F9
OSyw+/NEuK7ulgrE2R5mtTUaeID5ABs6TCDOe5ojkvEfkxXWiLDfSB3M8parslRm
xEof23JKBUqh/lZPnTMgrTBtISBcuXWy8HyI2EuR6Dq/OAX2lHfZJvohInqQPTgM
MoDj5g9r9Y6D1ogWLZfRQijhsBiH2g==
=J77K
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

--===============7722518936925176897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7722518936925176897==--
