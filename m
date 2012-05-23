From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: fix pxa-ssp compiling issue
	under mach-mmp
Date: Wed, 23 May 2012 12:44:56 +0100
Message-ID: <20120523114455.GA18646@opensource.wolfsonmicro.com>
References: <1337669906-12745-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0936436372709108595=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1337669906-12745-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0936436372709108595==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 22, 2012 at 02:58:26PM +0800, Qiao Zhou wrote:

> +#if defined(CONFIG_ARCH_PXA)
>  	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP) {
>  		sscr0 &= ~0x0000ff00;
>  		sscr0 |= ((div - 2)/2) << 8; /* 2..512 */
>  	} else {
> +#endif
>  		sscr0 &= ~0x000fff00;
>  		sscr0 |= (div - 1) << 8;     /* 1..4096 */
> +#if defined(CONFIG_ARCH_PXA)
>  	}
> +#endif

This is pretty large and fiddly, especially code like the above.  Would
it not be simpler to just define always false versions of these when on
MMP, either in this driver or in the arch headers (where it'd help other
drivers too)?  Right now it doesn't make the code look nice.

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPvM2RAAoJEBus8iNuMP3dePsP+wV+OEh1JAlqp9K3YhcuC/Hv
PdAoVLFdbHdYUTkFKgd+K4PkdbNO/6+hq7ibwvU2KEmzRmRUgzcveeNSrnvyxcTz
Vzl3FtLZNboOwrwcMJVR3qjdFj3Ld+ayuA51TaqWH/UKFY0/gdtUoHb54a9zOgM2
aQTTOYdhxx7tSJEToXjeVqfpDJxvPBq6ajbtwJHKQew6IZJOWtEWqOr7gSw2/bRZ
pwZ/FgGduurIYYfguYRJEOXQ7YrOUaeuDgbvc9ZNhDFFya7EoVDHoFtq3cnt85L9
GdFqL0hZoGSXu8iSd8TEKcE9ri8AGsgxKF0N4tM+sqRnseMp3ytOw8CDMwuZ5A6u
YapwioIUtCSC4cN0CvbS+Z+BvpZWLoIH/OXvA3MkSW/TKmBnhjXmyB6e5J6CKz1g
dgBK0O5tJwKwxtAUWkvHK2Q9OXy9k0CmKKdccUECCB/GiMndB0wtSmTEgVstGeNv
w8M7v1o3XwcxrzyJ9CWo9Hs98Uypl0P75wt5VQpmfID4FN4QvUWpcQ82oEVBacnT
R9dfrtkXmaxvKYamVRmRuaCsi64uotp2uNpJVxkS2J1OSrC7oExd5im+OH4Eg7L2
1vFvrcV6EesJHcJXEHV4ogj/ayVsTOWDr5qfbQQZCbOZBMNt3oUddWZ1NCy5ZY6i
nPWckdZIAfiiyB8Ubhqa
=cnnC
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============0936436372709108595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0936436372709108595==--
