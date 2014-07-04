From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sirf: provide pm-runtime functions
	when needed
Date: Fri, 4 Jul 2014 20:28:57 +0100
Message-ID: <20140704192857.GF14896@sirena.org.uk>
References: <6778119.KeB0KTehn3@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6886369144135020316=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D8BF2654FB
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 21:29:14 +0200 (CEST)
In-Reply-To: <6778119.KeB0KTehn3@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6886369144135020316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 04, 2014 at 05:07:41PM +0200, Arnd Bergmann wrote:
> The newly introduced sirf-usp driver defines sirf_usp_pcm_{suspend,resume}
> functions only when PM_RUNTIME is enabled, but also uses them when that
> is disabled and only PM_SLEEP is turned on, resulting in this error:

Applied, thanks.

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtwB1AAoJELSic+t+oim9joQP/A88yXBvH2oXXKINrUPsre7n
+LVWusMEMN5ugh0hTnsqQsyUjXOG2FJ9Zt9MjxFRTz9dIpyR9ZnefaDTDL1N2yFp
Bf2jI8JVUk8eoFmQ+LKfq2Z9rEhKS1FQEHYNmRcjBry3iRpGLM7sMhmxzV46c/Jg
suERde4FbXfGHDJEjeqkue7p6gA2gERvjnbOZjaPuJVjdMNKRTxUTcpuF21Bg+Of
n51G0KzKqz36kb5fKuFKcCC8xVsMT7bRMGR3YALlUNKvqAW9C/3M8fjHgzgYywWu
m2mstMvb9reYAQ6VYzoXgJM6uil0tzZ8/pmxvX6s5iGoHUZlf/GVDRo5ieXP6jT8
1tWSvUJelCdg1bCnGIwyhl1xYxOhBeH6rJAomXC2/7vsH+mHRD3E/ZY+KNcDwena
d3aoWU1n5KxllqUQ41fXIsUJ3RSZm9CC/3KVOtY5HJuAZdibpCUPrOmmkrm1Qekx
m4Loi+jw+zeAixmQWSdbLMV+m/WfMYmcLYVfi5OcilP3W5adZxRRPaifXfQJBOs8
TiUZ0cyghCGyfZVuUdHPerwq3Oauq2fRGGGu/mYiYNznG+kUuo11S4NbZ+cEvhb+
vqE0KRjWO981q+jHyCbUagUG/6ydUzzk1fcxPHVK1kSUTPzbqc4De7jTJTFD6a6K
+OVIbREZ9MoU7b6zQRsU
=p23Z
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--

--===============6886369144135020316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6886369144135020316==--
