From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Date: Tue, 13 Mar 2018 08:13:41 +0000
Message-ID: <591ad9c31f604afc8bd08858eb611323@ausx13mpc120.AMER.DELL.COM>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180309090223.xb55ltac4pfesdrh@pali>
 <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
 <014795f5a3014cd3bf55de26f76a5af8@ausx13mpc124.AMER.DELL.COM>
 <20180309094600.m24d3zbzdsmls7aw@pali>
 <09eadabb264f401a88b427744505adf8@ausx13mpc124.AMER.DELL.COM>
 <20180310103809.5nnwoulua2u64rku@pali>
 <ea9ab148c4bb45b9ae7369020300b74b@ausx13mpc124.AMER.DELL.COM>
 <20180311143018.u64cldtxuv7divta@pali>
 <c49f28560996405fa4173a5a492bf201@ausx13mpc124.AMER.DELL.COM>
 <F24A81D4-F447-4128-85EA-7C4A04E844E0@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <F24A81D4-F447-4128-85EA-7C4A04E844E0@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kai.heng.feng@canonical.com
Cc: pali.rohar@gmail.com, mjg59@srcf.ucam.org, dvhart@infradead.org, andy@infradead.org, tiwai@suse.com, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Kai Heng Feng [mailto:kai.heng.feng@canonical.com]
> Sent: Tuesday, March 13, 2018 3:56 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: pali.rohar@gmail.com; mjg59@srcf.ucam.org; dvhart@infradead.org;
> andy@infradead.org; tiwai@suse.com; platform-driver-x86@vger.kernel.org; =
Linux
> Kernel Mailing List <linux-kernel@vger.kernel.org>; alsa-devel@alsa-proje=
ct.org
> Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller f=
or Dell
> platforms with Switchable Graphics
>=20
>=20
>=20
> > On Mar 12, 2018, at 9:30 AM, Mario.Limonciello@dell.com wrote:
> >
> >>> I think the missing aspect is that this is only used in AIO and lapto=
p
> >>> form
> >>> factors where the discrete graphics is in a non-removable form factor=
.
> >>
> >> Why we are not checking if kernel is running on AIO or laptop form
> >> factor then? Or it is not possible?
> >
> > Kai Heng, can you please confirm if AIO sets chassis type properly?
> > It should be 0Dh.
> >
> > If so, then I think as second check for chassis type should be possible=
 for
> > next version of this patch.
>=20
> The chassis type is correctly set as 0Dh on AIOs.
>=20
> >
> >> Basically what I see there is that we need to detect if current HW
> >> platform has switchable graphics and check how is configured AUDIO MUX=
.
> >>
> >> But instead of directly checking hw state of audio MUX, we are trying =
to
> >> check something different which could get us information of state of t=
he
> >> audio mux.
> >>
> >> I suspect that we do not have a way how to check audio MUX directly, s=
o
> >> it needs to be done indirectly -- via some Dell SMBIOS call and some
> >> other heuristic. This is something which should be specified either in
> >> comment or in commit message (problem of type: we need X, but check fo=
r
> >> Y).
> >>
> >> And if we are doing this check indirectly, we should do the most
> >> specific test and not more general.
> >
> > Right.
> >
> >> I think that PCI vendor ID check of audio device is more general test
> >> then checking if kernel is running on Dell laptop (check via DMI). And
> >> if we can check also if running on AIO or laptop form, then it would b=
e
> >> more specific test.
> >>
> >>> Running with your hypothetical though, what would happen is if it's
> >>> on a non-Dell machine the PCI check would pass and then the code
> >>> would not be executed by dell-laptop (since dell-smbios didn't load).
> >>
> >> Right.
> >>
> >>> If it was on a Dell machine it would load but the BIOS would return
> >>> either Switchable graphics turned off, or invalid token.
> >>>
> >>> Even though these aren't real for switchable graphics on Dell I don't
> >>> see a problem with either of these situations if it ever came up.
> >>
> >> I see, this solution is working...
> >>
> >> ... but, I see there a very bad precedense. What would happen if anoth=
er
> >> laptop manufactor comes with similar solution for hybrid graphics. Doe=
s
> >> it mean that hda audio driver would try to call for every one vendor i=
ts
> >> vendor dependent API function (EFI, SMM, WMI, whatever) to check if
> >> current HW has some switchable graphics and needs special checks?
> >>
> >> Those vendor dependent API functions (which Dell SMBIOS is) should be
> >> really called on vendor hardware.
> >>
> >> Otherwise audio drivers would load bunch of the other vendor dependent
> >> platform modules and all of those modules (except maximally one) just
> >> return error.
> >
> > Sure the more specific the check the less symbol requests needed that
> > will fail.
> >
> > Kai Heng,
> >
> > Can you please use Alex Hung's OEM strings patch in your series to matc=
h
> > "Dell System" in OEM strings too?
>=20
> Sure, but this probably need to wait till it gets merged in Linus' tree.
>=20

It's already in -next isn't it?  Isn't that sufficient to indicate your pat=
ch depends
on that?  Or it could come through platform-x86 tree too if needed.  During
the merge window one of the duplicates will get dropped.

> >
> > Between chassis type, OEM strings match, and AMD vendor/Dell subsystem
> > vendor that should satisfy all of Pali's concerns I think.
> >
> > If anyone thinks that's too much, please speak up.
> >
> >>> Compiling a whitelist is a wasted effort because it will have to chan=
ge
> >>> Every year for every new platform that has AMD switchable graphics.
> >>
> >> I agree, But see that this patch already uses vendor ID whitelisting.
> >
> > I mean making a whitelist of all individual affected Dell platforms wil=
l
> > grow
> > each year.  I want to avoid that approach.
