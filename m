From: Pierre-Antoine Champin <pierre-antoine.champin@liris.cnrs.fr>
Subject: M-Audio Audiophile USB
Date: Mon, 22 Aug 2005 17:36:28 +0200
Message-ID: <4309F0FC.9090209@liris.cnrs.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCF2CBCB0411E35BD440E15F6"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bat710.univ-lyon1.fr (bat710.univ-lyon1.fr [134.214.88.10])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 78ACD21B
	for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2005 17:34:51 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org, alsa-user@alsa-projet.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCF2CBCB0411E35BD440E15F6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi alsa people,

I bought an M-Audio Audiophile USB external sound interface, but I have
some problems to make it work properly: when recording audio, the signal
I get is completely saturated. Googling around didn't help much, so my
question is:

- to alsa-user: is anyone owning such a card and having it work? If so,
what is your configuration?

- to alsa-devel: what is the known level of support for this card? if it
is known to work 100%, what may I be doing wrong? if not, how may I help
fix it (see below)?

I may have found the solution, though:
when I record a raw file with
  arecord -D hw:3 -t raw -c 2 -r 48000 -f S24_3BE >foo.raw
and play it with the same option, I get the saturated sound, as I wrote.
However, if I change the order of each 3-uple of bytes like that
    a,b,c -> c,a,b
and play the resulting file with the options above, it sounds good.

So I guess that the card has uses format S24_3BE for output, but *not*
for input; it uses instead some hybrid format, for which the conversion
to low endian would be:
    a,b,c -> b,a,c


Unfortunately, I'm not familiar enough with driver development to be
able to fix it right away, so I prefer to submit it on the list first.
I'm able to code, though, so with a few pointers, I may be able to do
it. I'm just not sure which is the most time consuming for a
knowledgeable developer: doing it or helping me into doing it ;)


 thanks in advance

  pA


PS: I'm using a Debian (testing) distriburion, with kernel 2.6.10
(I also tried with Agnula Demudi, based on 2.6.12)

--------------enigCF2CBCB0411E35BD440E15F6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDCfECmz/988yR4wERAj4nAJ9pFRPQMBFTpEt/0+dxY+hu8TnFvACghvWo
cHTAd2/cNLxRJhwkxClT/0s=
=bfvj
-----END PGP SIGNATURE-----

--------------enigCF2CBCB0411E35BD440E15F6--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
