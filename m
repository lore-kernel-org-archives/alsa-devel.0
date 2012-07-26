From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/21] ASoC: dapm: If one widget fails,
 do not force all subsequent widgets to fail too
Date: Thu, 26 Jul 2012 12:54:51 +0100
Message-ID: <20120726115450.GE3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-7-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7353291128618116153=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A2D8265E8D
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 13:54:50 +0200 (CEST)
In-Reply-To: <1343298534-13611-7-git-send-email-lee.jones@linaro.org>
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


--===============7353291128618116153==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VZLKKa0PG5KXlQhV"
Content-Disposition: inline


--VZLKKa0PG5KXlQhV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 11:28:39AM +0100, Lee Jones wrote:

> If a list of widgets is provided and one of them fails to be added as
> a control, the present semantics fail all subsequent widgets. A better
> solution would be to only fail that widget, but pursue in attempting
> to add the rest of the list.

Why?

--VZLKKa0PG5KXlQhV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQETABAAoJEBus8iNuMP3dqxIQAJMqeSzER9BBBf6Z6Qbv/B9/
2mkXg3YL4l1AVrQ3nRdqfu765QxTIL1P82Eu+yJH3kQUOvvAoqDjjGCrmT3AEflE
DVK8dplcIiT1CrqMbk+ZLOhyzuPna0AwwgTJI85RM+py+9ppzk2V+PILk2H1Z5H5
YD9mLIlQV4vsxqDJAXSC485xtc6c+u5EAA8s4+9ZoCvbyUT2AtiTKxAV+sydAY4x
7RB57XfceusEnuQAcbWHnRy5e8/wp2yDJe2GX/Co+4QOuUN/BIo9trBQCQgQW3CD
LHlC/yQ5KIzqncEGfl4ymrm1ecBcja4AjqGBkxo+aEMNH0JFvG/hoKQv2dxwe+Gq
gSoIxx8k8fO9v6BWe04NRBFUV3+AieMlkviHWlRoao02j5RI9Nqys2iGpZn64qKN
QiD1gjBzBrSNJEpRuceMVYeWKwwB6nNOkmxxYTiK8NgIK8o8IOtfKhZFIINBTJFi
J06iPwsRwPBhL7Kqnka6RtQskr2f1Fc0SDEfhWgHTc1LYOVFH+swiNFmZ7H8YFt4
ibeHQYSCz65cP5hayIMIak78x0hZC+RkrR+b1TcVLfb069jFVHwqHFKSuTQYz/x9
2SWCTvJsYqmYxV49ofLPfLtBuM7igy836MNoLXPgjYsUSSuwDJBooaVgtNZlgyAk
FWtYPJZNvZVAksmAk32Y
=5/Sj
-----END PGP SIGNATURE-----

--VZLKKa0PG5KXlQhV--

--===============7353291128618116153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7353291128618116153==--
