From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: CS4205 -- personal conclusion: avoid these laptops (for now)...
Date: Mon, 6 May 2002 18:11:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020506221155.GA5941@shaftnet.org>
References: <000001c1f547$54e8f180$ac1f830a@ico>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <000001c1f547$54e8f180$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2002 at 05:45:24PM -0400, Ivica Bukvic wrote:
> ALSA -- works (sort of), it reports 4 modprobe errors using intel8x0
> driver prior to firing-up soundcard, resulting in 4 loud "clicks." It
> can play only one stream at the time, so it does not provide even basic
> mixing capabilities (i.e. multiple Csound or RTcmix streams, and/or
> multiple apps). Even Maestro 3i had 2 streams going. There are also some
> buffering issues which are hard to pinpoint (sometimes sound clips more
> when the buffer is larger, than when it's smaller).

Now let's be fair to the ALSA driver -- the fault here is the hardware,
not the driver.  The intel ICH sound design only supports three
simultaneous channels, one playback, one record, and one dedicated mic
channel.

Any "multiple open" would have to be performed and mixed by the
driver/library.  Unlike, say, the SBLive which is capable of something
like 64 simultaneous playback channels in hardware; fully routed and
DSPed, even.

> They should not be allowed to advertise their laptops as Linux friendly
> when they are not entirely (or not enough soundwise at least).

Also to be fair, "good" sound is still not a priority in laptops.   Much
like 3D accelleration wasn't until about a year ago.  Within another
year, I imagine we'll see decent multi-channel sound in laptops become
commonplace.

While I admit the ICH driver still has much work remaining, no matter
how good the driver is the underlying hardware still sucks.

 - Pizza
--=20
Solomon Peachy                                    pizzaATfucktheusers.org
I ain't broke, but I'm badly bent.                           ICQ# 1318344
Patience comes to those who wait.
    ...It's not "Beanbag Love", it's a "Transanimate Relationship"...

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE81v+rPuLgii2759ARAntIAJwKuROoOlAikmHoJ+TC8xBwiyQ67QCg3h06
f2xhcXouzqEVTkeuekKC//4=
=9+Ky
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
