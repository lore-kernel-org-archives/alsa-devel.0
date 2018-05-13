From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/10] ASoC: rt5640: Add jack-detect and
 button-press support
Date: Sun, 13 May 2018 11:29:56 +0900
Message-ID: <20180513022956.GB17611@sirena.org.uk>
References: <20180511132928.7669-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7562715089062212108=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 43B60266F88
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 04:30:11 +0200 (CEST)
In-Reply-To: <20180511132928.7669-1-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7562715089062212108==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 03:29:18PM +0200, Hans de Goede wrote:
> Hi Mark, et. al.,
>=20
> Here is v2 of the remaining patches from my rt5640 jack-detect series.
>=20
> As requested this is rebased on your sound/for-next branch, so this should
> apply cleanly now.

That's not what git is telling me:

Applying: ASoC: Intel: bytcr_rt5640: Use device properties for setting up d=
mic
error: patch failed: sound/soc/intel/boards/bytcr_rt5640.c:556
error: sound/soc/intel/boards/bytcr_rt5640.c: patch does not apply
Patch failed at 0001 ASoC: Intel: bytcr_rt5640: Use device properties for s=
etting up dmic
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

If I try with -3 it tells me that it doesn't even know the SHA1s which
suggests you have something else in your tree?

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr3oyQACgkQJNaLcl1U
h9BZCgf/SD6Gu4SLeygPM6qIdcuH27tcIajVnHBPHaB4VvGYB/g43R30iltGAYKy
kmBe5f0GCG/eSgVGuLyVW2iCxKxsSfAkabq1V7Jj7yLfcl/8Gc0j9cawf3wn1VzP
TZc3IK2NgP/6G8KZr5mUPwBtmSJMbz0y+B/Ht6cxWg4lWtVYJEFptly59VMNwdNJ
EGXNaZfL9W9V+CW+pH7c+a7CPimN78nv2EaVsib53/x3P36rvsnXPDo/ed+vF+xZ
GLLVxmIRyAvMnp6O4W1/poHjE0FHm3i1yPgvspRyMsu4r960v55MZ942kJybplbG
g8HCpdBxiq8tTNPTj69zeQEncqBIpA==
=hrOL
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--

--===============7562715089062212108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7562715089062212108==--
