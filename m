From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: I want to dmix for my MIPS board, how can I do?
Date: Mon, 07 Mar 2005 14:47:33 -0500
Message-ID: <1110224854.935.7.camel@mindpipe>
References: <BAY16-DAV3AADC75FFB21EB73AE296E95F0@phx.gbl>
	 <1110224111.935.5.camel@mindpipe>  <s5hll8zutop.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <s5hll8zutop.wl@alsa2.suse.de>
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
Cc: li_jiankun@hotmail.com, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-03-07 at 20:44 +0100, Takashi Iwai wrote:
> At Mon, 07 Mar 2005 14:35:10 -0500,
> Lee Revell wrote:
> >=20
> > On Mon, 2005-03-07 at 22:24 +0800, =E6=9D=8E=E5=BB=BA=E5=9D=A4 wrote:
> > > alsa-devel=EF=BC=8C
> > >=20
> > >   I'm an device driver developer for MIPS board. Now, I'm in urgent=
 need of dmix source code for my Achemy board.
> > >   I want to dmix on my MIPS Au1x00 board, Segmentation Fault occurs=
. I look up the code of pcm_dmix.c for possible reason,=20
> > >   it says,
> > >     #warning Please, recode mix_areas1() routine to your architectu=
re...
> > > 	warning Please, recode mix_areas2() routine to your architecture..=
.
> > >   Does it mean the dmix can only be used on X86 architecture now?
> > >   if I want to use it on my MIPS board, how can I do?=20
> > >  =20
> > >   Looking forward to anyone's reply! Tanks in advance!
> >=20
> > Yup, that's exactly what it means.  Dmix is only implemented for x86
> > now.  If you want to use it on another arch you have to code it
> > yourself.
> >=20
> > But, isn't there a cleaner way to handle this than segfaulting?  Why =
do
> > we even compile the plugin for non-x86 archs?
>=20
> Well, segfault is not intended, of course :)
>=20
> Does the segfault still happen with the CVS version?
> If so, there must be something wrong in another part (e.g. the general
> mmap support on MIPS).

IIRC someone else reported a segfault trying to use dmix with another
unsupported arch.  So this led me to believe the problem was related.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
