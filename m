From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 03/22] ASoC: rt5651: Configure
 jack-detect source through a device-property
Date: Wed, 7 Mar 2018 12:34:25 +0000
Message-ID: <20180307123425.GC7290@sirena.org.uk>
References: <20180304143610.21125-1-hdegoede@redhat.com>
 <20180304143610.21125-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0350951709908989519=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C923526705A
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 13:34:36 +0100 (CET)
In-Reply-To: <20180304143610.21125-4-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============0350951709908989519==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 04, 2018 at 03:35:51PM +0100, Hans de Goede wrote:

> +/*
> + * Note these MUST match the values from the DT binding:
> + * Documentation/devicetree/bindings/sound/rt5651.txt
> + */
>  enum rt5651_jd_src {
>  	RT5651_JD_NULL,
>  	RT5651_JD1_1,

It's normal to put values like this in a header in include/dt-bindings
so it's easy to get things right in actual DT bindings (and possibly
ACPI tables as well if the machinery for that does the right thing) -
can you send a followup doing that please?

> -static const struct dmi_system_id rt5651_quirk_table[] = {
> -	{
> -		.callback = rt5651_quirk_cb,
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
> -		},
> -		.driver_data = (unsigned long *) RT5651_JD1_1,
> -	},
> -	{}
> -};
> -

I'm still not thrilled about this bit but oh well :(

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqf3FAACgkQJNaLcl1U
h9D3kAf+Lxeu+eSfrwj3VaVjcx+dXJ5PeR/Ke2Lns/bTfH+m65kqZ72zDDjpr5pm
/zgITsxve6MimWirBj49VAE0nzakRCYxNbbqe8wX7uxRLMriCn4IvnG7nbLhPa23
GkmYPCPpeVchhONHk8Wea5nUbRNocLCTssZCN+GNne2t8nSDTWVv9Kxti6SJdUcc
QGS+gLbYVXrXCjJytO5D1o1ENYQ40bnvYo8IeWMyo7KTP01C2ze65MV9N7MiDCVN
5uHllyWNxQsaSZSgniOT28TJC2r3cVNkeK6pvs5XhgJ8YwOhibWG/CAN69wHEl8N
xKmwSYeh6TrIF5YUtmPC4J+uEbwLkw==
=IcVU
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--

--===============0350951709908989519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0350951709908989519==--
