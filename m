From: "David E. Storey" <dave@tamos.net>
Subject: Re: Quick question
Date: 03 Jun 2003 09:25:07 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054646707.539.20.camel@localhost>
References: <1054584080.17509.30.camel@dave.sipquest.com>
	 <1054645547.20856.8.camel@dave.sipquest.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D6mG2mMiJphj+QcWY8j2"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1054645547.20856.8.camel@dave.sipquest.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Stuart <dave@sipquest.com>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-D6mG2mMiJphj+QcWY8j2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Well, I would have answered your question, but I personally don't have
the answers you seek. For starters, I wouldn't use alsa for doing such
things. I'd use Jack. <http://jackit.sf.net/> It's so much more
flexible, powerful and easier to code for than straight alsa.

Having said that, your question involved using TWO devices, which I
believe jack doesn't really support unless you're "bonding" them a la
your .asoundrc file. (and even then, you'd really want to syncronize
their clocks which most, if not all, consumer products don't support.)
Assuming you don't care about clock synchronization, you could follow
the examples at <http://www.suse.de/~mana/alsa090_howto.html>. Just open
up one device for capture and the other for playback. When you receive
data from one, pass it to the other.

(and reading Paul's recent post on jack, apparently you can do what you
want to do with jack.)

d!

On Tue, 2003-06-03 at 09:05, David Stuart wrote:
> Apparently the ALSA community is too busy to answer my little questions,
> this is the sadly the 3rd or 4th time I has posted to this list with no
> answer. :(
>=20
> I don't think my question is too difficult. All I'm asking for is a
> little help! Either a small snippet or a pointer to some other
> information.. Maybe my question is too newbie-ish, but you can't develop
> new experts without said experts being newbies at one time.
>=20
>=20
> On Mon, 2003-06-02 at 16:01, David Stuart wrote:
> > Does anyone have a short example of capturing from one device and doing
> > a playback (of the captured data) on another?

--=-D6mG2mMiJphj+QcWY8j2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+3KGz+5sC2muyxOMRAqxeAJ9chAX47y0z9bdnM54Bw0+l5jVqDACfdgzM
jNjB2GjBzcsb9Pu7NqQ0xN4=
=bCC2
-----END PGP SIGNATURE-----

--=-D6mG2mMiJphj+QcWY8j2--



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
