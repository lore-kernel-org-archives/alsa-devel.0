From: "Anthony Dominic Truong" <Anthony.Truong@mascorp.com>
Subject: Re: VIA VT8237
Date: Wed, 02 Jun 2004 16:06:56 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1086217616.2458.53.camel@huykhoi.mascorp.com>
References: <40BE3D0E.5050804@hccnet.nl>
Reply-To: <Anthony.Truong@mascorp.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
In-Reply-To: <40BE3D0E.5050804@hccnet.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gert Vervoort <gert.vervoort@hccnet.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a new feature in this new AC97 controller.  3D Channel SGD
Control Register (offset 0x41) is used to turn this on or off.  Writing
a 1 to bit 4 of this register enables the swapping of center and LFE
playbacks (slots 3,4,7,8,9,6).  Clearing this bit keeps the order
(3,4,7,8,6,9).
This is a bit of info I got from VIA after struggling with this swapping
for nearly a week. :-(

Regards,
Anthony Dominic Truong.


On Wed, 2004-06-02 at 13:48, Gert Vervoort wrote:
> The following patch adds a reference to the VIA VT8237 southbridge:
>=20
> --- via82xx.c.orig      2004-06-02 22:09:04.509536136 +0200
> +++ via82xx.c   2004-06-02 22:40:35.773020384 +0200
> @@ -136,6 +136,7 @@
>  #define VIA_REV_8233           0x30    /* 2 rec, 4 pb, 1 multi-pb, =
spdif */
>  #define VIA_REV_8233A          0x40    /* 1 rec, 1 multi-pb, spdf */
>  #define VIA_REV_8235           0x50    /* 2 rec, 4 pb, 1 multi-pb, =
spdif */
> +#define VIA_REV_8237           0x60    /* 2 rec, 4 pb, 1 multi-pb, =
spdif */
> =20
>  /*
>   *  Direct registers
> @@ -2070,6 +2071,7 @@
>         { VIA_REV_8233, "VIA 8233", TYPE_VIA8233 },
>         { VIA_REV_8233A, "VIA 8233A", TYPE_VIA8233A },
>         { VIA_REV_8235, "VIA 8235", TYPE_VIA8233 },
> +       { VIA_REV_8237, "VIA 8237", TYPE_VIA8233 },
>  };
> =20
>  /*
>=20
> When playing back 6 channel audio on this card, it looks like the rear =

> left/right and center/LFE are switched.
>=20
> Gert
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> >From Windows to Linux, servers to mobile, InstallShield X is the one
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>=20




Disclaimer: The information contained in this transmission, including =
any=20
attachments, may contain confidential information of Matsushita Avionics =

Systems Corporation.  This transmission is intended only for the use of =
the=20
addressee(s) listed above.  Unauthorized review, dissemination or other =
use=20
of the information contained in this transmission is strictly =
prohibited.=20
If you have received this transmission in error or have reason to =
believe=20
you are not authorized to receive it, please notify the sender by return =

email and promptly delete the transmission=20




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
