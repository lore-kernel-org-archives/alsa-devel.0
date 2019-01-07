From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: atom: fix a missing check of
 snd_pcm_lib_malloc_pages
Date: Mon, 7 Jan 2019 18:10:18 +0000
Message-ID: <20190107181018.GQ9570@sirena.org.uk>
References: <20181226022950.71824-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5228280612268082788=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4236F2669BD
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 19:10:24 +0100 (CET)
In-Reply-To: <20181226022950.71824-1-kjlu@umn.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, pakki001@umn.edu
List-Id: alsa-devel@alsa-project.org


--===============5228280612268082788==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="de1H0RjRxOSdb4we"
Content-Disposition: inline


--de1H0RjRxOSdb4we
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 25, 2018 at 08:29:48PM -0600, Kangjie Lu wrote:
> snd_pcm_lib_malloc_pages() may fail, so let's check its status and
> return its error code upstream.


Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--de1H0RjRxOSdb4we
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzlgoACgkQJNaLcl1U
h9ANhQgAhHbiwBS6b8x9Tn9JFl0iCcDZB3svIqny+Ef/LSlGRHidf/5/e+bAKf2/
3REHixLpaTnnNpPlAyq+oJZkclpY7lz/WgTfAoW+JPtCkb5CA/XokaPa1pu8zBYR
WYLGU5MjckgX08S7Hx1gR+Kmy6TXSHm4CWhbjfL6SaVvaCLB7Sfnnk6KGygUC2FD
7tEPxKd0bpLwQGU+G3WSA+gHeNrTNjgnf8Fq1EfRYvOUWiz3DRw4n4X19T18Cfp4
+nuaEKZVSlEhtq6K1BUvab334bJbyWG85f0kxNjVOy301rmKKc43gwvcMyxKa1Ke
cRSTNPd2J870DwhQMfKVUGwMDuofRA==
=UU+m
-----END PGP SIGNATURE-----

--de1H0RjRxOSdb4we--

--===============5228280612268082788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5228280612268082788==--
