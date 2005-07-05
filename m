From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Re: Fix emu10k1 breakages in kernel 2.6.12
Date: Tue, 5 Jul 2005 17:16:05 +0100
Message-ID: <ad2655cb0507050916277995a4@mail.gmail.com>
References: <1120273701.12256.30.camel@mindpipe>
	 <42C66D9D.9020203@superbug.co.uk> <1120328091.2196.16.camel@mindpipe>
	 <42C7192F.90705@superbug.co.uk> <1120577617.17355.15.camel@mindpipe>
	 <s5hslytdzxq.wl%tiwai@suse.de> <1120578104.17355.17.camel@mindpipe>
	 <s5hpstxdzo2.wl%tiwai@suse.de>
Reply-To: James Courtier-Dutton <james.dutton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpstxdzo2.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>, Arnaud Patard <arnaud.patard@rtp-net.org>, Mikael Magnusson <mikaelmagnusson@glocalnet.net>, Peter Zubaj <pzad@pobox.sk>
List-Id: alsa-devel@alsa-project.org

On 7/5/05, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 05 Jul 2005 11:41:44 -0400,
> Lee Revell wrote:
> >
> > On Tue, 2005-07-05 at 17:40 +0200, Takashi Iwai wrote:
> > > At Tue, 05 Jul 2005 11:33:37 -0400,
> > > Lee Revell wrote:
> > > >
> > > > On Sat, 2005-07-02 at 23:46 +0100, James Courtier-Dutton wrote:
> > > > > So, my general point is that people are going to get bitten no ma=
tter
> > > > > what we do for the "unknown" case, but my original method was goi=
ng to
> > > > > have less of an impact that potentially yours will.
> > > >
> > > > Any more feedback on this?  We absolutely need to address the probl=
em in
> > > > the next -stable release.
> > >
> > > I agree with James.
> >
> > OK, James, do you want to generate a new patch for -stable?   As the
> > developer of this feature, I think you understand the behavior better
> > than me...
>=20
> BTW, it would be nice, too, if we have a "model" module option like
> other drivers.  It would give users a chance to choose another card
> model without compiling drivers if the card is not detected
> correctly.
>=20
> This isn't necessarily put to -stable tree, though.
>=20
>=20
> Takashi
>=20

I don't know about stable stuff.
I currently only have access to the alsa cvs, so I put fixes in their
and let other people migrate those into kernel xyz.
I will look at the "model" option when I get a chance next weekend.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
