From: jayakumar alsa <jayakumar.alsa@gmail.com>
Subject: Re: cs5536 ID for cs5535audio
Date: Wed, 14 Dec 2005 22:26:49 -0800
Message-ID: <47f5dce30512142226n18fc4280m26ce5b0bb4b80d3f@mail.gmail.com>
References: <200512141431.32685.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200512141431.32685.rene@exactcode.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

On 12/14/05, Ren=E9 Rebe <rene@exactcode.de> wrote:
> Hi all,
>
> relative to 2.6.15-rc5-mm2 / alsa-cvs, works for me:
>
> Added AMD CS5536 to the cs5535audio driver.
>

Ren=E9,

Your patch looks fine to me. If possible, could you add an update for
the Kconfig to list cs5536 within the cs5535audio entry. One thing
though, I'm concerned about master mixer control on certain GX3
boards. There was an issue raised by Stefan Schweizer where the
cs5535audio driver on GX3 boards (with at least one that used the
Realtek ALC203 rev 0 ac97 codec) fails to provide functional master
control. John Zulauf mentioned that certain GX3 reference board
designs wire headphone out to the connector rather than main. I still
haven't received the GX3 to test with so perhaps someone else would
like to test an AC97_TUNE_HP_ONLY ac97_quirk. Here's a rough start
that someone could use:

static char *ac97_quirk;
module_param(ac97_quirk, charp, 0444);
MODULE_PARM_DESC(ac97_quirk, "AC'97 board specific workarounds.");

static struct ac97_quirk ac97_quirks[] __devinitdata =3D {
=09{
=09=09.subvendor =3D use lspci to find out,
=09=09.subdevice =3D something,
=09=09.name =3D "boardname",     /* codecname */
=09=09.type =3D AC97_TUNE_HP_ONLY
=09},
=09{}
};

then add:

snd_ac97_tune_hardware(cs5535au->ac97, ac97_quirks, ac97_quirk);

after the snd_ac97_mixer call.

Thanks,
jk

> Signed-off-by: Ren=E9 Rebe <rene@exactcode.de>
>
> --- sound/pci/cs5535audio/cs5535audio.c.orig=092005-12-14 14:39:11.000000=
000
> +0100
> +++ sound/pci/cs5535audio/cs5535audio.c=092005-12-14 14:29:23.000000000 +=
0100
> @@ -46,8 +46,10 @@
>  static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
>
>  static struct pci_device_id snd_cs5535audio_ids[] =3D {
> -=09{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO, PCI_ANY_ID,
> -=09=09PCI_ANY_ID, 0, 0, 0, },
> +=09{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO,
> +=09  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> +=09{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO,
> +=09  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
>  =09{}
>  };
>
>
>
> --
> Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
>             http://www.exactcode.de | http://www.t2-project.org
>             +49 (0)30  255 897 45
>
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
