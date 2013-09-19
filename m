From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 05/11] ASoC: davinci-mcasp: Remove interrupt property
 from DT bindings doc
Date: Thu, 19 Sep 2013 14:46:16 +0300
Message-ID: <523AE408.2020108@ti.com>
References: <cover.1379409268.git.jsarha@ti.com> <1b47734e397bfac8846dcfc194fd1ab63f320d1a.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1b47734e397bfac8846dcfc194fd1ab63f320d1a.1379409268.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jsarha-l0cyMroinI0@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 09/17/2013 12:26 PM, jsarha-l0cyMroinI0@public.gmane.org wrote:
> From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
>=20
> Davinci McASP driver does use interrupts for anything ATM.
>=20
> Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

Do not remove the interrupts. Even if they are not used they need to be
described in DT so in the future if we want we can use them.
The DT describes the HW and not the Linux implementation for the HW...

> ---
>  .../bindings/sound/davinci-mcasp-audio.txt         |    2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-au=
dio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.t=
xt
> index 68e0f47..b5e7b78 100644
> --- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> @@ -11,7 +11,6 @@ Required properties:
>  - reg-names : The mandatory reg-range must be named "mpu" and the op=
tional DMA
>  	      reg-range must be named "dma". For backward compatibility it =
is
>  	      good to keep "mpu" first in the list.
> -- interrupts : Interrupt number for McASP
>  - op-mode : I2S/DIT ops mode.
>  - tdm-slots : Slots for TDM operation.
>  - num-serializer : Serializers used by McASP.
> @@ -40,7 +39,6 @@ mcasp0: mcasp0@1d00000 {
>  	#size-cells =3D <0>;
>  	reg =3D <0x100000 0x3000>;
>  	reg-names "mpu";
> -	interrupts =3D <82 83>;
>  	op-mode =3D <0>;		/* MCASP_IIS_MODE */
>  	tdm-slots =3D <2>;
>  	num-serializer =3D <16>;
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
