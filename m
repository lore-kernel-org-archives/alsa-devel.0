From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hda-intel channels hibernate bug
Date: Wed, 15 Apr 2009 17:42:31 +0200
Message-ID: <1239810151.6981.5.camel@johannes.local>
References: <1238921730.3782.3.camel@johannes.local>
	<s5hocuz2xau.wl%tiwai@suse.de>
	<1239715639.22047.0.camel@johannes.local>
	<s5hd4bf2w27.wl%tiwai@suse.de>
	<1239716613.22047.2.camel@johannes.local>
	<s5h63h60zwf.wl%tiwai@suse.de> <1239809427.4809.7.camel@johannes.local>
	<s5hmyaiylkm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3379519261318789970=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 8855D244AA
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 17:43:04 +0200 (CEST)
In-Reply-To: <s5hmyaiylkm.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============3379519261318789970==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-sSR+ctjeE5hL7CVrR5V9"


--=-sSR+ctjeE5hL7CVrR5V9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-15 at 17:37 +0200, Takashi Iwai wrote:

> > Sorry... Well, I can't seem to record at all right now for some reason,
> > but here are a few things that are wrong:
> >  1) master mute has no effect (I think that actually worked before?)
>=20
> Do you mean that it has no effect on the playback volumes, or on the
> recording level?  The former is a bug, the latter not.
>=20
> >  2) the "Speaker" control has no effect (mute/unmute)
>=20
> Ditto.

Sorry -- playback on both points.

> >  3) need to set channel control to 6 to get sound at all
>=20
> So the pin setup used there don't match with the actual environment,
> apparently...

Yeah.

> >  4) speaker volume is line-out * pcm * master
> >  5) cannot automatically detect codec, need to load with model=3Dmbp3
>=20
> What happens exactly, if you load the module without model option?
> Note that "Unknown xxx" message is no error but an informational one.

It says
[ 1319.570055] hda_codec: Unknown model for ALC883, trying auto-probe from =
BIOS...

but then with the controls I get I cannot make it play any sound.

> > And the last time I could record sound it was all choppy and sounded
> > clipped.
>=20
> This might have been improved in the recent version.

Ok, I'll try harder to record something.

johannes

--=-sSR+ctjeE5hL7CVrR5V9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5gBlAAoJEKVg1VMiehFYfkkQAJ5RJNIh6UBdvA3wZ3hx5Eso
GPOF/T787EkI6VXcZ2IVBB83ljOzzX1jbvHZkF7tWlw84s9Zbsy5wzDXboyemKpH
Uh8G1bYoEIMrfwOCbQrcHF2O4SzsVWGOL3vvyQSWgQunX6UAHvIujxU1k2HkTusv
sj8Niv7PtOndMFBTv4oLkvsursdZD4R9/xiqARR6N8olwgVSBhmCzprM5KRYbuvL
asy9T3CYvoDyGW6vcjoUd/awOvtq1gaz7OjK+273BQ5O6yH5W7WGnnyEf6W0Ayut
YxA2auQaNlt5ACaWX3WeIQi3tSgimPJrElNYw1nSE43lA/CEqCmtOdw8Rt9xcpic
vUcZJKX5RZMEqDz+uo2jTclIOWZuUdiwhd2OabQr6ieesbfS6pjtbFiu2Rn906bQ
m/kqzJJ32RRX3p/b2ATXBjqE2nQdCIMwEE2P137ywvtwsp79gT8Ln6MQZDIEAi3W
Nl9CWIteV0A/BoNxQyNYcA7Xd0gmKol+uR/gXRs1ru91LyjLocNNZRMchs6mBPx9
oJculp7FwKgyKb7+anWJmrHg9KR+mhZ6qqf6M+JePMuiEhd3lTM1J9ykOij+I2Yi
AMlutVxmAVXzQV7fICxCdCCNUASmu7NLwaDSLQFBY4o7kQphkEigAqsUTdNxMSjH
YetuqZUsRKQeIlxhoZAZ
=wIA2
-----END PGP SIGNATURE-----

--=-sSR+ctjeE5hL7CVrR5V9--


--===============3379519261318789970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3379519261318789970==--
