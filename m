From: Christophe Barbe <christophe@cattlegrid.net>
Subject: Re: intel8x0 ACPI suspend/resume bug
Date: Wed, 29 Jun 2005 09:35:08 -0400
Message-ID: <1120052108.14654.3.camel@localhost.localdomain>
References: <20050628150638.GB6677@cattlegrid.net>
	 <s5hacl97blk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacl97blk.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Le mercredi 29 juin 2005 =C3=A0 11:31 +0200, Takashi Iwai a =C3=A9crit :
> First of all, use alsa-1.0.9b, just to be sure.

I will try it asap.

> Then get the dump of /proc/asound/card0/codec97#*/* files before and
> after the suspend, and compare them.

I did this and the result is in the bug report. Let me quote myself:

I saved all proc files before and after a suspend/resume cycle and look
at the diff:

In /proc/asound/card0/intel8x0=20
I have the following diff:
before: Global control : 0xc0000002
after: Global control : 0x00000002

/proc/asound/card0/pcm0p/sub0/[status,sw_params,hw_params] contains
"closed" after while they have more content before but I suspect it's
normal.
And the file /proc/asound/card0/pcm0p/sub0/info contains the same in
both case except the value of subdevices_avail which is 0 before and 1
before.

Finally I have the following change in the registers:

before:
0:10 =3D 8989
0:12 =3D 9f9f
0:14 =3D 0000
0:16 =3D 9f9f
0:18 =3D 1010
0:1a =3D 0000
0:1c =3D 8080
...
0:76 =3D 2010

after:
0:10 =3D 8909
0:12 =3D 9f1f
0:14 =3D 0000
0:16 =3D 9f1f
0:18 =3D 1010
0:1a =3D 0000
0:1c =3D 8000
...
0:76 =3D 0010

I will try to figure out the meaning of the global control and the
registers. The sound output was perfect before and crappy after
(symmetric for once, but the more I increase the pcm volume the crappier
it becomes until a certain point where I get only sound from the left
channel).

For the control word, the meaning of the most significant c seems to be
related to the s/dif output which is strange especially since I don't
have a digital output AFAIK.

#define ICH_REG_GLOB_CNT 0x2c /* dword - global control */
#define ICH_PCM_SPDIF_MASK 0xc0000000 /* s/pdif pcm slot mask (ICH4) */
...
#define ICH_PCM_SPDIF_78 0x40000000 /* s/pdif pcm on slots 7&8 */
#define ICH_PCM_SPDIF_69 0x80000000 /* s/pdif pcm on slots 6&9 */

Thanks,
Christophe

>=20
> Takashi


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
