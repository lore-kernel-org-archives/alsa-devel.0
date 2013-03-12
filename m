From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsi: remove unused irq
Date: Tue, 12 Mar 2013 18:45:43 +0000
Message-ID: <20130312184543.GO19942@opensource.wolfsonmicro.com>
References: <87wqtehgur.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1190378349678121530=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85F2F265DE5
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 19:45:45 +0100 (CET)
In-Reply-To: <87wqtehgur.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1190378349678121530==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5PFZVUeDPxlnBcQp"
Content-Disposition: inline


--5PFZVUeDPxlnBcQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 10, 2013 at 06:20:47PM -0700, Kuninori Morimoto wrote:
> FSI is using devm_request_irq() from
> 1ddd82868cc888e008ed520465c172a6cdddd689
> (ASoC: fsi: use devm_request_irq())

This doesn't apply against v3.9-rc2 and there's no pending fsi patches,
can you please check and resend?

--5PFZVUeDPxlnBcQp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3fQAAoJELSic+t+oim95C8QAJU+OlebplPPnVehqpydD6du
PIRFKW/daWSfXhEY+SDP+7TKiZ5QrLfHArEtfgdJEDycs/jwuDt+/fC0p2VixeWo
bzc3bjq1H4xv5NVlxI7xJ+LplWABS3ULMfYcY6tTTk5nUZAo0CgZm7Xrf9LrhrrM
9kbbdYbM1bG60E8mdXCowJi7/sbeKj0XC1Yr4CDwdlVtE6axZCae04GquEB+8lUI
ubGXybLhf6VI2q0LqZaxGIyipsP0WoDzQ0/HB+Uz1kCtWjFl0iY23XAYxvF8CKJl
tqt9fWbeDgiob5BasGPoIs3+EI7HRhLeIbTfhKbhp7SM5KK8W4rufx3aMiFCg5Uu
ukgW53Ak3gX5tm9UnwrdFYLP5qL4bA1zVm5U6zNS9naqyyd2VXnK//l5DEW2uzPV
+xuQz7NFfinymy1rlz9Nibbg6fZoKdlPnRgNNuuzavI0x85nF0fEP3gXtA7lyQeB
Za+Xdqixar1A3NXvWQmuZhwlIAc2Rov2HkFIsa01lSMGuj/y+lyYJZ6pSJIw3OSy
sk+mXFR35ByxKRwgT4AzVkzk384uAUf7eMaGytaOjstQKsv79E3mGE+D6FFz+A7O
fI55wG0yJqEq5ELp6NAl3VmO6ucJ9NFnMrqpiT2CHzZc/f8aRgKVmRICoGfxttWa
1SW7Dm4wcVZHEL3OEhc9
=qh7O
-----END PGP SIGNATURE-----

--5PFZVUeDPxlnBcQp--

--===============1190378349678121530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1190378349678121530==--
