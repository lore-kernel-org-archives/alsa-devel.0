From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
Date: Thu, 23 Aug 2012 15:37:57 +0100
Message-ID: <20120823143757.GB7995@opensource.wolfsonmicro.com>
References: <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
 <20120823092216.GA27264@gmail.com>
 <20120823113922.GZ7995@opensource.wolfsonmicro.com>
 <20120823121936.GA1047@gmail.com>
 <20120823125903.GA7995@opensource.wolfsonmicro.com>
 <20120823132618.GB1047@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4857698716389358393=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0286D265CD6
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 16:37:59 +0200 (CEST)
In-Reply-To: <20120823132618.GB1047@gmail.com>
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
Cc: roger.xr.nilsson@stericsson.com, 'Linus Walleij' <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Ola Lilja <olalilja@yahoo.se>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4857698716389358393==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ZI8SPMLIPHYPwRk"
Content-Disposition: inline


--1ZI8SPMLIPHYPwRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 23, 2012 at 02:26:19PM +0100, Lee Jones wrote:

> > I think Ola is suggesting probing the DMA driver from the machine which
> > will also work though I'm not 100% sure if I'm parsing the above
> > correctly.  The issue in DT terms is that if the DMA controller is
> > shared with a bunch of other IPs then it should have one node shared
> > between them all and not a bunch of shim nodes inserted in the middle
> > which only exists due to the way Linux instantiates stuff.

> When you say 'machine', do you mean from arch/<arch>/mach-*? If so, I'm
> keen for that not to happen.

No, sound/soc/ux500/snowball.c or whatever.  At least that's my guess.

> > They instantiate the PCM driver dynamically from the DAI when it's
> > probed which is pretty much what you're patch is doing.

> So they do it in the same why I have with this patch? Do you know why
> Ola might think this is a bad idea?

I'm not 100% sure, I'm guessing it might be down to the fact that you
end up with multiple PCM drivers.  We could avoid that with refcounting
but nobody's really worried about it.

--1ZI8SPMLIPHYPwRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNkA+AAoJEFJkBDiqVpZ4lWYP/jCsFjDYo6psXAknvVMUeg9G
PB8ugyWT3xfi8lDFGx8+J9gQTRTBJpAERHKna62M9WFPTsXE4yYBZ9Sv+y7igreY
vC/dCloETJSJx2Ssk/viBML3m/e6nJYeO6DHTFKolZ9N75/7ZcYgHUP9jVO3IyDe
NCFHcU5G3JNdibMkkE5YN0CycAEF4CfeBDhfa8OyJuCcxGcifHajS0cRFDFIAXJ3
anxq82IPXqRivs8hxq/06AZ7ppaNO7tmXFu0byB+HDw7wrjM/MH/u2cUR1BANbZE
hwCzmVJHhwt/zUysSFW6GF+O1h5PA2KbO0dPTT3m5Zvjg0UCzY7TxfPZwtDIxEup
hWxnAxz6MXg3ebQL1rmVbTW3YBqSf+InhIJxq8Dwd+BoDLk7EkDK4ykGOKg/O5LN
IWDMiuIYq6ne5RkVVbPbdCt1zqa4a6c2/XoAk1HOMupbNpDLEAyGWPbK6w1X7OvW
QiDh+e1AI5K8fYxpHPG5MnEgWJVqrMXRsNWBmKJWlZQ8MVipGrvhd4Re/LxRaY4B
Br+6e7HPwxGSjTWjJ3ozQSY9VIQ63zklRuPwWsuArnljFFb7b4Z0tiKJ52Oc6QxO
9q/fllw5f1J97P1DiYvynuwgwXOvFdLIOYoBM3isLlFWW5pSr6C8E6Ty1BhtAnX/
XWMlGbg5f6LNZ8CCoRQs
=KI6x
-----END PGP SIGNATURE-----

--1ZI8SPMLIPHYPwRk--

--===============4857698716389358393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4857698716389358393==--
