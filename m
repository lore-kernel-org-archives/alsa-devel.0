From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Mon, 17 Nov 2003 19:18:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311171918.54453.pwk.linuxfan@gmx.de>
References: <200311141221.hAECLqlT003018@oud.linuxaudiosystems.com> <200311171434.50285.pwk.linuxfan@gmx.de> <s5hfzgnjc88.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzgnjc88.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

WARNING: Unsanitized content follows.
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Montag, 17. November 2003 15:33 schrieb Takashi Iwai:
> At Mon, 17 Nov 2003 14:34:14 +0100,
>
> Peter Kirk wrote:
> > WARNING: Unsanitized content follows.
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Am Montag, 17. November 2003 11:32 schrieb Takashi Iwai:
> > > At Mon, 17 Nov 2003 01:37:02 +0000,
> > >
> > > Mark Hubbard wrote:
> > > > On Friday 14 Nov 2003 15:31, Takashi Iwai wrote:
> > > > > At Fri, 14 Nov 2003 15:11:22 +0000, Mark Hubbard wrote:
> > > > > > On Friday 14 Nov 2003 13:20, Takashi Iwai wrote:
> > > > > > > as a future plan, we'll define dmix as default for el-cheapo
> > > > > > > soundcards, but e.g. not for sb live, which supports such a
> > > > > > > function on hardware.
> > >
> > > ok, let me correct:  which users most likely want as dmix plugin :)
> >
> > Hmmm,
> >
> > sorry if I cant realy follow your reasoning. I have understood that usi=
ng
> > dmix on every device is stupid - since some applications like jack want
> > low level access to the hardware. But these applications should use the
> > hw: device, if I understand everything right. If this is so, you have y=
et
> > to come up for any reason why a user would NOT want a smartdmix running
> > behind devices like "default" "rear" front" (and all others that I dont
> > know about, but that are consumer application devices) ?
> >
> > Please enlighten me on this.
>
> i personally think using dmix would be nice even for such "high-end"
> cards.  but the smart dmix can still result in resampling or format
> conversion if the first and the second applications use different
> sample rates or formats.  in the case of cheap soundcards, it's not a
> big problem because the quality is anyway cheap, too.  however, in the
> case of high-end cards, people might not like that it happens.

if I understand it right, then "high-end" cards should be able to play=20
multiple streams in hardware...meaning the smart dmix wouldnt even do=20
anything else than pass on the streams to the soundcard (no resampling, no=
=20
mixing, no nothing). Only if you play two streams on a soundcard that can=
=20
only handle playing one, then it would mix (and resample if necessary for t=
he=20
mixing).

> this decision, whether dmix as default is better or not, depends on
> users, not on us developers.
> the statement above simply shows this attitude.
Well,

me being a user, I can tell you id realy love it (and I dont even have a=20
*low*end* soundcard, for me only the dsnoop suggestion would make a=20
difference.

Peter
- --=20
Who was that masked man?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/uREJg2ieGvTmHiURAp9BAKCLdCBQQE1Tq4xv58QAtFwQGiwCTQCdHZN5
s/Xr3/7ACgurLNBBhwVsZBs=3D
=3DLeq0
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
