From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Add support for DAI driver DAI
	widgets.
Date: Wed, 7 Mar 2012 20:37:23 +0000
Message-ID: <20120307203722.GL3107@opensource.wolfsonmicro.com>
References: <1331120862-16161-1-git-send-email-lrg@ti.com>
	<1331120862-16161-2-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4152066190231609469=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17E8210B966
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 21:37:26 +0100 (CET)
In-Reply-To: <1331120862-16161-2-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4152066190231609469==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qwymS7QpGZeA8tRa"
Content-Disposition: inline


--qwymS7QpGZeA8tRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2012 at 11:47:42AM +0000, Liam Girdwood wrote:

> Automatically create DAI widgets for DAI drivers. This allows us to conne=
ct
> CPU DAIs into the DAPM graph. The widgets use the DAI driver dev name with
> a "Playback" or "Capture" suffix.

So what this is doing is the above which is really about synthesising a
name for streams where the driver didn't provide one.  This isn't
specific to CPU DAIs, it'll apply just as well to CODEC DAIs that don't
specify a per stream name for whatever reason. =20

> Also add a snd_soc_dai member to snd_soc_widget so that we dont have to
> use the widget private data.

If we're going to do that I think we should just drop the private data
field, this is exactly the sort of stuff it was added for.  Currently
it's only used by DAIs and regulator supplies.

> +#define NAME_SIZE	32

32 bytes is enough for everyone!  :P  Actually it should be so no real
problem.

>  	if (dai->driver->playback.stream_name) {
> -		template.id =3D snd_soc_dapm_dai;
>  		template.name =3D dai->driver->playback.stream_name;
>  		template.sname =3D dai->driver->playback.stream_name;
> +	} else {
> +		snprintf(name, NAME_SIZE, "%s %s", dev_name(dai->dev), "Playback");
> +		template.name =3D name;
> +		template.sname =3D name;
> +	}

Isn't this going to get complicated to use when building up the DAPM
routes?  The device is going to need to know its own dev_name() to
supply a table of routes which would mean you'd have to dynamically
create the routing table (or just specify a name and skip the whole
thing I guess). =20

Could we not just use plain old "Playback" and "Capture" here?  We could
then use the name_prefix mechanism which we've got to support multiple
CODECs with the CPU side stuff as well, that will then take care of the
DAPM routes in the same way it does for the CODECs - it'd allow them to
use simple data tables with no dev_name in them which seems like a win.
We'd want to supply a default name_prefix for CPU DAIs but that seems
OK.

This would also ensure that this mechanism works for multi-CODEC systems
which I've got a horrible feeling are going to run into trouble at some
point soon for the same reason you're adding in the dev_names here.

--qwymS7QpGZeA8tRa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV8b8AAoJEBus8iNuMP3dkYAQAIePDeZGvza8wPpdbVVJbbHs
n+WwqRO3VZwwbM4GAL5HxvrlXx8EWbdh++ex7dNzlCS56Bk2iEeLxx8RGKzRVKEi
UTgdsbuAuCQHNHHkoyKSbV86YT3yh4b3AC73J38gLc9XiB1gKGeTrM4wcT4uNToA
GS/NjGz7/6+oOcqYKry2ghony29tddO6O8ovQqbx0ihLiv6GnJx9lzNS0+VG25t7
ZvDFISiXwqL0H3qmonrcToP46PBDCjn/sD1eMvYORdggyNGUUcCp1p/h3Wdd0xUQ
10dRwFD6i69/sDvbYWiYtVwK7IpmrxgTy5wadwA0g3kRBXafPLUfZj52HvKGK4qc
IKiSok167PvKy0KWTCQH2iU2/hEWIlbkmffpMyVEgk90ktHg3gXJ4OQO54N1+Fkb
ncHLGZqn9irtpmdAg7GDA/COm3++JWR7L1JDzoEOUqEA1tpdDK2swTTRnoauqp+N
XzX/73CyJ7KiHdOnSZSH9QhPNSIgEgz1YD9O2sY+PB37gbe97ZV91vLmZkqP7IJE
P9V8PZ0aePJls2zSnaamTvxPhFJhSt0Kk9AKp2GINiOnL1bwDtsMYVemBQwOu0mu
fQ1P0z9mqOnoeoYScBQsH4Y1ckAlo18nixBt8k5m7aujvhvPvlpJMCAIJw2faWSL
TFJNAxVMZaf3yRfHHAv8
=jNwj
-----END PGP SIGNATURE-----

--qwymS7QpGZeA8tRa--

--===============4152066190231609469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4152066190231609469==--
