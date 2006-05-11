From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: alsamixer foo
Date: Thu, 11 May 2006 16:30:24 +0200
Message-ID: <1147357824.9630.41.camel@johannes>
References: <1146822715.1137.59.camel@localhost>
	 <s5hbqu43avm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1R0WxPjDQw34wI9yy8mP"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbqu43avm.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-1R0WxPjDQw34wI9yy8mP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-11 at 16:16 +0200, Takashi Iwai wrote:

> It's the behavior of the current mixer abstraction layer.  It was
> implemented in that way so that you have a (almost) compatible design
> with the earlier version of ALSA and OSS.

Why?

> > And then,
> > when I name it 'Input Source', it shows up as a single item where I can
> > select the right source, but it shows up under 'Playback'?
>=20
> Because it doesn't contain "Capture" in its name.

Yeah ok, figured that.

> "Input Source" is used for some drivers that have multiple capture
> sources.  Since the "Capture Source" is split to switches, the mixer
> abstraction layer can't handle well the multiple "Capture Source"
> controls.

Can we have it not split? Switches of which only one can be selected
absolutely *suck*.

johannes

--=-1R0WxPjDQw34wI9yy8mP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGNKfaVg1VMiehFYAQIvmhAAuMFyeaaJUMX3VucrH792Gbn2C8xcLUYl
y+28Hw8/Yo+hEL5zH8GiLcvK/q6Cv+5NaMWcAyelw26fMMvzttazAgLuTZ2h3dNz
TjdXrqF7arjq0cPH+KQrfCwenTV+GyqVdud0OuGAPCVpUKmo3Bi/JTBgbCslKsSk
JFmjIOMsONr9LBqwDBFfTMVWEUVZCO/CtfZKGUzUMu5+btlN0uScCHHjr2IxH8ne
+5KJDWRoiI3YLpHOL6kYjPHcmkeX0tlRYxPJBS6wVSOXRDM0tcs67PrPN//7CCYX
OvHO9R0r8ispXmsnOyFAIFSRwmT4bFw6AUTW13RxO/VuSLWeGEMQK1ZOS2weM7Ka
wPHEtaoNC62IRb4YBa3wUDIfswDdKkCSggoXDaAoBHT9wrNjC/+L9REJq0c2LS2o
pN9dusWtvQBzqd68EOi3RCFbHKSPsbw9e1joZ2GB6eUa8knGQ79uuoqxsJsr63ZT
B3JIWiCIzrCydEagLcUOk13gPvpSjOxTOSVoXSP92HmVw38GSU6cjdIMgdxeVe6+
a/JUBtBoNlwzFHq8rFHJ5Z2EVmu2ZfV3TAqluEQvXJK60s5BwVtVUndPmmGK8Xs+
qWBpa6HjbekGv0R+nQT9tk5pU1wUbHJKXBAdhMqPMa2MNf3kl9eabjhoFhX5Y7I3
S3l8wTarIFo=
=mDQK
-----END PGP SIGNATURE-----

--=-1R0WxPjDQw34wI9yy8mP--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
