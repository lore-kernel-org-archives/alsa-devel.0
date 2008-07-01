From: "Tony \"Chainsaw\" Vroon" <chainsaw@gentoo.org>
Subject: Re: Audigy bay protocol
Date: Tue, 01 Jul 2008 11:27:12 +0100
Message-ID: <1214908032.15385.7.camel@localhost>
References: <1214485915.3972.32.camel@localhost> <s5h3amtgbkd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5498888740678326048=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	by alsa0.perex.cz (Postfix) with ESMTP id B80E424345
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 12:28:24 +0200 (CEST)
In-Reply-To: <s5h3amtgbkd.wl%tiwai@suse.de>
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


--===============5498888740678326048==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YpnNdURY6QEIVN1VdhXu"


--=-YpnNdURY6QEIVN1VdhXu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-01 at 12:09 +0200, Takashi Iwai wrote:
> Do you mean that after sending the last two SYSEX, the device returns
> the SYSEX messages above appropriately?  In which timing?

Those two SysEx messages are the (immediate) response to the
initialisation string. The first seems some generic "yes, bay attached,
speaking protocol 2.3" reply, while the second is your initial jack
status.
You could time out on not receiving the "bay attached" message and then
not enable your SysEx listener at all. The actual message will arrive
within a single second, but 5 seconds should be a safe bet.

Once this sequence completes, you will then get jack/button/volume
updates as the event occurs on the bay.

To confirm, the initialisation string is:
echo -en "\xf0\x00\x20\x21\x61\x00\x00\x00\x7f\x00\xf7"
> /dev/snd/midiC0D1

> thanks,
> Takashi

Regards,
Tony V.

--=-YpnNdURY6QEIVN1VdhXu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhqBoAACgkQp5vW4rUFj5rhgwCgjJAODRgaRrIb4QUZpocJpBkZ
xTkAnj32xs1Eq6x8N/xanj357IdekFvG
=x+X5
-----END PGP SIGNATURE-----

--=-YpnNdURY6QEIVN1VdhXu--


--===============5498888740678326048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5498888740678326048==--
