From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: samsung updates from arm testing
Date: Fri, 11 Jul 2014 14:54:00 +0100
Message-ID: <20140711135400.GY30458@sirena.org.uk>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5263814657280680091=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1405086308-1461192-2-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: t.figa@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5263814657280680091==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u+HAydxlPP+oPOdi"
Content-Disposition: inline


--u+HAydxlPP+oPOdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 11, 2014 at 03:45:03PM +0200, Arnd Bergmann wrote:

> Here are a few patches from my randconfig and multiplatform series.
> The smartq patch is a re-send of the one I screwed up the other day.
> the dependencies and dma data removal should be trivial, the
> dmaengine one probably needs some closer inspection.

Hrm, can you check what's going on with the series - I've got two copies
of patch 2 and an extra patch [PATCH] ASoC: s3c64xx/smartq: use dynamic
registration which is threaded before this cover letter and looks like a
resend of the prior copy with the platform_data header missing that got
included by mistake?  The patches look OK but I just want to make sure
I'm applying the right things.

--u+HAydxlPP+oPOdi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTv+xwAAoJELSic+t+oim9/IIP/2Ka8zRPXObUQfZIPgkJX0Oq
cFTbVku8wCZ75AsrOyQRfWp0ecXu7MYM3LVDNYgC8Ra/YaxaSl47uAA8MNiKB/4Z
rTH70uFSZTfPq/ITuFC3P/8sShHE/xOq9Cr2PAoesSC5FF+iuCP2IoeJu0TVQnpO
mYoLf9w/WrWnqQwxdHmOHIwQc8Y0WB/y+LliE1KaEUJ4jz3NaCj+a/Lg0pWTSYnI
/9F40EjOmbdfPjCVwq1fe1senasvYCBrz+LTGS5aTFEaAnDuZsSUr7Af1giEeRz6
rFniQW49FtNx7z94nMTn3JPWMZN3HCSeWDW7cJS1Nozeu2E9xWvTtGN4mG9kUyPm
1g2tMdiwrOlcn5rCIj3wKXy/E6+4DSjj7udwgeV/lYTxjdumueTlrhNry7rl4wP7
a2UdUxxOrAouOtzvPT9WXOUdw8KN5iLMiZvpVZiz948SNGQA3Xhi1heZYQnNVh0u
Mmi9WngHvpxLEG1BSjSryz/iCFH5KRwORD1h6bwWP2z14HnkfNR3f5MNfhUwr5Mb
knweQGQwaCX8seyNdw0ZJzpv+e60ShD7pwvs3zDjUMTs37V4gbIGeIOjl5REjGyy
tKfgFDy8R1Dff9cdsJJZP0m7J2UdCUHDCbrufyU0suxlF60VU3trhG9VXPayYZQh
rGZ7fkcjEwwCUGklFbfq
=5xEO
-----END PGP SIGNATURE-----

--u+HAydxlPP+oPOdi--


--===============5263814657280680091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5263814657280680091==--
