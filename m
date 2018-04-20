From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/8] arm: renesas: Change platform dependency to
 ARCH_RENESAS
Date: Fri, 20 Apr 2018 17:48:11 +0100
Message-ID: <20180420164811.GC22369@sirena.org.uk>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4325866435034445140=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devel@driverdev.osuosl.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@verge.net.au>, Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, dmaengine@vger.ke
List-Id: alsa-devel@alsa-project.org


--===============4325866435034445140==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2018 at 03:28:26PM +0200, Geert Uytterhoeven wrote:

> The first 6 patches can be applied independently by subsystem
> maintainers.
> The last two patches depend on the first 6 patches, and are thus marked
> RFC.

Would it not make sense to try to apply everything en masse rather than
delaying?  I'm happy to apply the subsystem stuff but if it gets things
done quicker or more efficiently I'm also happy to have the lot merged
as one series.

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlraGcoACgkQJNaLcl1U
h9Dwjgf/Q07mk2IWEt7VXFh08KoOEpJEqv82iu1CWXLrjf83nqwrtopuQeod7ep3
mYoWaxwFLG+wRiICbiVvZf1E9oyGm+sd/IceJnV/6vjTX3iAS//6hUZelNkyAjNj
uvj3C3aGO+8n95ziwDEe579wVzhbzf1fNJKuXHavLmvN7Zo0q0J0Z/UcOku5bvIu
cA6uuY4IiNLgq4b2Boe1YKLb4GFrzAMsBSCtrDwhKYPuepVHFN0U9yXjKHPUj9hd
a/0SUXkvRlTTASH/rNZ/izVWymAudG+HJu4bbCuubieJZ2lZ8G3NL2TviyP9O+ql
35zxtbJRtGQ/uHkqH44QJFZmUoDoNQ==
=z1T8
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--

--===============4325866435034445140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============4325866435034445140==--
