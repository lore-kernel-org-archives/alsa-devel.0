From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: [INFO] C-Media CMI9761 -A- type , CODEC ID BY MB
Date: Thu, 17 Feb 2005 03:37:41 +0000
Message-ID: <1108611462.11521.28.camel@bastov>
References: <4212D866.5000304@gmx.de> <s5hk6p8bx3v.wl@alsa2.suse.de>
	 <4213F306.50802@gmx.de>  <4213F8F4.505@gmx.de>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4213F8F4.505@gmx.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: t.schorpp@gmx.de, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

After search on https://bugtrack.alsa-project.org/ for CMI9761, 1
issues, resolved !=20
with some similarity is one ASRock k7vt4a+ with CMedia CMI9761, I have
one ASRock P4VT8+ with CMedia CMI9761.

After play around with alsamixer,=20
I got sound when unmute PCM and Off (mute) IEC958 Capture Monitor.

All others controls does change anything include mute or unmute the
Master.
Except VIA DXS (this one can do sound balance, left and right). =20
VIA DXS 1, VIA DXS 2 and VIA DXS 3 also doesn't do nothing.

Play around with=20
options snd-via82xx dxs_support
on file /etc/modprobe.conf
only with "options snd-via82xx dxs_support=3D2" I see any difference but
for worst, make disappear VIA DXS, VIA DXS 1, VIA DXS 2 and VIA DXS 3
controls.

So, can help you testing alsa CVS ?
Now I have to sleep and tomorrow, I am a little busy but, have you some
patch in specific to test this C-MEDIA sound card ?=20

Sorry for my weak English, if you don't understand something just ask
me, that I will try explain again.

thanks,

On Thu, 2005-02-17 at 02:52 +0100, thomas schorpp wrote:
> thomas schorpp wrote:
> > Takashi Iwai wrote:
> >=20
> >> At Wed, 16 Feb 2005 06:21:42 +0100,
> >> thomas schorpp wrote:
> >>
> >>> -----BEGIN PGP SIGNED MESSAGE-----
> >>> Hash: RIPEMD160
> >>>
> >>> hello,
> >>>
> >>> this device
> >>>
> >>> http://www.cmedia.com.tw/product/CMI9761.htm
> >>>
> >>> the -A- type ive got
> >>>
> >>> has working continuous (slider) master mixer+balance and "working" =
pcm
> >>> mixer slider with v106 (2.6.10 release kernel alsa) but no more wit=
h
> >>> v108 alsa-driver or cvs from yesterday.
> >>>
> >>> please branch for this device (on cheap asrock mass-seller K7VTA+ b=
oard
> >>> with via8235 pci).
> >>
> >>
> >>
> >> Interesting.  How can one detect the difference of model?  Does it
> >> have a different codec id?
> >>
> >=20
> > uh-oh!
> >=20
> > { 0x434d4941, 0xffffffff, "CMI9738",        patch_cm9738,    NULL },
> > { 0x434d4961, 0xffffffff, "CMI9739",        patch_cm9739,    NULL },
> > { 0x434d4978, 0xffffffff, "CMI9761",        patch_cm9761,    NULL },
> > { 0x434d4982, 0xffffffff, "CMI9761",        patch_cm9761,    NULL },
> > /* { 0x434d4983, 0xffffffff, "CMI9761",        patch_cm9761,    NULL =
}, */
> > { 0x434d4983, 0xffffffff, "CMI9761A",        patch_cm9761a,    NULL }=
,
> >=20
> >=20
> > Feb 17 02:05:42 tom1 kernel: ALSA=20
> > /usr/src/alsa/alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c:2105: AC'=
97=20
> > 0 is [0x434d4983] id.
> >=20
> > can it be?
> >=20
> > or im mistaking here:
> >=20
> > int patch_cm9761a(ac97_t *ac97)
> > {
> >     snd_printk(KERN_ERR "AC'97 %d is [0x%x] id.\n", ac97->num,=20
> > ac97->id); /*identify schorpp s -A- chip*/
> >=20
> > ive seen you somewhere in the code branching by mainboard vendor.
> >=20
> >     /* Special exception for ASUS W1000/CMI9739. It does not have an=20
> > SPDIF in. */
> >     if (ac97->pci &&
> >          ac97->subsystem_vendor =3D=3D 0x1043 &&
> >          ac97->subsystem_device =3D=3D 0x1843) {
> >=20
> >=20
> > well see...
>=20
> 	snd_printk(KERN_ERR "AC'97 %d is [0x%x] id.  [0x%x] pci,  [0x%x]=20
> subsystem_vendor   [0x%x] subsystem_device \n", ac97->num, ac97->id,=20
> ac97->pci, ac97->subsystem_vendor, ac97->subsystem_device); /*identify=20
> schorpp s -A- chip*/
>=20
>=20
> Feb 17 02:48:34 tom1 kernel: ALSA=20
> /usr/src/alsa/alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c:2105: AC'97=
=20
> 0 is [0x434d4983] id.  [0xdff32800] pci,  [0x1849] subsystem_vendor=20
> [0x9761] subsystem_device
>=20
> hope this helps.
>=20
> tom
>=20
> >=20
> > tom
> >=20
> >>
> >> Takashi
> >>
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users=
.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
--=20
S=E9rgio M.B.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
