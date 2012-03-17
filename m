From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Sat, 17 Mar 2012 11:41:50 +0000
Message-ID: <20120317114149.GM3158@opensource.wolfsonmicro.com>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
	<20120315175310.GR3138@opensource.wolfsonmicro.com>
	<CA+7tXijgsT3uitVa-=VLmKY2ubQpgff0hkKjA5jz6QCFp9_PiA@mail.gmail.com>
	<20120316192513.GJ3158@opensource.wolfsonmicro.com>
	<4F639BCC.2050703@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7784701333017712702=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9B7CE103E89
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 12:41:53 +0100 (CET)
In-Reply-To: <4F639BCC.2050703@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ramesh Babu <ramesh.babu@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Trent Piepho <tpiepho@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7784701333017712702==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AQNmCumFClRcGgHG"
Content-Disposition: inline


--AQNmCumFClRcGgHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2012 at 09:00:12PM +0100, Lars-Peter Clausen wrote:

> So I'm wondering if we can make it easier for userspace to detect that the
> constraints have changed and it may retry with other parameters? E.g. return a
> special error code in such a case.

I think an event would be better; userspace or possibly the in kernel
core can turn it into an error code if it wants to but from a driver
point of view the event seems simpler.  If the drivers try to do an
error code it has to keep track of which applications saw what and if
they're affected by a given change which is more trouble than it's
worth.

Though to be honest the race is almost always an application fighting
with itself over bidirectional audio so practically the problem isn't
often serious.

--AQNmCumFClRcGgHG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZHh2AAoJEBus8iNuMP3dFmkP/1ET3TYGDl1t8nyNHmJCT+hI
z+iD5Pac0PFS9lqla4WYYzB6bMmNKEviAq475SAPKeUKuDTa1flmOk1x0Oy5N7bm
aps5P2EKJb5CFMEwrCdpdyECsRrLo/O10/nTQL/Y+XpORa/QUgNOK3IP23efWjrZ
sREn1GsfjiALwsXRheAkKCxyaV2XTR+pKRey27fF2uR05Kl4kGCJyUVI9HuirKMO
rt5TuLbPKcRbAFh7B27AvcmW5EHE289fzPoY0SYu481VsiTcYJIAFaFb3EfjDjzR
+fpk5yXYPUFe1+SAzZQmx4/DQsGvQNQw/AQsqqtT3Bind5VG4A5kydDwAACqaB0p
2PHAUfUilSXwTxGlIC1SEnHfUwly2GmXYqlmVsGkDIyDr6BuRJS5ybtXHDlbjUWT
XbrbZU87ndhVgTG7KnFYvr6R8HlyrKBuWtwGh7y/qVgN+NF8xYEJp5lfC3pUhtFz
I0FlUlTCFjjWno3Xl0YTPWzlRmkYdPz/symNB226HOX4aDyX57y7loM4B+2GvMxj
mO5JPtEx9NLytpfs52/JwwlbJ6baGEzb6UfCI9nVRyOrV217T5fmG/Royipb0fdQ
faKD49AA5j5SCkJEFobJdtdUDmeEYB2m0byDCXbf9sF9sskXDtnSCLHutX2/nY3o
zM5TTW35Q2yjQR7QTYAB
=jLn6
-----END PGP SIGNATURE-----

--AQNmCumFClRcGgHG--

--===============7784701333017712702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7784701333017712702==--
