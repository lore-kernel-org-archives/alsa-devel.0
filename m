From: =?iso-8859-1?q?Z=E9bulon?= <zeb@zebulon.org.uk>
Subject: Re: Terratec Aureon Space
Date: Fri, 16 May 2003 18:50:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305161850.41809.zeb@zebulon.org.uk>
References: <200305151826.55345.zeb@zebulon.org.uk> <1053081208.17139.41.camel@caernarfon> <s5hn0hndvh8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0hndvh8.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Le Vendredi 16 Mai 2003 12:41, Takashi Iwai a =E9crit :
> At 16 May 2003 11:33:28 +0100,
>
> Liam Girdwood wrote:
> > Hi Takishi,
> >
> > On Fri, 2003-05-16 at 10:33, Takashi Iwai wrote:
> > > > Can I expect to see it supported in the future ?
> > >
> > > only if we get enough technical information...
> > >
> > > at least we need to know the wire connection between codec and ice1724
> > > chips, especially 61, 62 and 63 pins of Wolfson chip and GPIO pins of
> > > ice1724 chip.
> >
> > I'm currently developing Linux drivers for our AC97 range of audio
> > codecs. Unfortunately, the WM8770 is not in my schedule at the moment as
> > I'm busy working on WM97xx touchscreen drivers.
> >
> > However, the WM8770 datasheet is available here.
> > http://www.wolfsonmicro.com/download.asp/did.217/WM8770.pdf
> >
> > Hope this helps.
>
> thanks for the follow-up.
>
> i already know it (and that's why i wrote the specific pin numbers in
> my mail above :)  the wolfson chip is fine, it's perfectly described
> in the datasheet.
>
> the only question is the connection between the controller and the
> code chips.  envy24ht has many GPIO pins, which are used for i2c
> controls in most cases with 24bit DAC/ADC.
> if the card vendor provides us this info, the driver will be ready in
> a day (hopefully :)
>
>
> Takashi

Thanks for the answer. I just sent an email to request some technical=20
information from Terratec, emphasizing the importance to support the Linux=
=20
community.

Cheers
Eric


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
