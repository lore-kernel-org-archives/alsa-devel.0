From: Martin Herren <sputnik@on-the-web.ch>
Subject: Re: available sampling rate detection
Date: Wed, 12 Feb 2003 19:05:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030212190559.2fb5399a.sputnik@on-the-web.ch>
References: <20030211085359.24a40185.sputnik@on-the-web.ch>
	<1044955585.1415.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.q5'5GtGm6uEb0b"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1044955585.1415.39.camel@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=.q5'5GtGm6uEb0b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2003 10:26:25 +0100
Patrice Tisserand <Patrice.Tisserand@ircam.fr> wrote:

> On Tue, 2003-02-11 at 08:53, Martin Herren wrote:
> [..]
> > An additional question, what is the correct way to find out all existing cards/buses on a system ? Currently we scan /proc/asound/card?/ for all pcmX[cp]. Is there a better way to do it ?
> > 
> I think you case use a loop with snd_card_next
> 
> from alsa-lib/src/control/card.c
>  /**
>  * \brief Try to determine the next card.
>  * \param rcard pointer to card number
>  * \result zero if success, otherwise a negative error code
>  *
>  * Tries to determine the next card from given card number.
>  * If card number is -1, then the first available card is
>  * returned. If the result card number is -1, no more cards
>  * are available.
>  */
> int snd_card_next(int *rcard)

thanks, i didn't have time to test it, but there seems to several interesting functions which could be what we need.

thanks to Takashi too... next time i'll try to read the source for such a question ;-)

/Martin

-- 
Martin Herren

Protux - A Free Professional Audio Tool for GNU/Linux:
-> http://www.nongnu.org/protux/
Open your Windows - Free your Mind - Enjoy:
->http://gnuwin.epfl.ch


--=.q5'5GtGm6uEb0b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+So0MENZb8plGFLQRAtsYAJ9SUblft6p1KX1wBCXJ0nBBZfCcWQCgjg0B
ZRyTgh54p3FyoOIvGRfOQc4=
=q7Kr
-----END PGP SIGNATURE-----

--=.q5'5GtGm6uEb0b--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
