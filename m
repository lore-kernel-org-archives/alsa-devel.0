From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Sat, 14 Apr 2018 12:49:50 +0200
Message-ID: <20180414104950.ngomyjy5l5cwhb5i@pali>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
 <20180412105909.tbyfcjm55sb47hiq@pali>
 <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
 <20180414104512.GA27158@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3165592050994694860=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DD9F26705F
 for <alsa-devel@alsa-project.org>; Sat, 14 Apr 2018 12:49:53 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id l49so13968402wrl.4
 for <alsa-devel@alsa-project.org>; Sat, 14 Apr 2018 03:49:53 -0700 (PDT)
In-Reply-To: <20180414104512.GA27158@wunner.de>
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
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, mario.limonciello@dell.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>, dvhart@infradead.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3165592050994694860==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="li3pzsurnzk4x4tk"
Content-Disposition: inline


--li3pzsurnzk4x4tk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 14 April 2018 12:45:12 Lukas Wunner wrote:
> On Thu, Apr 12, 2018 at 10:15:41PM +0800, Kai-Heng Feng wrote:
> > > >>@@ -1711,6 +1745,11 @@ static int azx_create(struct snd_card *card,
> > > >>struct pci_dev *pci,
> > > >> 	if (err < 0)
> > > >> 		return err;
> > > >>
> > > >>+	if (check_dell_switchable_gfx(pci)) {
> > > >>+		pci_disable_device(pci);
> > >=20
> > > Now looking at it again... This code disables all ATI and NVIDIA sound
> > > cards available in any Dell System (laptop or AIO) if system says that
> > > SG is enabled, right?
> > >=20
> > > It means that also any external ATI or NVIDIA PCI card with audio dev=
ice
> > > connected to Thunderbolt (e.g. via PCI <--> TB bridge) is always
> > > unconditionally disabled too?
> >=20
> > I never thought of this case, thanks for bringing this up.
> > Do you have any suggestion to check if it connects to the system via
> > Thunderbolt?
>=20
> Just use pci_is_thunderbolt_attached(), introduced by 8531e283bee6,
> like this:
>=20
> if (check_dell_switchable_gfx(pci) && !pci_is_thunderbolt_attached(pci))

And what about PCI-e device attached to ExpressCard slot?

> > >>>+	/* Only need to check for Dell laptops and AIOs */
> > >>>+	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL)=
 ||
> > >>>+	    !(dmi_match(DMI_CHASSIS_TYPE, "10") ||
> > >>>+	      dmi_match(DMI_CHASSIS_TYPE, "13")) ||
> > >>>+	    !(pdev->vendor =3D=3D PCI_VENDOR_ID_ATI ||
> > >>>+	      pdev->vendor =3D=3D PCI_VENDOR_ID_NVIDIA))
> > >>>+		return false;
>=20
> It sure would be nice if someone could add macros for the chassis type
> to include/linux/dmi.h so that we don't have to use these magic numbers
> everywhere:
>=20
> $ git grep -l DMI_CHASSIS_TYPE
> drivers/firmware/dmi-id.c
> drivers/firmware/dmi_scan.c
> drivers/input/keyboard/atkbd.c
> drivers/input/serio/i8042-x86ia64io.h
> drivers/platform/x86/asus-wmi.c
> drivers/platform/x86/dell-laptop.c
> drivers/platform/x86/samsung-laptop.c
> include/linux/mod_devicetable.h
> scripts/mod/file2alias.c
>=20
> Thanks,
>=20
> Lukas

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--li3pzsurnzk4x4tk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWtHcygAKCRCL8Mk9A+RD
UrpSAJ494oA3o0/1MGVtCDcKfNdvpJ9h7gCdGmvlaP/qVIu6pX2MuqsFKA2fh/s=
=YVP3
-----END PGP SIGNATURE-----

--li3pzsurnzk4x4tk--

--===============3165592050994694860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3165592050994694860==--
