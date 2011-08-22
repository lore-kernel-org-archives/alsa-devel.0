From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] USB: Gadget: Add Audio Class 2.0 Driver
Date: Mon, 22 Aug 2011 14:30:02 +0300
Message-ID: <20110822113002.GD30398@legolas.emea.dhcp.ti.com>
References: <1313752934-20081-1-git-send-email-jassisinghbrar@gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1313752934-20081-1-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 19, 2011 at 04:52:14PM +0530, Jassi Brar wrote:
> This is a flexible USB Audio Class 2.0 compliant gadget driver that
> implements a simple topology with a virtual sound card exposed at
> the function side.
>=20
> The driver doesn't expect any real audio codec to be present on the
> function - the audio streams are simply sinked to and sourced from a
> virtual ALSA sound card created. The user-space application may choose
> to do whatever it wants with the data received from the USB Host and
> choose to provide whatever it wants as audio data to the USB Host.
>=20
> Capture(USB-Out) and Playback(USB-In) can be run at independent
> configurations specified via module parameters while loading the driver.
>=20
> Signed-off-by: Yadi Brar <yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> How To Test
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   USB_DEV$ insmod g_audio2.ko c_srate=3D64000 p_srate=3D48000 ; say
>     gadget: high speed config #1: UAC2
>=20
>   USB_DEV$ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: uac2 [uac2], device 0: UAC2 PCM [UAC2 PCM]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
>=20
>   USB_DEV$ arecord -l
> **** List of CAPTURE Hardware Devices ****
> card 0: uac2 [uac2], device 0: UAC2 PCM [UAC2 PCM]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
>=20
>   USB_HOST$ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: PCH [HDA Intel PCH], device 0: ALC665 Analog [ALC665 Analog]
>   Subdevices: 0/1
>   Subdevice #0: subdevice #0
> card 1: Gadget [UAC2 Gadget], device 0: USB Audio [USB Audio]  <<<<<<
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
>=20
>   USB_HOST$ arecord -l
> **** List of CAPTURE Hardware Devices ****
> card 0: PCH [HDA Intel PCH], device 0: ALC665 Analog [ALC665 Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 1: Gadget [UAC2 Gadget], device 0: USB Audio [USB Audio] <<<<<<<
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
>=20
>  After this confirmation, you should be able to use it just like another
> sound card in your system. That is, a new sound card should appear in the
> sound preferences which you can select to route your default audio to and
> from.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Test Results
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  The driver has been tested for Half as well as Full Duplex at
> Stereo, S16_LE at 44.1KHz, 48KHz and 64KHz. It should also
> work for other configurations as well, except for different
> sample-size(TODO).
>=20
> Obviously, much depends upon the underlying UDC driver.
>=20
> While testing with OMAP's implementation of Inventra HDRC, I observed
> some noise for configurations for which the USB-OUT packet size chosen
> by the Host is not a power of 2. USB-IN works just fine.
> For ex, on both Beagle/Panda board, 48KHz USB-OUT has some noise while
> 64KHz is smooth. Also, with full duplex, it occasioanally shows noise.
>=20
> Taking benefit of doubt, I assume this driver has unmasked some subtle
> bug in the underlying UDC's ISOCH handling code ;)
> Please feel free to find issue with this driver by testing it over
> some other UDC.
>=20
>  drivers/usb/gadget/Kconfig    |   20 +
>  drivers/usb/gadget/Makefile   |    2 +
>  drivers/usb/gadget/audio2.c   |  155 +++++
>  drivers/usb/gadget/f_audio2.c | 1448 +++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 1625 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/gadget/audio2.c
>  create mode 100644 drivers/usb/gadget/f_audio2.c
>=20
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index e35dfef..95c65d8 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -599,6 +599,26 @@ config USB_ZERO_HNPTEST
>  	  the "B-Peripheral" role, that device will use HNP to let this
>  	  one serve as the USB host instead (in the "B-Host" role).
> =20
> +config USB_AUDIO_2
> +	tristate "Audio Gadget Class 2.0 (EXPERIMENTAL)"
> +	depends on SND && EXPERIMENTAL
> +	select SND_PCM
> +	help
> +	  This Gadget Audio driver is compatible with USB Audio Class
> +	  specification 2.0. It implements 1 AudioControl interface,
> +	  1 AudioStreaming Interface each for USB-OUT and USB-IN.
> +	  Number of channels, sample rate and sample size can be
> +	  specified as module parameters.
> +	  This driver doesn't expect any real Audio codec to be present
> +	  on the device - the audio streams are simply sinked to and
> +	  sourced from a virtual ALSA sound card created. The user-space
> +	  application may choose to do whatever it wants with the data
> +	  received from the USB Host and choose to provide whatever it
> +	  wants as audio data to the USB Host.
> +
> +	  Say "y" to link the driver statically, or "m" to build a
> +	  dynamically linked module called "g_audio2".
> +
>  config USB_AUDIO
>  	tristate "Audio Gadget (EXPERIMENTAL)"
>  	depends on SND
> diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
> index 7409338..fa8472e 100644
> --- a/drivers/usb/gadget/Makefile
> +++ b/drivers/usb/gadget/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_USB_COMPOSITE)	+=3D usb-composite.o
>  #
>  g_zero-y			:=3D zero.o
>  g_audio-y			:=3D audio.o
> +g_audio2-y			:=3D audio2.o

instead of adding a new gadget driver, can't you just re-use g_audio and
add what's missing ?

--=20
balbi

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOUj25AAoJEAv8Txj19kN1BFIH/Rcc07upHLLeztvw/4PXnpIi
SoG5iYDOsA1o+Lh1CysibvaWNvWfjsA6JUAykTjgkVFis4Mso03evrAx3H30vXxV
ZGXCGwYYo/mbjwuyO3IrOELAsHjHm9AdKmW+WZfTB7y7uwiba2Nr1jmrDVCeGUu1
waKZZ6qZ1Hb3fqTrQwHLS+0lb8T9u8ZRi8DID8wFhlU+mk3kISZ7+NGtAZTTk3SW
3/4HQbP4DU4qFFCVSiWpm/ZWqktxEfgTHCizzEyK4+97/c1xXIOf+2a2DUsuJjtV
F0rJ0sFAPq4IfLJ+bT7qvIcRv49A0tjUwp9JHFAitL6KeDEl9Q6kswQMsUP9/u4=
=VGe5
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
