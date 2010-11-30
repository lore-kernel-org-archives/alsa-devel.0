From: Tony Vroon <tony@linx.net>
Subject: Re: CONFIG_SND_HDA_INTEL regression on 2.6.37-rc3 - no
 audio
Date: Tue, 30 Nov 2010 21:39:57 +0000
Message-ID: <1291153197.4814.11.camel@amalthea>
References: <AANLkTi=ywUP8QUDGqotutccf9E2a1b5U2bKNZDWa3PG3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6261346860727078543=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id E9E3D103833
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 22:39:43 +0100 (CET)
In-Reply-To: <AANLkTi=ywUP8QUDGqotutccf9E2a1b5U2bKNZDWa3PG3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Luis R. Rodriguez" <mcgrof@gmail.com>
Cc: alsa-devel@alsa-project.org, Iwai <tiwai@suse.de>, Takashi@alsa-project.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: alsa-devel@alsa-project.org


--===============6261346860727078543==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-/ltTDjWovEf0ykWzYI29"


--=-/ltTDjWovEf0ykWzYI29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-11-30 at 13:31 -0800, Luis R. Rodriguez wrote:
> snd_hda_codec_analog,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,thinkp=
ad_acpi,snd_rawmidi,snd_seq,snd_timer,snd_seq_device

Note that on some ThinkPads, there is an additional output mixer that is
not always exported to ALSA. Please make sure that your hardware volume
is unmuted and at a reasonable volume.

Could you use alsa-info.sh to gather your codec files, system DMI, etc
please?

(The only audio regression in 2.6.37 that I'm aware of was Realtek
ALC269-related and has already been fixed. It left me without volume
control until -rc3)

Regards,
--=20
Tony Vroon
UNIX systems administrator
London Internet Exchange Ltd, Trinity Court, Trinity Street,
Peterborough, PE1 1DA
Registered in England number 3137929
E-Mail: tony@linx.net

--=-/ltTDjWovEf0ykWzYI29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkz1by0ACgkQp5vW4rUFj5pyewCZAab9sC1OFx/H2GHL3yjhp8Of
D6wAoL2V8SVCaC2PcLKXotUkFSoFWjuo
=JpBt
-----END PGP SIGNATURE-----

--=-/ltTDjWovEf0ykWzYI29--


--===============6261346860727078543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6261346860727078543==--
