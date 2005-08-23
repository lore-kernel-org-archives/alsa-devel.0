From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Tue, 23 Aug 2005 23:40:44 +0200
Message-ID: <200508232340.46629.alien999999999@users.sourceforge.net>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <430B3EA0.1000903@netvigator.com> <s5hr7ck4lmt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1329545.JetIxsENnS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7ck4lmt.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, Raymond <rayau@netvigator.com>, Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

--nextPart1329545.JetIxsENnS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op dinsdag 23 augustus 2005 19:18, schreef Takashi Iwai:
> At Tue, 23 Aug 2005 23:20:00 +0800,
>
> Raymond wrote:
> > Takashi Iwai wrote:
> > > At Sat, 20 Aug 2005 08:45:47 +0800,
> > >
> > > Raymond wrote:
> > >>I am still using Kernel 2.4 which is not affected by the missing of
> > >>these two patches.
> > >>
> > >>Is the missing of "snd_card_set_dev(card, &pci->dev);" affected only
> > >>some distrubtion of Kernel 2.6 (32-bits platform) ?
> > >>
> > >>https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D299
> > >
> > > Sure, it's only for 2.6, and it can't be critical.
> > > It just adds the sysfs entry for udev/hal.  It must work fine without
> > > it.
> > >
> > >>The reporter of bug 216 using Kernel 2.4 and the reporter of bug 299
> > >>using Kernel 2.6
> > >
> > > Then this will fix that bug very unlikely.
> > >
> > >
> > > Takashi
> >
> > For au88x0 on AMD64
> >
> > One of the au8810 user still experience hangs when using GAIM.
> >
> > Igor V. Kovalenko reported his patch is OK for his au8820
> >
> > http://savannah.nongnu.org/patch/?func=3Ddetailitem&item_id=3D3948#comm=
ent43
> >
> > There are no feed back from the reporters of ALSA BTS and another au8830
> > user in the alsa.user mailing list.
> >
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1047  au8810
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1138  au8820
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1025  au8830
> >
> > Would you related this three bugs report ?
> >
> > They can try Igor V. Kovalenko's patch at the openvortex project.
>
> The current code can't work obviously on 64bit architecture because
> of the following definition:
>
> struct snd_vortex {
> 	...
> 	unsigned long __iomem *mmio;
> 	...
> };
>
> It must be u32 if you want to be architecture independent.

that doesn't mean much, you need to see how it handles adding to it, with a=
ll=20
the typecasts...

the one i'm running has: (this IS architecture independent)

=2E..
        struct gameport *gameport;

        /* PCI hardware resources */
        unsigned long io;
        void __iomem *mmio;
        unsigned int irq;
        spinlock_t lock;
=2E..


anyway, i really need to do the latest tests, i have way too many adb failu=
res=20
lately.

it mostly happens, when watching a movie and gaim starts a little sound.

i've determined that it's not likely to be the max available sounds, but mo=
re=20
likely to be the weird scheduling of sounds at the same time

i urge you people to chat more using some program that starts little sounds=
=20
so, you have lots of short start and stops at the same time, maybe use gaim=
=20
for ICQ and IRCing, that always gives me plenty of sounds...

PS: i forgot the latest patch i had to try out.

I'll do one patch to try out, and hope it doesn't require me to reboot this=
=20
machine...

i'm using alsa CVS from some weeks ago, i think

--nextPart1329545.JetIxsENnS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDC5feuBWKXETrtdcRAi+8AKDc7KLv/ZXQB+pfKOiHx4eq2ZGFyACfT+YC
urWCZUVE5+HfYioYaFT8d9I=
=I4t7
-----END PGP SIGNATURE-----

--nextPart1329545.JetIxsENnS--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
