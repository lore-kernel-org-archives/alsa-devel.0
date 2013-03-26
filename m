From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC: soc-compress: Cancel delayed
 power down if needed
Date: Tue, 26 Mar 2013 17:51:50 +0000
Message-ID: <20130326175149.GI18316@opensource.wolfsonmicro.com>
References: <1359128299-17161-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130126085234.GB30594@opensource.wolfsonmicro.com>
 <20130308165252.GA22868@opensource.wolfsonmicro.com>
 <20130311092526.GA2141@opensource.wolfsonmicro.com>
 <20130320102544.GK28775@opensource.wolfsonmicro.com>
 <20130322085040.GE2141@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5829655141820159800=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 56D492650FA
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 18:51:52 +0100 (CET)
In-Reply-To: <20130322085040.GE2141@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, vinod.koul@linux.intel.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5829655141820159800==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Iovxle6z3WGVZjcj"
Content-Disposition: inline


--Iovxle6z3WGVZjcj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2013 at 08:50:40AM +0000, Charles Keepax wrote:
> When a new stream is being opened it is necessary to cancel any delayed
> power down of the audio.

I was going to apply this but the patch seems to be corrupted in some
way so git am gets upset with it.  I can't spot any errors visually...

--Iovxle6z3WGVZjcj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUeAvAAoJELSic+t+oim9R+oP/1JSCkWHVrXbAwfIeHx9rmV6
JJY5gykwTrUsoX8XcfOD413UOr03Poj5NAkcVPUn56LGYuLuwIT5iJVEPUb6aV5Q
eQcCPQxV7VbpK+c1Or+qyS8J4K+AJyLnYI0tMc095bFskYad2dVIH5du0qR2vcYy
OI7rVsteWlUvBmGYeh1mXKI1vj6DHHfQkhAsyFG6/2lFvebmDmyXH+lMU6c4Ni6C
CM7J5BA36dwSmTTfTeJo3gYIJJc4lYkbidxfq3Osg3V2LVgbYjM0nLRpoyR4NeRy
Js3hCp+dElPIHNDYsX0MmNxnFjRnmgzXjIjxvx5ouWFa7C/NYY4ra+WdBA6DpVGr
d0AUSPyNpzh2yEdCgSccoGHz1K1sqJ5MIbJ8+JiqL1pmyE/DeN09eNPS/LdgONiO
4h/E28Awn9cvvGvZK6asOzBAsjGW1ctwC0CDNJIb2y30lS/clHSWUvUVmj1D+wk/
K839bhP473kUNJywHmICgbM3g4heI/ShAJ+bG2RLpbMbap/9xHslWs2VnorjfIwL
xVUu4jaGO2FHKyCRyYbM+q5Ems03sKBEBlPZh8AAM6HEeVT0f84NOMDbnlt786+y
PhFH3hO1tC63ONZa344VVEXDccmjwBSulz3us2TlkeMuG5J5Nre/59N5Hb1xjSIQ
iLBsZ7NhjdGF+i3dPveP
=Imig
-----END PGP SIGNATURE-----

--Iovxle6z3WGVZjcj--

--===============5829655141820159800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5829655141820159800==--
