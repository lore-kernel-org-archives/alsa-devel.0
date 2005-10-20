From: "Guillaume GOURAT" <guillaume.forum@free.fr>
Subject: RE: Problem compiling alsa-driver-1.0.10rc2 for arm.
Date: Thu, 20 Oct 2005 16:38:53 +0200
Message-ID: <200510201639625.SM01852@STATIONXP>
References: <s5h1x2gjmqa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1x2gjmqa.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, linux-arm@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Hi,

alsa-driver-1.0.9b & alsa-driver-1.0.10rc2 compile fine on our platform =
with
your patch ! Thank you !

Best regards,

Guillaume GOURAT

> -----Message d'origine-----
> De : Takashi Iwai [mailto:tiwai@suse.de]=20
> Envoy=E9 : jeudi 20 octobre 2005 16:18
> =C0 : Guillaume GOURAT
> Cc : alsa-devel@lists.sourceforge.net;=20
> linux-arm@lists.arm.linux.org.uk
> Objet : Re: [Alsa-devel] Problem compiling=20
> alsa-driver-1.0.10rc2 for arm.
>=20
> At Thu, 20 Oct 2005 16:06:30 +0200,
> Guillaume GOURAT wrote:
> >=20
> > Hi,
> >=20
> > I have a problem when compiling alsa-driver-1.0.10rc2 (or
> > alsa-driver-1.0.9b) with linux kernel 2.6.14-rc4 (or linux=20
> 2.6.11.4) :
> > (alsa-driver-1.0.9rc2 compile fine with linux 2.6.11.4 but not with=20
> > linux
> > 2.6.14-rc4 because class_simple_device_add symbol was removed)
> >=20
> > With alsa-driver-1.0.10rc2 :
> >=20
> >=20
> /public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/s
> > ound.i
> > nc:49: error: `snd_pci_dev_present' undeclared here (not in a=20
> > function)=20
> >=20
> /public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/s
> > ound.i
> > nc:49: error: initializer element is not constant=20
> >=20
> /public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/s
> > ound.i
> > nc:49: error: (near initialization for
> > `__ksymtab_snd_pci_dev_present.value')
> >=20
> /public/projects/mkembsys/build/nexcoder/alsa-driver-1.0.10rc2/acore/s
> > ound.i
> > nc:49: error: __ksymtab_snd_pci_dev_present causes a section type=20
> > conflict
>=20
> Try the patch below.
>=20
>=20
> Takashi
>=20
>=20
> Index: alsa-driver/acore/sound.inc
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /home/iwai/cvs/alsa/alsa-driver/acore/sound.inc,v
> retrieving revision 1.16
> diff -u -r1.16 sound.inc
> --- alsa-driver/acore/sound.inc	6 Oct 2005 22:19:46=20
> -0000	1.16
> +++ alsa-driver/acore/sound.inc	20 Oct 2005 14:17:18 -0000
> @@ -45,9 +45,11 @@
>  EXPORT_SYMBOL(snd_compat_kzalloc);
>  #endif
>  #endif
> +#ifdef CONFIG_PCI
>  #ifndef CONFIG_HAVE_PCI_DEV_PRESENT
>  EXPORT_SYMBOL(snd_pci_dev_present);
>  #endif
> +#endif
>  #ifndef CONFIG_HAVE_MSLEEP
>  EXPORT_SYMBOL(snd_compat_msleep);
>  #endif
>=20



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
