From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v5 7/9] ASoC: bt-sco: extend rate and add a
 general compatible string
Date: Wed, 29 Jun 2016 20:15:00 +0100
Message-ID: <20160629191500.GU6247@sirena.org.uk>
References: <1466149440-23889-1-git-send-email-garlic.tseng@mediatek.com>
 <1466149440-23889-8-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7867559773157890846=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1466149440-23889-8-git-send-email-garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, ir.lian-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, PC.Liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============7867559773157890846==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MjBORTcaENZKFEO1"
Content-Disposition: inline


--MjBORTcaENZKFEO1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 03:43:58PM +0800, Garlic Tseng wrote:
> Add supports for 16k (wideband BT) and add a general compatible
> string "linux,bt-sco"

This will claim that we support 16k on existing systems which we clearly
don't.  It also seems unwise to advertise multiple rates when we've no
way to configure the rates...  how does the BT controller figure out
what the sample rate is?

--MjBORTcaENZKFEO1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdB4zAAoJECTWi3JdVIfQk0UH/ivAoNRfwnxjiaDNkWMPVJ/+
IMhTGwc4JBqltAFyozsySN0BuihlNlDOtNDOlx4qzPtLjEj3UilN2MKW9gWrUGML
V+tfxVIWDQyyy9kP2ho3KS1jiFhyjXTZdVUgOq7APLkFyVtbyH8mJ8Jje6nH0FrK
nhij4Kb1uraqzUfd5vWRNOAqu1S/Wr/yvZPWY6xPl9QZW3Xcd/9UVraldXxaI/Rx
tYZfrJ3UgQDz6DoeYwxEMo8CeB1+7lewVxNuTzmbD0GgI7KmWB7TSL2Mh3lDACnm
J+2Chr1fCC2OY4QmI5gOwvE+EhoXnveVcaV8GaTJbU9fDJ1s/NRnY3sBsY9VTWM=
=w44z
-----END PGP SIGNATURE-----

--MjBORTcaENZKFEO1--


--===============7867559773157890846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============7867559773157890846==--
