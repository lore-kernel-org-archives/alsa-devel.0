From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/25] ASoC: remove __dev* attributes for
 retirement of HOTPLUG
Date: Mon, 10 Dec 2012 00:30:26 +0900
Message-ID: <20121209153025.GG6511@opensource.wolfsonmicro.com>
References: <1354890397-28568-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5179564572817967647=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 38515262617
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2012 16:30:37 +0100 (CET)
In-Reply-To: <1354890397-28568-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============5179564572817967647==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 07, 2012 at 09:26:12AM -0500, Bill Pemberton wrote:
> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
> and __devexit so that HOTPLUG can be retired.

Applied all, thanks.

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQxK6GAAoJELSic+t+oim9xg4P/3pCLjmImUcmrWl2+4TLkBJ/
N3Z2C9ljzcHLpU5ZX4qScB7/wrfLzfDJbIKmxFFKltewRk74KW1vaGS8qLcD1i9X
OCyspr0caIh60XqC0o3i+zKZLFgWmw/pAPEW5mkbIRSOY3LPMzH73v/FtXUII7of
dttb7jV/pZPquCFRZ3xQUj80DsxXmHPMtmd6OT8zIRq6IpGqPSMrhAKqGCrH2T94
4e6UzBNZtFbHk3s3un+EUfOdKNoIEDqPKED7Pu18lEDt3BbklmZVVjaG7AMpDUhR
O4OJM2/DDjJsj4FLHjIPf3pKRYZzAIxmhv9AfATtqCuLfqhA6Pp/fZIIWuNNRB46
vhEkCDROtyF43Qmq40FHVr78i/mX6Qt4ceUs3EkNt8Mi/bf4RrXkppt6xn2ytdnm
fL4223Y+yXY5R9Ax0S5kZlyC7ldfg/ruO/eO3fCuvhWKD3yiCT7WoS10TNamONSW
XKXegxuVy73ZoP+ciHFlcqLrHx+XHZGPqNEeFAGDrfcGZVBX8QN67s7WGzgvEp9D
Zn6jLfqfBrRtevw9/6Z9ukNHXhjYKMKu0NmW6YvkKgAIbpGSA1eG5qRi+ZS3LcFs
nqaCHOcTOkLaD+tVdobkRfpOH7+TWhhl7RnO+VsYkvYTHoy/IvjdsfyFW1bXbC+n
Li2d23PUCj/KuBxd2AhO
=qR8z
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--

--===============5179564572817967647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5179564572817967647==--
