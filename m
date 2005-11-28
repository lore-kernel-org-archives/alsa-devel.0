From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: envy24control word clock error
Date: Mon, 28 Nov 2005 20:05:00 +0200
Message-ID: <20051128180500.GH10146@edu.joroinen.fi>
References: <E1EgS8o-0001CV-7k@localhost.localdomain> <s5h64qclm29.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h64qclm29.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: John Rigg <ad@sound-man.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2005 at 06:27:42PM +0100, Takashi Iwai wrote:
> At Sun, 27 Nov 2005 19:24:50 +0000,
> John Rigg wrote:
> >=20
> > When I start envy24control from xterm I get an endless stream of
> > "Unable to determine wordclock status: No such file or directory" and
> > "Unable to read word clock sync selection: No such file or directory"=
 error
> > messages.
> > These don't stop until I shut down envy24control. The same occurs reg=
ardless
> > of what clock source I set in the GUI, or whether I link my two Delta=
1010s=20
> > with SPDIF or wordclock in/out. It's the same with -c0, -c1 or both l=
aunched
> > from separate xterms.
> > The messages appear to come from master_clock_status_timeout_callback=
()
> > in envy24control/hardware.c (lines 160-175).
> >=20
> > This is with alsa-tools-1.0.10 (also happens with rc2), alsa-lib-1.0.=
10,
> > kernel 2.6.14-rt20 x86_64 SMP (alsa 1.0.10rc1 drivers).
> > Anyone got any ideas?
>=20
> Try the patch below.
>

That patch fixes the problem for me! (Debian sid/unstable,=20
alsa-tools-gui 1.0.10-1)

- Pasi K=E4rkk=E4inen
=20
>=20
> Takashi

> Index: alsa-tools/envy24control/hardware.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /home/iwai/cvs/alsa/alsa-tools/envy24control/hardware.c,v
> retrieving revision 1.13
> diff -u -r1.13 hardware.c
> --- alsa-tools/envy24control/hardware.c	25 Nov 2005 11:50:20 -0000	1.13
> +++ alsa-tools/envy24control/hardware.c	28 Nov 2005 17:26:42 -0000
> @@ -165,7 +165,7 @@
>  	if (card_eeprom.subvendor !=3D ICE1712_SUBDEVICE_DELTA1010)
>  		return FALSE;
>  	snd_ctl_elem_value_alloca(&sw);
> -	snd_ctl_elem_value_set_interface(sw, SND_CTL_ELEM_IFACE_PCM);
> +	snd_ctl_elem_value_set_interface(sw, SND_CTL_ELEM_IFACE_MIXER);
>  	snd_ctl_elem_value_set_name(sw, "Word Clock Status");
>  	if ((err =3D snd_ctl_elem_read(ctl, sw)) < 0)
>  		g_print("Unable to determine word clock status: %s\n", snd_strerror(=
err));
> @@ -795,7 +795,7 @@
>  	snd_ctl_elem_value_set_interface(internal_clock_default, SND_CTL_ELEM=
_IFACE_MIXER);
>  	snd_ctl_elem_value_set_name(internal_clock_default, "Multi Track Inte=
rnal Clock Default");
> =20
> -	snd_ctl_elem_value_set_interface(word_clock_sync, SND_CTL_ELEM_IFACE_=
PCM);
> +	snd_ctl_elem_value_set_interface(word_clock_sync, SND_CTL_ELEM_IFACE_=
MIXER);
>  	snd_ctl_elem_value_set_name(word_clock_sync, "Word Clock Sync");
> =20
>  	snd_ctl_elem_value_set_interface(rate_locking, SND_CTL_ELEM_IFACE_MIX=
ER);
> @@ -811,7 +811,7 @@
>  		snd_ctl_elem_value_set_interface(spdif_input, SND_CTL_ELEM_IFACE_MIX=
ER);
>  		snd_ctl_elem_value_set_name(spdif_input, "Optical Digital Input Swit=
ch");
>  	} else {
> -	snd_ctl_elem_value_set_interface(spdif_input, SND_CTL_ELEM_IFACE_PCM)=
;
> +	snd_ctl_elem_value_set_interface(spdif_input, SND_CTL_ELEM_IFACE_MIXE=
R);
>  	snd_ctl_elem_value_set_name(spdif_input, "IEC958 Input Optical");
>  	}
> =20


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
