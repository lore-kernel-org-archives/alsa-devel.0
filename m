From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: soc-pcm: Drop the redundant
 snd_soc_dai_digital_mute() in soc_pcm_close()
Date: Wed, 4 Dec 2013 11:46:26 +0000
Message-ID: <20131204114626.GI29268@sirena.org.uk>
References: <cover.1386126119.git.b42378@freescale.com>
 <030f461e95c8d85413f5350e4414c076d1a41e90.1386126119.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5415805063792120657=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FE2B265366
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 12:46:29 +0100 (CET)
In-Reply-To: <030f461e95c8d85413f5350e4414c076d1a41e90.1386126119.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5415805063792120657==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 11:18:37AM +0800, Nicolin Chen wrote:
> This patch removed the redundant snd_soc_dai_digital_mute() in close() since
> it's better to mute in hw_free() which's slightly earlier and symmetrical for
> the case of reconfiguration: 'aplay 44k1.wav 48k.wav', for example, will be
> open()->hw_params()->prepare(unmute)->playi1ng->hw_free(mute)->hw_params()->
> parepare(unmute)->playing->hw_free(mute)->close()

Applied, thanks.

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnxYPAAoJELSic+t+oim9KXoP/3+n6ShDHRQCv62DmMTBSxIh
+m0cnS2apBLlHr2gR+8aYAc7YurPujVqYmnIRPq34oEuXg09jTKZwRHCJQ0l/lxr
w4gFEhK6NRQ8S6pfHqdzQv6v5fghCKw5Co9cFqbn36efQsEW4OLj+p/V7Z5jeUGK
U6Xj2U/QRA94BK7gnJzIstqcVbsLVWa7qseRhMUXyUmqmfclEMe3Vsqcgid73nUx
fQNirtiKb+dCE2jSlBSoPNmP/GT57UThARL6wFyVJ5rjhtjDCPolc7xD1/6jP07h
r+RnS79nHk+77jA4SsvXn8LSrppghDfsDU8R2Wcd+0JlwrUdo858q2g7Wi3oqHzG
4oT4RFaXK/Epmu9yU2C86kllv8a5CGW89QNmXumCvXMx3DTXaZ5MSNhgk7az0swb
SvxLtK4HvnDongyDIwENKVZH1sRyYjN2sBSIc/6irxPW66WO4gOSdVPA2J/6TsYp
3DJ1hURME0gSy5NeS2WiAHICH5kujmW8GCbUnybuzgzVkMkstmbrskBpXoVx1gWa
Sb2ciIEi8XRiIxFiOTSTqqaSHi8MjhsDtPsyJ9WMswS89chPAG6LsZKYG7TZTqys
I4TRQWpiLI5wNfW/ClA65OjGOw9xcf2aoT5rec1gSA8YyWzrxxxgJCpFWxXvwV1X
UVR5SUZH/bO6yjzuaiSR
=htm0
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--

--===============5415805063792120657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5415805063792120657==--
