From: Mark Brown <broonie@kernel.org>
Subject: Re: tlv320aic32x4 Codec ADC and DAC must shutdown to
 alter clocks
Date: Thu, 13 Mar 2014 14:04:10 +0000
Message-ID: <20140313140410.GV366@sirena.org.uk>
References: <53207878.2060107@topic.nl> <20140312233137.GB28112@sirena.org.uk>
 <532159A5.20200@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2642000433256447883=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A13C22651F1
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 15:04:21 +0100 (CET)
In-Reply-To: <532159A5.20200@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============2642000433256447883==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3a/Z8KDuKqDOIvAo"
Content-Disposition: inline


--3a/Z8KDuKqDOIvAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2014 at 08:09:25AM +0100, Mike Looijmans wrote:
> On 03/13/2014 12:31 AM, Mark Brown wrote:

> >As a first order fix the driver should just refuse to reconfigure if the
> >clocks are active.

> Which would result in the driver often failing to work and the user having
> no clue why.

Print an error message.

> >The big problem with shutting down is disruption to other activity - if
> >there's something going on using the clocks.  For some devices that
> >don't have long startup times ignore_pmdow_time may help a lot.

> The bias level can remain where it is, it's just the DACSETUP or ADCSETUP
> bits that need toggling. They're independent, so only the affected parts
> need to stop. Using ignore_pmdow_time would result in the codec going to a
> lower bias state, and that is not what should happen here. Restarting the
> ADC or DAC is just a matter of milliseconds, but a complete power-down wi=
ll
> result in reference voltage instability and capacitors recharging, and it
> may take several minutes for the system to completely recover from that.

*Any* glitch in an active digital audio path will be noticable to users,=20

If you're taking several minutes to do a bias level transition there's
something seriously wrong with either the hardware or with the way it's
being managed by the driver.

> I'm mostly asking to think about the "big picture" here. As a generic cas=
e,
> not specific to this codec.

The general solution here is essentially don't do that; if the hardware
is fragile on reconfiguration you will tend to end up hitting cases
where trying to do a reconfiguration will glitch or fail so the sound
server will generally fix the configuration and handle things in
software.  Otherwise pmdown_time is the general solution for modern
devices with quick startup/shutdown times, older devices probably need
some custom hacks.

--3a/Z8KDuKqDOIvAo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIbrWAAoJELSic+t+oim91YgQAII5w1AUUPT6W8S02ucFa0Vt
qVEJroLbtwjTqA5RfdttIf/YdNqebAUjxtw9vHvr9zpTZyCJwGygNREgviZaL1/P
c+lSVoYYHbuM4Wky1smnfjCdwrW229M8U0xzXbQYsz7jvb5P7EZ8AS4NKzXN/zvE
XoP6PSCc7V/s20PjTkz60gzPsqIVTdQzNQUc8EG/VAh/8bDrKwzqsOj15zbmclQ9
McqpannhHK7HMWOC12Fx49JwIOOrmpL8zs0dotyFwLoOl+xedMR2oFJQEgaJEuRl
XFFO9mKDjxcY5llrs2uAh2zi22Y3dk7kcmt9AJH5TyJfxlAdsJPk5AhmsVTJglQx
r2Q3Iox8rd5I5+do7e1iCNd1XUE92ifmXeRXQLV+SLrXSxbEhCqWcDR1qB9hPtHo
kSIGadcPkYbCCHxpb2SfXJqHcoU/LyHrg+JfawHOrfH0QV0D2A8QnLwyjXwzzAcc
4NV3+Ht4rwOwlijn0nwnciwlp2it85cbm1AelsxcoClt/Y2IsaQGH6pXhj/ellvq
IkDFry1T1DtfbTmnCEvX8ae9gIlb9H8dNjkAXziLPlTtXprFKudLP5Z2hWF7kk7r
8atHBmWA8AvSdlAuXTgR3Rg+Vm+wLwh0pfx1OBULe9KXsxLSgOYDeL9Hdi+tB21Y
t/a9liKnlaJ/53nknO+8
=DCDH
-----END PGP SIGNATURE-----

--3a/Z8KDuKqDOIvAo--

--===============2642000433256447883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2642000433256447883==--
