From: Bob McElrath <bob+alsa-devel@mcelrath.org>
Subject: Re: Re: Alsa-devel digest, Vol 1 #810 - 3 msgs
Date: Tue, 29 Oct 2002 11:09:14 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021029170914.GE1046@draal.physics.wisc.edu>
References: <E186QHN-0002BE-00@usw-sf-list2.sourceforge.net> <20021029163629.GD1046@draal.physics.wisc.edu> <20021029164403.GC776@porky>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20021029164403.GC776@porky>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Peter Heatwole [peter599@gotnet.net] wrote:
> On 2002.10.29 08:36 Bob McElrath wrote:
> >I don't see a debug setting on the modules snd-cs46xx or snd -- is
> >this a compile time setting?
>=20
>    Yes, you set this when you configure the package.  Use the configure
> option "--with-debug=3Ddetect" for the most verbose debugging output.
>=20
>=20
> >What is the easy way to test playing to the rear pcm channel?
>=20
> The easy way:  aplay -Dhw:0,1 test.wav

Seems to work well.  The relevant mixer settings are PCM1 and Surround1
(both of which must be turned up and unmuted.  However it doesn't seem
to deal well with odd rates:

(0)<mcelrath@draal:/home/mcelrath> aplay -Dhw:0,1 /usr/share/sounds/zipper.=
wav=20
Playing WAVE '/usr/share/sounds/zipper.wav' : Unsigned 8 bit, Rate 11025 Hz=
, Mono
aplay: pcm_write:968: write error: Input/output error

>    Just don't forget to unmute and raise the volume for the rear-output.
> Also, if you wish to output directly to SPDIF, use:  "aplay -Dhw:0,2".

Unfortunately I don't have any hardware which can deal with SPDIF
(except my Marvel TV card which only has an output).

> Thanks for testing. ;-)

No prob.

> HTH,

Have The Ham?

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

    "The surest way to corrupt a youth is to instruct him to hold in higher
    esteem those who think alike than those who think differently."=20
        -- Nietzsche

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2+wLoACgkQjwioWRGe9K2eFACg3Pt3X7q9uLGW9a1U9QxjH9pF
UyUAn27VVxrNje2PRWmppAa/aq9jXscs
=c8yw
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
