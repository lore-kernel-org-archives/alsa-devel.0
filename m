From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Unresolved symbol in snd-cs4231-lib, CVS and Linux 2.4.29
Date: Mon, 14 Mar 2005 09:06:49 +0000 (GMT)
Message-ID: <20050314090649.67263.qmail@web52910.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 6667
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Are you building "all" soundcards? I am only building snd-sscape and snd-=
usb-audio.

Cheers,
Chris

--- Jaroslav Kysela <perex@suse.cz> wrote:
> On Sun, 13 Mar 2005, Chris Rankin wrote:
>=20
> > 'make cvsclean' had no effect, I'm afraid. I've currently resorted to
> > editing the config.h file manually to set CONFIG_SND_GENERIC_PM to 1.
>=20
> I cannot reproduce here...
>=20
> 					Jaroslav
>=20
> > --- Jaroslav Kysela <perex@suse.cz> wrote:
> > > > depmod: *** Unresolved symbols in
> /lib/modules/2.4.29/kernel/drivers/sound/snd-cs4231-lib.o
> > > > depmod:         snd_card_set_generic_pm_callback
> > > >=20
> > > > I was compiling the snd-sscape driver: does this driver need to s=
et the
> CONFIG_SND_GENERIC_PM
> > > > #define in the configure script?
> > >=20
> > > Do 'make cvsclean' in the alsa-driver directory and try again...
> >=20
> > Send instant messages to your online friends http://uk.messenger.yaho=
o.com=20
>=20
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs
>=20

Send instant messages to your online friends http://uk.messenger.yahoo.co=
m=20


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
