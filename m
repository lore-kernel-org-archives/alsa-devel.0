From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Envy24HT
Date: Tue, 3 Dec 2002 19:06:25 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212031858070.503-100000@pnote.perex-int.cz>
References: <m18JGZc-003yTeC@mail.corpex.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m18JGZc-003yTeC@mail.corpex.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Stafford <jstafford@ampltd.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Dec 2002, James Stafford wrote:

> Attached are two patches that add basic Envy24HT support to the ICE1712
> driver and VT1616 to the AC97 codec driver. They were made against the cv=
s
> from today.
>=20
> Issues:
> Quote from VT1616 data sheet: "The VT1616 powers up with pins 39 and 41
> assigned to the Front channel DACs as described in the 2.2 specification.
> When this bit is to =930=94, the output pins get assigned to the Rear ste=
reo
> DAC pair with an independent volume control."=20
> The reference design uses pins 39 and 41 for the left and right rear
> outputs. I have added a control to set this bit to 0 but the default is 1=
=2E
> Should a patch function be used to set the default to 0?

I think that the default should be left in the AC97 code and write the=20
appropriate configuration after snd_ac97_mixer() call when you detect your=
=20
hardware and VT1616 codec.

> When using applications such as MPlayer and ac3dec, the centre/lfe and re=
ar
> outputs are swapped so that the data for the rear comes out of centre/lfe
> and vice versa. Is there something I have missed here?

We send data in this order: channel0,1 =3D front; channel2,3 =3D rear;=20
channel4,5 =3D center/lfe ; if your hardware has swapped some stereo paths,=
=20
you need to swap channels in software - see=20
alsa-lib/src/conf/cards/ICH.conf - ICH.pcm.surround51.0 {} section

I've applied your patch and fixed one missing update in ice1712.h. Also,=20
the driver id is changed in CVS.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
