From: "David E. Storey" <dave@tamos.net>
Subject: Re: Getting actual sample rate
Date: 11 Jun 2003 00:07:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055304472.600.11.camel@localhost>
References: <E19PpcQ-0007ZN-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GcNUbtF8ZxfmkaoqNw5U"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19PpcQ-0007ZN-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-GcNUbtF8ZxfmkaoqNw5U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-06-10 at 16:26, Paul Davis wrote:
> thomas's code works on the hdsp i think, and is easily adapted to the
> digi9652. he also has written totalmix for linux. i don't know why he
> hasn't released it yet. thomas?

that would be handy. I've successfully used ALSA and an HDSP to do in
ear monitor mixing for a band I run sound for. But I'm only guessing at:

a) converting "fader" levels to something logarithmic like db
b) converting fader levels to the 0-65535 exponential scale that the
hdsp uses, and
c) converting the 0-65535 back into fader levels

I've got some questions into one of the guys at RME that developed this
thing to see how they do it. Any insight would be excellent as I'm about
to plop down some cash on an ADI 8 Pro to expand out to 16 channels
through my HDSP... <wink,wink;nudge,nudge>

I've also successfully captured peak and RMS levels via the
snd_hwdep_ioctl() interface, but I'm a) unsure of how to convert that to
something graphical and b) how often to call the ioctl to display. (I'm
assuming that it's only as often as I want to refresh the levels which I
can easily do with a timer.)

d!

--=-GcNUbtF8ZxfmkaoqNw5U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+5qsY+5sC2muyxOMRAiZWAJ9LYpwMDynMQsI11EqRjVSrvHHMZQCeJg2p
Df5JEU/MKSfVQDj8htewlKs=
=hRTd
-----END PGP SIGNATURE-----

--=-GcNUbtF8ZxfmkaoqNw5U--



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
