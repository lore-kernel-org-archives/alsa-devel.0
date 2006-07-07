From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa: g5 tas codec problems
Date: Fri, 07 Jul 2006 10:03:34 +0200
Message-ID: <1152259414.15068.12.camel@localhost>
References: <1152258426.9862.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1576486037=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 44287273
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 10:03:49 +0200 (MEST)
In-Reply-To: <1152258426.9862.44.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1576486037==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-yGTEhSNS8rLJjvRPRGVW"


--=-yGTEhSNS8rLJjvRPRGVW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-07 at 17:47 +1000, Benjamin Herrenschmidt wrote:
> Ok, so now I have it working on the G5 :)

Great :)
Powerbook woke itself an hour ago, no idea why, sorry for confusing you
on irc.

>  - Maybe it's me or maybe it's just too complicated, but I haven't quite
> grasped the whole interaction between the soundbus,i2sbus,fabric and
> codecs... especially initialisation ordering. It would be nice if we
> could spend some time going through that and simplifying :) It leads to
> at least one of the problems

Yeah, well... I sorta know.

>  - The patch fixes a couple of nits related to having the modules
> built-in: soundbus must really be a subsys_initcall() so it's
> initialized before anybody else, and I've put the soundbus/ dir before
> the codecs in the link order because the TAS is unhappy if loaded before
> i2s (see below)

Right.

>  - The TAS is a nasty beast. It needs the i2s clocks enabled or it goes
> bunk... That's the problem with the G5. I've added a clock notifier and
> reset it completely when the clocks come back, that's what fixes the G5
> sound (looks like it loses state somewhat when not clocked). It would be
> nice to streamline/cleanup some of the TAS handling, maybe with register
> shadows like darwin or just with proper state variables to re-consitute
> the whole thing and have a "fast mode" load since we need to do it so
> often

Ahrg

>  - Because of the above, starting to play a sound 1- takes some time to
> init things and 2- clacks (setting the mutes on TAS before losing clocks
> isn't enough, I think the fact that it goes bonk makes it parasite the
> analog outputs). We need to also mute the amps around that. I haven't
> quite figured how to do that from i2sbus though :) Also, we should try
> (if not already the case) to cache our clock/i2s state so that
> subsequent prepare() don't try to change things that are already ok.
> That way we avoid having to blast the codec each time. But right now,
> the important thing is to add mutes. People with external amplifiers
> will really not like those clacs...

Right. The way I did that with the onyx is that I told the GPIOs to mute
all amps from the clock switch callback.

I see you added DRC too, thanks :) I'll take a closer look after
breakfast ;)

johannes

--=-yGTEhSNS8rLJjvRPRGVW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARK4VVKVg1VMiehFYAQK5cQ/+Ksh1XpSSrbOn8J1ehLoPiWV+Jzty+wb+
zMtOYpcZoVXpNsY4qMYT9Ro5oFXB0TVVLIYZ2Rg2swA5c8Yq7Z7OY/PgeSM9WLFU
K43pVd+1LfM4lOAo8OBE7aFPPiuS2BZxfyQuJOmoqhrcrTDxzm9OkuhNpCADYkVj
1xQyKfGn8Sju8tbZk5H0iPB2bCfz/dSSxOWQqsKJFmfj1YbedWxjqbH24Ntv9s/o
0FvJLLTU4SYW+mIOv9rWX4G7RM9zqVGakjQ9HgGrDnLYwkbQKh+60tIeD11pazcj
gvBQCJ0gw/mBv+DopCiYATYORfUJnnDoHI+rPeWzjwwHJgVmTBb3vnqTaxw1Kh2f
vZyOORzLiy9taZ7nP51bumA2RSigtr36fDQdvhjHlzgvj++6TsYcl6bMIDAR91M2
/i3mEKz+l2AzqbwRUdynH7rFXF8OErtuvWqN7qCIWYPBDZVpEvujspc6ivx1MtMv
TvY7DyaS8T318AcN7PQmoLvLoPWVL6oh53BRuV5VRsDQ+t9h5W3rQ9/8yKPaHcSh
8LRlPpAL1xKVob/NGak109jkjVqg8fvPXyvhvRYi4oC+/WjVhUNE/A5x43Q9sC1F
aIDBRqjEXaKpX8tusXsoL3fW+o0Bdub4czSP78Aha1jSx5tPwCE3GkHPUForR3hs
vnmEAsuzPvU=
=btT2
-----END PGP SIGNATURE-----

--=-yGTEhSNS8rLJjvRPRGVW--



--===============1576486037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1576486037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1576486037==--
