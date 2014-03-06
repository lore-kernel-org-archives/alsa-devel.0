From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: Baytrail: fix error handling in sst_byt_dsp_init()
Date: Thu, 6 Mar 2014 12:22:50 +0800
Message-ID: <20140306042249.GX13126@sirena.org.uk>
References: <20140305111157.GD16926@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f5vgRAyQYps+TnGK"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140305111157.GD16926@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--f5vgRAyQYps+TnGK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2014 at 02:11:57PM +0300, Dan Carpenter wrote:
> Calling "kfree(byt)" is a double free because that was allocated with
> devm_kzalloc().  There were a couple places which leak "byt->msg".  That
> memory is allocated in msg_empty_list_init().

Applied, thanks.

--f5vgRAyQYps+TnGK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTF/gWAAoJELSic+t+oim9BrAQAIDUXeq+HRfCrcZqA4HC5jHb
ZasP7MxxGEuMI9aH+AMTifeXR//ZwjD75fRqNS0H4P3lMqimkkd0wy6CQfbEYMo4
1drOSqPZo1vcIyRL9LPi67QOLU+l8I49SxlN0eTi7vewcxdUWJRh59513/4LMGbs
c1rpqfi0nbCGduCRoP74PLEzEvXjfQRzs0/R2v0YvSocVZVWRWPVQIW1h/taFgtJ
dyoW5O4uEBYgk5kfFNmq167aKKN67LM6h1PBAauOFLJw3fBSCDvyaUyqqd7trwFe
eZBUqxd3z4LUFjZVxsHpr3OJZRoYWtZkul1A4JsCubTyJwxxYkKxqmPpsR9pJ4bm
+lpN9b6k8cWJxWg2BQKzDT3KUaJbD/iJgcjieXGkurPyMAGxMyVOzic2tPwOv/F0
md+Dy0QoT5mfb6ZmVQF8Nh9AmUapP7DXhIU7DKmAQyggcVNK/bD1gRRWJoSkhwjK
2cxGvcKzyKVAAMPwuT8y9XfK9IiawGJNSLabEYfc6L8bnKCATwdwtHCmas0cwDS7
h8HaBHkRj0y9TX4MrgicsQgyQ8BM1pWr0Js2TJAAo+ZdqroJC2+Q4am2oviFY80H
vmg4C4ItyBRn47zsXB4SstIf+tlh7qo/0le7kTRCaVPPjp8GsGT8mv4uk9YDS/qh
gORoGw9yG9QBUivb1axE
=TF0S
-----END PGP SIGNATURE-----

--f5vgRAyQYps+TnGK--
