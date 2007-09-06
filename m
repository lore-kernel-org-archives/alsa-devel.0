From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [alsa-devel] [PATCH] Improved support for	different
	bt87x	board configurations
Date: Thu, 06 Sep 2007 21:17:12 +0100
Message-ID: <1189109832.10203.30.camel@areia>
References: <Pine.LNX.4.58.0708300319210.18152@shell4.speakeasy.net>
	<s5h3ay1i8rs.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709021603380.18152@shell4.speakeasy.net>
	<1188801407.6762.1208578117@webmail.messagingengine.com>
	<Pine.LNX.4.58.0709040447220.31808@shell4.speakeasy.net>
	<1188914079.6535.47.camel@areia> <s5hr6leyy0r.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709041339540.31808@shell4.speakeasy.net>
	<1188975275.6158.34.camel@areia>
	<Pine.LNX.4.58.0709050120490.31808@shell4.speakeasy.net>
	<s5h3axtv30n.wl%tiwai@suse.de> <1188988371.6158.43.camel@areia>
	<Pine.LNX.4.58.0709051523390.31808@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0709051523390.31808@shell4.speakeasy.net>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux and Kernel Video <video4linux-list@redhat.com>
List-Id: alsa-devel@alsa-project.org


Em Qua, 2007-09-05 =C3=A0s 15:34 -0700, Trent Piepho escreveu:
> On Wed, 5 Sep 2007, Mauro Carvalho Chehab wrote:
> > > Well, at first I misunderstood that we would share the PCI SSIDs
> > > together with enum items.  Sharing only the enum items doesn't give
> > > much improvements.  Sharing the card database may do, though.
> > >
> > > So, I see Trent's point.  The merge work wouldn't pay for the benif=
it
> > > by sharing only the enum id, not the card database.
> >
> > I like the idea of sharing the database. This probably will mean that
> > snd_bt87x would be dependent of bttv driver (or a bttv core driver).
> > This have the advantage of helping also to fix some conflicts with dv=
b
> > bttv driver.
>=20
> I see how that could be an improvement.  Now the bt87x driver has a
> whitelist of cards with sound and a blacklist of cards with DVB, while =
the
> bt878 DVB driver has the exact opposite lists.  Except the two driver's
> lists aren't in sync of course.
>=20
> The cx88 driver keeps the database in the core module.  One drawback is
> that the database can't be __initdata, as it has to stick around after =
the
> core module is loaded so the other drivers that are loaded later can ge=
t at
> it.  Of course, __initdata doesn't do any for most configurations and i=
t's
> not that big of a drawback in practice.

Trent,

Could you work on such patches for 2.6.25? For 2.6.24, my suggestion is
just to apply your already submitted one.

Takashi,=20

If you want, you may add my ack to the already-sent Trent's patch:

Reviewed-by: Mauro Carvalho Chehab <mchehab@infradead.org>

Cheers,
Mauro.

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
