From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] sound/soc/atmel: don't use
 devm_pinctrl_get_select_default() in probe
Date: Mon, 14 Oct 2013 17:37:53 +0100
Message-ID: <20131014163753.GF2443@sirena.org.uk>
References: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
 <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
 <20131014131748.GU2443@sirena.org.uk>
 <20131014145629.GA17351@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oxour8c+zPVguRmP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131014145629.GA17351@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--oxour8c+zPVguRmP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 14, 2013 at 04:56:29PM +0200, Wolfram Sang wrote:

> > Applied, thanks.  Please use subject lines appropriate to the subsystem.

> That's quite a nut to crack with a generated patch series running over
> the whole tree. I wonder if it is really worth the effort?

I think it's probably worth the effort to add something to put rules for
these things in MAINTAINERS, it'd cover 90% of cases.  If you're sending
only one of a big series with a subject line that won't pattern match
that's a good way to get stuff dropped on the floor.

--oxour8c+zPVguRmP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXB3eAAoJELSic+t+oim96PgP/3uv47vH2aj625X/6GOgIOYm
D+9pH4cTBpGheD9Lnz3RqHDWU3KRmu8PN/+aZNioM4OJn3/hf9374Vk2shx004Vf
aUUhHR/qVNvYiNIXQBeeYJZASvK968oRQi7VbUPsVNmZ3LoLsd+/AzKTpgYFbn4g
VGSOg/FWSeTWSGOlJKivjwBEk1j/3m37rJb/s3N5/I6lJ4nvrjMyg8Z5ltFtlZvQ
IY4iWoaPydQA7hDsLFsnf9Dvpk+hhU6wYXyCLoZM9+33UttFUo9GYdWKaSxyI3XY
Cu8/OreH5aA+OwEMrWDJRuD29ZTAkI8XP5iLqkSsTKVIBmZsj6xSMUFrNkZIKZhN
zAiinq+k5ITPjsjkUfUoTmFW/QD2toHsEL3Z/mAv/jzK6Wj7Ukxjl2Q1YP5tsxDn
9K3RBO0jCdoYoHzn8WrM6st1OFzBJlCwJfc5C5q9FJQPcKgUEmpw0FPc0H9SsXQA
MH1mU4Hajk7Jr8PBFxIHDcQD5Z3issnGiSIYLI3DvC7ONMY2tQmSN3S7FL3QTMFQ
5Rf2ZXc3QqQe1+LrQ6LkZuym1JpiFshfqtBXv7QyAkr6hZhivEdFTPUCT+YCEXWH
VF6w/TRwFvtgCzjY4LQj4lsw6OnellnIKOSUpK4XnfVlXWlejkqRC0V1BH/8HZEg
jvn4UryGx6zkkG8tK4DR
=qa9t
-----END PGP SIGNATURE-----

--oxour8c+zPVguRmP--
