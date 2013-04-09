From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm8903: Fix the bypass to
 HP/LINEOUT when no DAC or ADC is running
Date: Tue, 9 Apr 2013 15:33:12 +0100
Message-ID: <20130409143312.GQ9243@opensource.wolfsonmicro.com>
References: <1363797453-24723-1-git-send-email-alban.bedel@avionic-design.de>
 <1363797453-24723-2-git-send-email-alban.bedel@avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1248072299386288839=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1363797453-24723-2-git-send-email-alban.bedel@avionic-design.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>
List-Id: alsa-devel@alsa-project.org


--===============1248072299386288839==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U7F658e60E1K4csu"
Content-Disposition: inline


--U7F658e60E1K4csu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 20, 2013 at 05:37:33PM +0100, Alban Bedel wrote:

> output enable sequence requiere the DSP clock. Some input from Wolfson
> will be needed to find out if this is just an undocumented requirement
> or a chip bug.

It seems it's an undocumented requirement.

> +	{ "Left Output Mixer", "Left Bypass Switch", "CLK_DSP" },
> +	{ "Left Output Mixer", "Right Bypass Switch", "CLK_DSP" },
> +	{ "Right Output Mixer", "Left Bypass Switch", "CLK_DSP" },
> +	{ "Right Output Mixer", "Right Bypass Switch", "CLK_DSP" },

The actual change here should be to add a route:

	{ "Charge Pump", NULL, "CLK_DSP" },

Can you submit an update for this or should I do one?

--U7F658e60E1K4csu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZCZpAAoJELSic+t+oim9WpsP/2vMxfyWMVzW22aX34Nw1cEA
LvEJoINgmbZsPPBuG2kf0Via+s0jUOuEeIqQNIUHTErL1tHyTwh6PjNS7sag0KNv
pOk2xMbiE9k43OhlZCOXagfHqnSi17K2/FEBKA+1DObFnKm8VLzprVp5O6lotgA1
ESROE8r98bdwUu+pfOtLd8ArJfoURoTWzlWHqrjM3IBaiavI6sPUhnXkRhF3QZly
U5hn5u6lqJ7mwOFwO+NVlGBDjm6yoI9MraTdbyM1/N6X4JtOBvU1s/OCNvi20VYv
VQU3vdMGF+NYqABO6BYSl3aA3B1M2iXFA/LTIFAr2Ny1F44fNB6EoLQEkgdqEhl3
L6EhPho1xsyqbbuKFB2uDg4m5A8w4TFJkOomgJqLtMMgORSF+BCNwY/WAzlVp60I
gdJ6ElxpbazK77UKGit0vaCHb2OBo+SlOZS8fW9g7kbsn8/4dXm0OmZP3NnEFj0r
M9tFcp0O/j7wwmPMkDFFWPIglr89lLff4WONBVDB3eqUboLdE2zooy/EFWflcpXq
g08wIstdZbX+N7MyMddjyPn14xpsLEhHuP1rz4gytaCTBlBPYmcsoJe3wL5K90FG
0AYpzu1yYESCJVFKw1DQHMU4JjlQHaXPA4E9dMIrzHV0/pRsUvJFkuRqRRN4p0vC
UhUiSeZZOvNd6jN9oCQI
=RtLk
-----END PGP SIGNATURE-----

--U7F658e60E1K4csu--

--===============1248072299386288839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1248072299386288839==--
