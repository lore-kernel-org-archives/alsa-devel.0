From: Michael Gerdau <mgerdau@tiscali.de>
Subject: Re: HDA - Add more support for Dell systems.
Date: Tue, 21 Aug 2007 10:51:12 +0200
Message-ID: <200708211051.34134.mgerdau@tiscali.de>
References: <1187553279.4189.145.camel@razman.gruemaster.com>
	<1187619448.4189.193.camel@razman.gruemaster.com>
	<s5htzqul1hk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2105884902744865731=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server021.webpack.hosteurope.de
	(server021.webpack.hosteurope.de [80.237.130.29])
	by alsa0.perex.cz (Postfix) with ESMTP id D49E8103819
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Aug 2007 10:51:34 +0200 (CEST)
In-Reply-To: <s5htzqul1hk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--===============2105884902744865731==
Content-Type: multipart/signed;
  boundary="nextPart2811653.aYFLq5KoYp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2811653.aYFLq5KoYp
Content-Type: multipart/mixed;
  boundary="Boundary-01=_BeqyGuNsnu+7AjV"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_BeqyGuNsnu+7AjV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> > I did.  It worked yesterday according to Michael Gerdau, but apparently=
 it
> > doesn't today.
>=20
> Well, that's what I wondered.
>=20
> Michael, could you check the default pincfg entries in
> /proc/asound/card0/codec#* whether they really match with the values
> in patch_sigmatel.c?

Ok, took me some more time (didn't want to test while almost asleep...)

/proc/asound/card0/codec#* _do_ reflect the pincfg entries as of
patch_sigmatel.c

I also once again have my sound working with both Dell-XPS.patch (the
one I originally tested) as well as the later version Dell.patch. I
also have a working LFE control with both patches.

I have not yet a clear understanding why I did not have sound and LFE
yesterday. However the thing that's different is that yesterday morning
I booted into a kernel with the patched alsa and did no other alsa mod
unload/load until I reverted the patch (when I got back my sound).

When doing my initial test as well as todays test I booted into the
pristine hg20070818 (or hg20070817 back then) driver and loaded the
patched modules via '/etc/init.d/alsasound restart'.

I can't reboot the machine until about 16:00 today to check whether
booting into the patched driver does make a difference or not but I
will do so this afternoon and report my results (of course this could
be a red hering).

=46YI I've attached /proc/asound/card0/codec#* to this mail in case that
is of interest.

Best,
Michael
=2D-=20
 Vote against SPAM - see http://www.politik-digital.de/spam/
 !tagline
 Michael Gerdau       email: mgerdau@tiscali.de
 GPG-keys available on request or at public keyserver

--Boundary-01=_BeqyGuNsnu+7AjV
Content-Type: application/x-tbz;
  name="codecs.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="codecs.tar.bz2"

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
CP4u5IpwoSC1ODMw

--Boundary-01=_BeqyGuNsnu+7AjV--

--nextPart2811653.aYFLq5KoYp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD4DBQBGyqeWUYYhyuxDQc4RAl5XAJ9XoNCOrBjEfLgFQTjMOvajdwtODwCYibsH
cqZi4LwODoEKpxG/MRnzlA==
=vzOK
-----END PGP SIGNATURE-----

--nextPart2811653.aYFLq5KoYp--

--===============2105884902744865731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2105884902744865731==--
