From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] Maestro2 hw volume fix
Date: Tue, 17 Feb 2004 18:51:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040217165134.GA16527@sci.fi>
References: <20040217062041.GA6708@sci.fi> <s5h1xotyavv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1xotyavv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 17, 2004 at 04:38:12PM +0100, Takashi Iwai wrote:
> At Tue, 17 Feb 2004 08:20:41 +0200,
> Ville Syrj=E4l=E4 wrote:
> >=20
> > [1  <text/plain; iso-8859-1 (quoted-printable)>]
> > The attached patch fixes hardware volume buttons on my Dell Inspiron =
7000=20
> > laptop. The chip is ESS Maestro2 (0x125d:0x1968).
> >=20
> > I have no idea if this will break things for someone else. Since the=20
> > datasheet didn't help me understand the registers involved I just pri=
nted=20
> > their contents and came up with the used bits.
> >=20
> > All registers had the following values in my tests:
> > mute:     0x99
> > vol down: 0x77
> > vol up:   0xBB
>=20
> these values (9, 7, b) are consistent always?

So it would appear. I've tried hitting the buttons in various combination=
s=20
and the values have been consistent.

The only thing that is a bit odd is that after hitting the mute button th=
e=20
next vol up/down doesn't generate an interrupt at all. Only the next pres=
s=20
after that actually works. But that is a hardware issue.

> i'm also not sure whether it's hardware specific...

The device has a subsystem id 0x1028:0x0085 should there be a need to add=
=20
hw specific stuff.



The code in maestro.tar.gz uses GPIO data register 0x60 to check for mute=
=20
button press. That would actually work on my system but I don't see much=20
point in checking another register when 0x1C is enough.

The vol up/down test in that code checks for difference between 0x1E and=20
0x1F. That would not work on my system because all registers 0x1C-0x1F=20
have identical values.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
