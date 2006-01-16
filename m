From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: [Alsa-devel] Re: Real-world reports on two Delta 1010LTs/ice1712 synched?
Date: Mon, 16 Jan 2006 19:56:52 +0200
Message-ID: <20060116175652.GM28738@edu.joroinen.fi>
References: <20051224124823.GA4183@localhost.localdomain> <20051224144548.GA4306@localhost.localdomain> <20051224165610.GA4484@localhost.localdomain> <43AE9FA6.2020207@nostar.net> <20051226130327.GA4763@localhost.localdomain> <43B059A3.2050302@nostar.net> <20051227000428.GA3805@localhost.localdomain> <43B0A83F.1040907@nostar.net> <20051227130029.GB3770@localhost.localdomain> <43B1A8FA.8080408@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <jackit-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <43B1A8FA.8080408@nostar.net>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Doug McLain <doug@nostar.net>
Cc: John Rigg <j@sound-man.co.uk>, alsa-devel@lists.sourceforge.net, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 27, 2005 at 03:50:02PM -0500, Doug McLain wrote:
>=20
> >
> >With 2.6.14 or later kernel, starting envy24control (from=20
> >alsa-tools-1.0.10)
> >from xterm resulted in a slew of error messages saying "Unable to dete=
rmine
> >word clock status" scrolling off the xterm. The patch fixed that. Mayb=
e=20
> >that
> >only happens with the 1010 not the 1010LT. It's possible that with the=
=20
> >broken
> >word clock on the 1010LT it wasn't even trying to determine word clock
> >status so it didn't trigger the bug.
> >
> >John
>=20
> I asked that before I started studying the mixer and driver code=20
> closely.  I now have a good understanding of what the patch does, and=20
> why the 1010LT isnt working.  I also don't need any tests done by anyon=
e=20
> that I was asking for.
>=20
> It looks like the driver is the root of the problem.  There doesnt=20
> appear to currently be any facility provided for the 1010LT to set and=20
> check word clock as the master clock source, and SPDIF In only works by=
=20
> accident.
>=20
> #define ICE1712_DELTA_1010LT_WORDCLOCK 0x80	/* sample clock source: 0 =3D=
=20
> Word Clock Input, 1 =3D S/PDIF Input ??? */
>=20
> Doesn't appear to be correct, as SPDIF Input works wether I send a 1 or=
=20
> a 0 to the word_clock_sync snd_ctl_elem.  I'm going to keep plugging=20
> away at this when I get time to get back on it. For now, here's a patch=
=20
> that should fix the problem of having to press spdif before word clock.=
=20
>  If it does work for you on the regular 1010, then the comments for=20
> both the 1010 and 1010lt are backwards (where 0 =3D word clock and 1 =3D=
 spdif).
>=20

Doug,=20

Have you found out anything?=20

- Pasi K=E4rkk=E4inen



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
