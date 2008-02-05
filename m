From: Marco Schuster <marco@harddisk.is-a-geek.org>
Subject: Re: ALC268 (no sound)
Date: Tue, 05 Feb 2008 18:29:12 +0100
Message-ID: <47A89CE8.3010902@harddisk.is-a-geek.org>
References: <47A23800.6050305@harddisk.is-a-geek.org>
	<s5hbq703lv4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8274025293716521415=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.velirat.de (velirat.de [85.25.68.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BF70243A8
	for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2008 18:29:35 +0100 (CET)
In-Reply-To: <s5hbq703lv4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8274025293716521415==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig83F991ED28A685A8BC513009"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig83F991ED28A685A8BC513009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Takashi Iwai schrieb:
> At Fri, 1 Feb 2008 18:12:32 +1030 (CST),
> Jonathan Woithe wrote:
>> Hi Marco
>>
>>> maybe this topic is a bit outdated, but still, when using the current=

>>> hg code of the kernel module together with 2.6.24 (stable), I can't
>>> get any sound :(
>> Interesting.  I've had another user report getting sound out of the la=
test
>> hg tree with an ALC268 both with test mode and the "auto" mode.  Our
>> continued failure to get anything out of your laptop over the last few=

>> months makes me suspect that there's some other non-standard thing (ex=
ternal
>> to the ALC268 codec) linked to the sound system in your laptop which
>> prevents audio unless activated.  Takashi, what's your take on this?
>=20
> Hard to say...  I still think it's either GPIO or EAPD except for very
> stupid things like the hardware-volume control via laptop keys
> (e.g. Thinkpad has independent volume controls and you have to unmute
> it via a button properly).  Marco, did you test all combinations of
> GPIO and EAPD?
Well, there are softkeys on the machine, but they don't have any
effect (for example the LED for mute doesn't change when pressing the
button). What's that stuff with GPIO/EAPD?
>=20
> On other earlier ALC codecs, some device require COEF setups.  This
> might be worth to try for ALC268 if the above is all checked.
Another thing I don't understand :(

Marco

PS: If you want, I can upload the Windoze drivers somewhere so that
you can take a look at them and find out what is going on here...


--------------enig83F991ED28A685A8BC513009
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHqJzsW6S2GapJUuQRAodoAJwJXRYjXTE79/pk4ixixOaMdr6iswCfXV+Z
Dj5aTSg+1wyFqrqk2Rffrpg=
=Ri4N
-----END PGP SIGNATURE-----

--------------enig83F991ED28A685A8BC513009--

--===============8274025293716521415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8274025293716521415==--
