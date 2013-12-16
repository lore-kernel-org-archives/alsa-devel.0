From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-spdif: Use module_init() to
 handle platform_device_register()
Date: Mon, 16 Dec 2013 19:47:17 +0000
Message-ID: <20131216194717.GO3185@sirena.org.uk>
References: <1387190169-7936-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0116758452714666470=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0850A261729
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 20:47:23 +0100 (CET)
In-Reply-To: <1387190169-7936-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux@arm.linux.org.uk, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0116758452714666470==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEfizQhTV1P/vojJ"
Content-Disposition: inline


--vEfizQhTV1P/vojJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2013 at 06:36:09PM +0800, Nicolin Chen wrote:

> 1) When modprobing modules in order: snd-soc-fsl-spdif -> snd-soc-imx-spdif
> -> snd-soc-spdif-tx/rx, we will fail to create imx-spdif card and dai link
> unless we rmmod snd-soc-imx-spdif and modprobe it again due to inappropriate
> condition of platform_driver_unregister() in probe().

The crucial bit of information here is what the "inappropriate
condition" is - what is this trying to fix?  The code doesn't look
obviously wrong though it does rely on the platform device registration
taking effect immediately to actually probe which is a bit of an
assumption and is probably the thing that messes up the first time
around as the S/PDIF CODEC drivers probably aren't loaded when the card
is trying to probe.  This probably causes us to hit a case where
deferred probe stalls as it's not making any progress as one of the
deferred devices essentially has a dependency on itself.

What should work right now is for the module to ensure that the S/PDIF
CODEC drivers are loaded before it is by linking to some symbol from
there.  This is a total hack though.  Nicer would be for the machine
driver to either directly register S/PDIF DAIs (rather than devices that
then register the DAIs) or to create a card subdevice in parallel with
the S/PDIF ones and hook the card registration off that.

> 2) After "imx-spdif sound-spdif.17: dit-hifi <-> 2004000.spdif mapping ok",
> doing rmmod the imx-spdif would cause kernel Oops:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1301 at /home/rmk/git/linux-rmk/fs/sysfs/dir.c:915 sysfs_hash_and_remove+0x84/0x90()

Please don't paste entire backtraces into commit messages, they're hard
to read and very long - this is over 100 lines long and doesn't have
anything like that much information.  Either edit them to pull out the
important details or (better yet) explain in words what's going wrong.

I *suspect* this is triggered by removing the CODECs prior to removing
the card which should work but doesn't entirely (we lock modules in to
prevent it triggering normally unless you go and really try by using
unregistration).  Reverting back to normal card registration and doing
that prior to unregistering the CODEC devices ought to fix the unload
case at least.

> Ideally, we should bypass the device_unregister() if getting EPROBE_DEFER,

This won't work, it'll cause the next probe to fail as the driver tries
to reregister an already registered device.  I'm also not sure why you'd
want to do that...

> +static int __init imx_spdif_init(void)
> +{
> +	int ret;
> +
> +	txdev = platform_device_register_simple("spdif-dit", -1, NULL, 0);
> +	if (IS_ERR(txdev))
> +		return PTR_ERR(txdev);
> +
> +	rxdev = platform_device_register_simple("spdif-dir", -1, NULL, 0);
> +	if (IS_ERR(rxdev)) {
> +		ret = PTR_ERR(rxdev);
> +		goto err;
> +	}

This is going to cause these devices to be loaded on unrelated systems
if they have the module compiled in or it gets loaded for some other
reason - we shouldn't do that, it'll cause errors in their registration
paths which may stop them working at all.

--vEfizQhTV1P/vojJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSr1jCAAoJELSic+t+oim9o78P/1lyEWdh6SGz9Agmxl0raLWn
dwxzPBCWLQ7FgvAn08APdwOISh3bgHWs5ZFggX4Xh/g9iQJSplwGBWCzc7mW25+w
ZUo0E74GOI1fGD3zt3IjR3qudk0fM6wwG+MrS6XO/CSPanxzhNCZniLU6EFCXm/U
J2qMp+cFrus9PcXnVNdFP5AiOISa2FvzZHABB/amcdbzlu2gF+aaEzUWfKkvxsiw
uZnSOKXUlmnJgii7BHkLPYuacFKjhuf4fAyLrUbEe9HEPVq+ZBGCA61JwGzzcFdS
S/DiQ2YHFcxpzUYrHuKc+CARO0gP8eY8bNUHRuNDlLRIfFFy44KIGZbXOpWvm4Tq
3hrsqxQw4BSQcsRq+upgpxQ3EJh4G/3fNhCH5xeWDkReuXxijN+MSDSEg8l0jogf
qNLxiqJeb5Yzq3TbauiSZ3lvLJFXP9jJsYJtzcsauIAe073w1E9aAhSvPFkxBvd7
grgvu+6Ks8E1b8G4xNHiF4jzXAg4PuQtX+9/07jx8R9QDYZne3g7aSmP1zw/16uU
DWZOQXUnSImxTXR/liY5eO8hehcTl2qjnycJ81YJQb8WV7iTJmxHkxqvmqfzSqpf
kWuW3b8kPON1EMdTcbE8AS4+5eXCO4DsH5HubHV+uAI0K0ujjHUwLYML2cP7cZbW
NR5LbF0PF2vnJxWk9bhA
=GhzF
-----END PGP SIGNATURE-----

--vEfizQhTV1P/vojJ--

--===============0116758452714666470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0116758452714666470==--
