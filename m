From: Michael Gerdau <mgd@technosis.de>
Subject: Re:
	=?iso-8859-1?q?=5BRegression=5D_snd-hda-intel_no_lon?=
	=?iso-8859-1?q?ger_loads_as_of=09alsa-driver-hg20070728?=
Date: Fri, 10 Aug 2007 18:33:14 +0200
Message-ID: <200708101833.26370.mgd@technosis.de>
References: <200707302023.12091.mgd@technosis.de>
	<200708101458.00591.mgd@technosis.de>
	<s5hhcn7cv4p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6694558600257244203=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server021.webpack.hosteurope.de
	(server021.webpack.hosteurope.de [80.237.130.29])
	by alsa0.perex.cz (Postfix) with ESMTP id 93FA02441D
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 18:33:28 +0200 (CEST)
In-Reply-To: <s5hhcn7cv4p.wl%tiwai@suse.de>
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

--===============6694558600257244203==
Content-Type: multipart/signed;
  boundary="nextPart1723469.6oKMsMrRE4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1723469.6oKMsMrRE4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> >   ./configure --with-sequencer=3Dyes --with-debug=3Ddetect --with-cards=
=3Dhda-intel,usb-audio --with-card-options=3Dseq-rtctimer-default
> >=20
> > This works for alsa-driver-hg20070727 but does not work for any of the
> > later versions I tried, including alsa-driver-hg20070810
>=20
> The reason is that you are passing wrong configure options.
>=20
> With --with-card-options, you have to give _all_ necessary options.

I'm not disputing that statement. However I'd like point out this is
a change in behaviour of configure which seems to have occured
between hg20070727 and hg20070728. It also is a change w/r to how the
current released version behaves.

> When once this option is passed, it resets the all once.
> In the case of hda-intel, the following options should be passed in
> addition appropriately: hda-hwdep, hda-codec-realtek,
> hda-codec-analog, hda-codec-sigmatel, hda-codec-via,
> hda-codec-atihdmi, hda-codec-conexant, hda-codec-cmedia,
> hda-codec-si3054, hda-generic.
> Yeah, there are lots of them.  So, simply stop passing
> --with-card-options=3D... if you are not sure what you're doing :)
> Then all options are enabled as default.

I'm happy to stop using --with-card-options=3D...
I only added it because at some point in the past it had been required
for adding seq-rtctimer-default.

Assuming that's no longer needed I will remove it from my build scripts.

Best,
Michael
=2D-=20
 Technosis GmbH, Gesch=E4ftsf=FChrer: Heiko Gerdau, Tobias Dittmar
 Sitz Hamburg; HRB 89145 Amtsgericht Hamburg
 Vote against SPAM - see http://www.politik-digital.de/spam/
 Michael Gerdau       email: mgd@technosis.de
 GPG-keys available on request or at public keyserver

--nextPart1723469.6oKMsMrRE4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGvJNWUYYhyuxDQc4RAh/tAJ4j4gBSxA24bFXd8aqPq8BRuk7sbgCfctk0
Pg9zvm7FXV4ie0k9EeztgyM=
=+SI+
-----END PGP SIGNATURE-----

--nextPart1723469.6oKMsMrRE4--

--===============6694558600257244203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6694558600257244203==--
