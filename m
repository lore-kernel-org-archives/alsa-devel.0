From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Sat, 10 Mar 2018 11:40:33 +0100
Message-ID: <20180310104033.ndmlwt4evbs6xg5u@pali>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180309090223.xb55ltac4pfesdrh@pali>
 <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
 <20180310065039.GA6633@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7415710787934514323=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E80C2670F8
 for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2018 11:40:35 +0100 (CET)
Received: by mail-wm0-f41.google.com with SMTP id z81so8124360wmb.4
 for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2018 02:40:35 -0800 (PST)
In-Reply-To: <20180310065039.GA6633@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukas Wunner <lukas@wunner.de>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, Mario Limonciello <mario.limonciello@dell.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tiwai@suse.com, platform-driver-x86@vger.kernel.org, Kai Heng Feng <kai.heng.feng@canonical.com>, dvhart@infradead.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7415710787934514323==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7lb3d2knnhwyrstn"
Content-Disposition: inline


--7lb3d2knnhwyrstn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 10 March 2018 07:50:39 Lukas Wunner wrote:
> Pretty much all modern Nvidia GPUs do have an integrated HDA
> controller, however it's possible to hide it by clearing a bit
> at offset 0x488 in the GPU's config space.  Some BIOSes hide
> the HDA if no external display is attached.
>=20
> I could imagine that the BIOS of the Dell machines in question
> hides the HDA if Switchable Graphics is enabled.  If that is the
> case, be aware that there's an ongoing discussion to always expose
> the HDA controller because the behavior of some BIOSes to only
> expose the HDA when a display is attached causes massive problems
> with Linux' HDA driver:
> https://bugs.freedesktop.org/show_bug.cgi?id=3D75985
>=20
> If we decide to always expose the HDA controller on Nvidia cards,
> you may need to also match for the Nvidia vendor ID here.

This is probably the example of reason why current solution based on
vendor id is fragile and could be broken in future... if such changes to
unhide devices are going to be implemented.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--7lb3d2knnhwyrstn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWqO2HQAKCRCL8Mk9A+RD
UnA+AKCMayrsTj+qiYSGDWAb1DTH+TudoQCeOYtBDhTFqf8RbCuyprC4YVm/RVg=
=CueD
-----END PGP SIGNATURE-----

--7lb3d2knnhwyrstn--

--===============7415710787934514323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7415710787934514323==--
