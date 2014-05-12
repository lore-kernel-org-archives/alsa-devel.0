From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] ASoC: Intel: Baytrail SST
	suspend/resume support
Date: Mon, 12 May 2014 22:02:33 +0100
Message-ID: <20140512210233.GR12304@sirena.org.uk>
References: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6174703965947672859=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 461E52650FA
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 23:02:44 +0200 (CEST)
In-Reply-To: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6174703965947672859==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mnteZLARgQRrZeZ"
Content-Disposition: inline


--7mnteZLARgQRrZeZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 08, 2014 at 04:07:20PM +0300, Jarkko Nikula wrote:
> This set adds suspend/resume support to Baytrail SST. This is
> implemented by putting the DSP into reset and by releasing driver
> resources before suspend. In resume path the DSP is rebooted in normal
> boot state. Active streams are restored by restarting them from last
> known buffer position before suspend.

Applied all, thanks.

--7mnteZLARgQRrZeZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcTblAAoJELSic+t+oim9H7AP/j8RdsQjWoAq2VTNIQoUvRVp
qpcQ2kzBhng7SCtGpKDtDtj7iNhQNz+HcLK3IiUJs65QDgmCgYpWOgIgycP7yj2a
WzELLqfY+il8LcjLF9S85YNcIvor5W0FTKUcSwQXDWRLm9QGGJQBZrrzf2H3jGgZ
jGqF39UP0rj7Q3mHUuTv2fbxXHOCWjFUqoEtp/TDSKdS0d928rFi+NhX2VhYGrnf
Z7ER+6OLjfJJdF7VVOo1ChRscnBCwo5qlAX499FQLIywZkuqRm33Xqosk+UmM/v1
hnhXnOl+sOWqREe+SYZTyz0Bc5xvQ24KU2x3FhzY34X2D6N701+ip1CjhiA7oyLc
ds8LwF7WsV+RYsTfDoofv8QS1AM0oclUlxDM4X0yH+Ue+zqfzDRMdFowkM/uYLMD
tNMYj/cEktpTihwvoBnLQsIG5sALM40v0rd/54TLcTn0LhPesfFT9oV/4HTIQD9B
mrjZWVQ0Sm8pjBCJ8eOy00Y+UBi19OgzxCl0RpjMU3YWGqX0Id9m8RqfByjHKcGf
jzcU/jrxzMoKB7PJAssQrm0abAVMO2v6S5TABtlGtKq6xhlJL/W/PsMlOLOLCKGb
/e7exw63YiPQlclU2ptv6O4RVh7SL8ag7/RCzKLJtCUTeIld/DOaal5qVsCG3+bQ
Pg2tMGSPyEVbWk4dCI/X
=cp4j
-----END PGP SIGNATURE-----

--7mnteZLARgQRrZeZ--

--===============6174703965947672859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6174703965947672859==--
