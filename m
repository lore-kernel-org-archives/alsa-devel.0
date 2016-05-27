From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH 5/6] ASoC: cdn-dp: Add cdn DP codec driver
Date: Fri, 27 May 2016 21:23:12 +0100
Message-ID: <20160527202312.GB29837@sirena.org.uk>
References: <1464345942-4795-1-git-send-email-zyw@rock-chips.com>
 <1464345942-4795-6-git-send-email-zyw@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6083020064919794152=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1464345942-4795-6-git-send-email-zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jacob Siverskog <jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, anish kumar <yesanishhere-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, "Damien.Horsley" <Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============6083020064919794152==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 27, 2016 at 06:45:41PM +0800, Chris Zhong wrote:
> codec driver get some interfaces from cdn-dp driver, than using those
> to set DP audio formats, corresponding to alsa formats.

I'm not seeing anything Rockchip specific in here...  DisplayPort is
backwards compatible with HDMI, shouldn't this be using the existing
hdmi-codec code?

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXSKyvAAoJECTWi3JdVIfQPFUH/279S+euRZtxQ99ytiWz2/Ey
fFE2/gBYPwGIeGad3t5emZroeNevh9acOKTaPuLdvj2LcRZTSzm1YI6gHG7cP+dz
qvKWnULhscpAsO4OztpqFXlD9OUP/dUPB21J5SUH0x0zFO8CwIwqaJS6btm7gEP0
UpoAojHFDNbZbt5S0jUwOIyL2EUWeAL2WURQ7tlq7JhLvxZHxP5KldDrKu4m0+1U
RuW6A7zivghh6F30oUMbmI1mxDQZeIzbYU+/Dqysk8BcEhe2j+1lOx2PaQxjl1np
yVMWv714uVUEwSSsBzitqaYtIzOyZf8sEW9A+Ktw0UwKcJBDOYanDPFmXh6IuRk=
=cUMZ
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--


--===============6083020064919794152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============6083020064919794152==--
