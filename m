From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [PATCH] port pcxhr driver do devres
Date: Wed, 15 Oct 2008 23:33:59 +0200
Message-ID: <200810152334.00382.eike-kernel@sf-tec.de>
References: <200809211731.58934.eike-kernel@sf-tec.de>
	<s5hprmvumcb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4357024588008317718=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sf-mail.de (mail.sf-mail.de [62.27.20.61])
	by alsa0.perex.cz (Postfix) with ESMTP id C78E4244C5
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 23:36:27 +0200 (CEST)
In-Reply-To: <s5hprmvumcb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============4357024588008317718==
Content-Type: multipart/signed;
  boundary="nextPart9371899.8dXJOlEpa3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart9371899.8dXJOlEpa3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Takashi Iwai wrote:
> At Sun, 21 Sep 2008 17:31:39 +0200,
>
> Rolf Eike Beer wrote:
> > Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
> >
> > ---
> > I was a bit bored and ported the pcxhr driver to use devres to manage
> > it's IRQ and PCI resources. This is completely untested as I don't have
> > such a card but you might find it useful nevertheless.
>
> Thanks for the patch.
>
> I think it's good to do this kind of clean ups, but I'd like to make
> sure that it works properly after the change.
>
> Any other sound driver to test by yourself?

Sorry for the delay. No, nothing around at the moment, especially no time.

Greetings,

Eike

--nextPart9371899.8dXJOlEpa3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkj2YcgACgkQXKSJPmm5/E5nggCeL61UYzNPOyaISYrejY+B5W7b
KAEAn34soRbl6eXkVuxtd99QZmGYS9fX
=L9tA
-----END PGP SIGNATURE-----

--nextPart9371899.8dXJOlEpa3--

--===============4357024588008317718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4357024588008317718==--
