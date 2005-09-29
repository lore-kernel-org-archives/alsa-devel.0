From: Stl <stlman@poczta.fm>
Subject: Re: Audigy2 renamed, grrr...
Date: Thu, 29 Sep 2005 16:39:00 +0200
Message-ID: <433BFC84.2080504@poczta.fm>
References: <4338EF9A.1080906@poczta.fm> <1127824232.43393b683dff9@domainfactory-webmail.de> <433985F2.6000708@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5DF38E1A285833E7288932FF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <433985F2.6000708@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5DF38E1A285833E7288932FF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

James Courtier-Dutton wrote:
> Clemens Ladisch wrote:
>=20
>> Stl wrote:
>>
>>> Why the hell, Audigy2's name in alsa driver changes with every
>>> kernel version?
[...]
>>> Who is such a lunatic to revert it once every two months,
>> I doubt that jcd's behaviour is affected by moon phases.
>> Besides, moon phases aren't two months long.
>>
>>> from Audigy 2 ZS to SB350, from SB350 back to Audigy2
>>> (why not ZS? I've got ZS!).
> I didn't change anything. What's the real problem here?

After I had upgraded the kernel (2.6.12 to 2.6.13), alsactl (1.0.8) has
started to complain that there is no soundcard SB0350 so I had to
manually edit /etc/asound.state and change (AFAIR revert back)
state.SB0350 to state.Audigy2. After I did that alsactl still moans:

/usr/sbin/alsactl: set_control:930: warning: name mismatch (Audigy SPDIF
Output Sample Rate/HD Analog Front Playback Volume) for control #219
/usr/sbin/alsactl: set_control:1025: bad control.219.value type

/proc/asound/cards:
0 [Audigy2        ]: Audigy2 - Audigy 2 ZS [SB0350]
                     Audigy 2 ZS [SB0350] (rev.4, serial:0x20021102) at
0x7c40, irq 11


--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig5DF38E1A285833E7288932FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDO/yKNdzY8sm9K9wRAnxQAJ91VdKNmAWQs2dd9Z2IHx6fFAIuoACfWFi2
oVwAMnSQNMmIGgqjdtumuD0=
=86L7
-----END PGP SIGNATURE-----

--------------enig5DF38E1A285833E7288932FF--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
