From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: Aureal Vortex issues
Date: Mon, 7 Feb 2005 21:10:20 +0100
Message-ID: <200502072110.23565.alien999999999@users.sourceforge.net>
References: <W6056410510107771107660839@asteria.telenet-ops.be> <200502062319.29026.alien999999999@users.sourceforge.net> <1107798919.3259.16.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2562406.ur9bF8O2DZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
In-Reply-To: <1107798919.3259.16.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, mjander@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart2562406.ur9bF8O2DZ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op maandag 7 februari 2005 18:55, schreef Manuel Jander:
> Hi Maarten,
>
> On Sun, 2005-02-06 at 23:19 +0100, Alien wrote:
> > well, i finally got it working...
> >
> > it seems that since you changed the mmio address to a pointer to unsign=
ed
> > int, made the hwwrite wrong since it did a >>2 (on my 64bit platform th=
at
> > should be a >>3 ofcourse... i disabled some other code and it works
>
> AFAIK shifting byte offsets to make them dword offsets should just work
> on any platform. Its just plain PCI memory mapped I/O after all. By the
> way, the addresses defined in the header files are byte addresses.
>
> Have you tried a newer kernel ? Try a vanilla kernel with minimal patch
> contaminants if possible.
> I read that post regarding your emu10k1 oopsing too. AFAIK the emu10k1
> uses port i/o instead of mmio. That makes me think that if this oopses
> are linked somehow, the problem is either a widespread common mistake or
> somewhere deeper in the PCI i/o layer of the kernel.

those are two different oopses, the last one happens with with the snd-emu1=
0k1=20
as well as the snd-au8810 because it's the snd-hwdep that oopses, and that=
=20
happens when only when i get rid of all debug stuff (something about bad=20
scheduling...?)

> > i'll give you the changed files, you do with it what you want:
> >
> > not that it's better to define the mmio as a void* so that additions
> > involving that do not have to be >>2 or >>3 or whatever.
> >
> > i disabled the a3d routines and the vortex3D (since vortex3D was already
> > disabled with an #if 0 ...
>
> What "#if 0" do you mean ? In the current Alsa version in kernel 2.6.9
> the 3D sources are accesible and working for au8830's through the "a3d"
> PCM device.
> The 3D support code is very well tested. It is not considered unstable.
> The problem is that there is no library taking advantage of it (and
> coordinate mapping functions are missing).

i'm using alsa-1.0.8

the vortex_vort3D implementations are within an #if 0 so i commented the ca=
lls=20
to those functions as well. additionally, there is one a3d function that ha=
s=20
problems, so i commented that function call to it as well...

these _fixes_ is not what you should commit.

the mmio type i have changed to "void __iomem *" from "unsigned long __iome=
m=20
*", since if you'd to mmio+1 it would really mean mmio+sizeof(unsigned long=
)=20
which it countertargetted by having the addition in the hwwrite >>2 (only=20
works if unsigned long is 32bits of course ... those two changes, you can=20
commit.

there could be more problems related to 64bit, but i only have one machine =
and=20
it's a server, so i can't really afford to test on it, with kernel oopses=20
etc...

> Anyway, it makes me glad to know that you got working. I'll take at a
> look at your code changes ASAP and commit possible patches to the ALSA
> list, with credits to you of course.
>
> Best Regards, thanks.

the mmio typecast and changing of the hwwrite and hwread macro is the=20
important part, the a3d function i commented somewhere in the init has some=
=20
64bit issues, i'd be happy too look at it, but i can't really test, unless=
=20
i'm sure it'll work.

best regards

PS: the most unfortunate thing is that i do not have the time to get into t=
his=20
deeper, i have lotsa other things that need to be programmed.
=2D-=20
Alien is my name and head-biting is my game.

--nextPart2562406.ur9bF8O2DZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCB8svuBWKXETrtdcRAmrTAJ44vduOXka1rmzgHWh+K/Eb1P731wCgw3Df
oyCJqo38sf1rrjJxcmtufbI=
=5YX7
-----END PGP SIGNATURE-----

--nextPart2562406.ur9bF8O2DZ--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
