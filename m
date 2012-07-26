From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 17/21] ASoC: Ux500: Enable ux500 PCM driver
 for Device Tree
Date: Thu, 26 Jul 2012 15:22:25 +0100
Message-ID: <20120726142225.GJ3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-18-git-send-email-lee.jones@linaro.org>
 <20120726113838.GA3099@opensource.wolfsonmicro.com>
 <50114B89.7070100@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2712650914587880830=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5C52265E6A
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 16:22:24 +0200 (CEST)
In-Reply-To: <50114B89.7070100@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org


--===============2712650914587880830==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gX7DG0PufVj3JKBt"
Content-Disposition: inline


--gX7DG0PufVj3JKBt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 02:52:09PM +0100, Lee Jones wrote:
> On 26/07/12 12:38, Mark Brown wrote:

> >>-	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
> >>-	platform_device_register(&ux500_pcm);

> >This has the same issue as your last patch...  the way you're doing
> >things will break audio on all boards using this driver.

> It will, why?

You've just removed registration of the device and not added anything
else to replace that.  Even if all boards convert to DT their DTs will
need to be updated which you're not doing.

--gX7DG0PufVj3JKBt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEVKZAAoJEBus8iNuMP3dXXAP/115NxMC9YPGEiyKwkdPCvRf
0Ghbh1Kv2AlpCc25WOc/KeasYgk08QUryvYBKRvxjZ1NpA12+XAOZXdGYD8qVgyv
EY+yRiKtib9+JsrnPpV7cLWWFUIYkwgk+xNVKwPaw1xxKUwJjUKiwu2GkysHcFET
TXj7o+JMA9Kfxa2jE3FSa/3JPXgDdLqj7+ZX4olKmIYjGKvdREMv6EuaxCxKAwY0
kVC0InBKXtmwncuQIQ2hwfcgG9h/sgh0KF13dLByEkTaU/3TveiIZvvs9QX038SX
eYc82VwRFhSXvAypRl+rQcHu6xEVlK1GHXpW0kZLqSIw0H4Euw2lmCccyhVO0qIY
spCJ4EseyOyQOyCUZen+r+wbn2N9UqGVfvBZogxMDm2mg8cahyNlrMGKcn4TJfFM
Ko4HnSjEWJIEKd23nOVC5cTyqXEG2x8aRxapZbadOI+qT1hToECZ1P24gbbwmS6I
kuPo8ELWYngS4P+/arSxx+dS5rch5tS1Jf1Pf4OHJgY7TEOAPO3MDw8ga7pa4MMt
6XavRrOV71hNshq7p0/asZdfYb9l+jAF8HXm39+o8GZCbLNVBKQZ/zzAIAhpeKzW
64CKZgRPCTH4m8LkuJ/g1ry+pzkfJkAZv9OzkjfSiUI/EiYIMTCO1tQI7YtWNCYk
xDleYooo2WUK64orbkqk
=lOaV
-----END PGP SIGNATURE-----

--gX7DG0PufVj3JKBt--

--===============2712650914587880830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2712650914587880830==--
