From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/14] ASoC: kirkwood: prefer external clock over
 internal clock
Date: Mon, 2 Sep 2013 12:01:05 +0100
Message-ID: <20130902110105.GN3084@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkVg-0003Ip-G7@rmk-PC.arm.linux.org.uk>
 <20130901184153.353c644f@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0450365135577252800=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130901184153.353c644f@armhf>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0450365135577252800==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KM+e2hnYAO+MCJ5e"
Content-Disposition: inline


--KM+e2hnYAO+MCJ5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 01, 2013 at 06:41:53PM +0200, Jean-Francois Moine wrote:
> Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> > +	} else if (rate == 44100 || rate == 48000 || rate == 96000) {

> The rate is always good, and having this test raises a compilation warning
> (clks_ctrl may be not initialized).

That should be fixed - it might be worth keeping the test and adding an
else with an error return for robustness.

--KM+e2hnYAO+MCJ5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJG/uAAoJELSic+t+oim9YecP/0W+e4zDMIu240tsbNLreRkR
7x4wtpBQenFTyqTnHSn079yhwP0Hu7DdWrzjofhP1qdrNlbjeOYW2YhtLUp3gQww
OOM+t28YQHKCJp/pG/SwXII++VSYbRaV+yQ19Tq9PHUJ6nR+fBWARiSwETVPFqdW
hPhxeNdhOcbJ1wmfRDrAHKYVqO2/uthH3VM+272YamFR20OLnI9Xwszz0pvFIwnQ
vczd9xgGUWtD7YK/K6uCcvkIhSSH0zo2dw10gcX1hSXC4S/2maXCyLTcF4af2Nw+
ltN2kKsvCAP7ASYK1xndrJQHyCbRVVrpnk97VOddyIe0f7GQPh1uG9hVLlvi124L
HuPb39gopWlQDmG4tQHMPoX5U9Ro+RY6REReSGWwBEJ04AWxkOU3mj85vw5y4Akg
IUwCM1QN41l0CSSy4rFBw0KXlAYnAqDlLgih5NBEmwPELwsTezpzgUbG+p+WiUNF
+qrQ5ltwkCWE5nKnRU0g5FL9lojaEEhkdEA8ZXIqArswuLMsnRMhyjalV4kRKq6V
wfeLANzvZV2zyTVbxaxn1jNOr9uXbcj2A0fJOc408sctjU5h4847p1Jy8turs4TV
CAfMI01vtdya8YyyvwLfwEzp1BS2Uy0WuKSriC5T9z7ejNpFOomg7JWIa8x0iK8z
eC9Icsbxp/49+LwUbLGu
=Y0LB
-----END PGP SIGNATURE-----

--KM+e2hnYAO+MCJ5e--


--===============0450365135577252800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0450365135577252800==--
