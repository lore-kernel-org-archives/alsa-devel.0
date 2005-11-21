From: Miles Lane <miles.lane@gmail.com>
Subject: Re: 2.6.15-rc1-mm2 -- Bad page state at free_hot_cold_page (in process 'aplay', page c18eef30)
Date: Sun, 20 Nov 2005 22:59:59 -0800
Message-ID: <a44ae5cd0511202259q71d2ef1fk294277225f848937@mail.gmail.com>
References: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com>
	 <Pine.LNX.4.61.0511200804500.3938@goblin.wat.veritas.com>
	 <1132510467.6874.144.camel@mindpipe>
	 <Pine.LNX.4.61.0511201915530.8619@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0511201915530.8619@goblin.wat.veritas.com>
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
To: Hugh Dickins <hugh@veritas.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 11/20/05, Hugh Dickins <hugh@veritas.com> wrote:
> On Sun, 20 Nov 2005, Lee Revell wrote:
> > (Added alsa-devel to cc:)
> >
> > Will this change have any ill effects on older kernels?
>
> I think not (except 2.6.5 and earlier didn't define __GFP_COMP).
>
> > If not we should fix it in the ALSA tree right?
>
> Probably, but I'm no authority on the ALSA tree.
>
> And suggest you wait a bit, since I haven't yet signed off on the
> patch that piece will be a part of.
>
> And what about the patch at the bottom (which I had CC'ed to Karsten
> Wiese), is that part of the ALSA tree too?  That case isn't so easy:
> the get_page makes a difference, and probably it was right not to do
> it before, yet strange it was the only nopage in the tree which didn't
> get_page.
>
> Hugh
>
> > Lee
> >
> > On Sun, 2005-11-20 at 08:05 +0000, Hugh Dickins wrote:
> > > On Sat, 19 Nov 2005, Miles Lane wrote:
> > > > [17179671.700000] Bad page state at free_hot_cold_page (in process
> > > > 'aplay', page c18eef30)
> > > > [17179671.700000] flags:0x80000414 mapping:00000000 mapcount:0 coun=
t:0
> > >
> > > Please let me know if it's not fixed by:
> > >
> > > --- 2.6.15-rc1-mm2/sound/core/memalloc.c    2005-11-12 09:01:28.00000=
0000 +0000
> > > +++ linux/sound/core/memalloc.c     2005-11-19 19:03:32.000000000 +00=
00
> > > @@ -197,6 +197,7 @@ void *snd_malloc_pages(size_t size, gfp_
> > >
> > >     snd_assert(size > 0, return NULL);
> > >     snd_assert(gfp_flags !=3D 0, return NULL);
> > > +   gfp_flags |=3D __GFP_COMP;        /* compound page lets parts be =
mapped */
> > >     pg =3D get_order(size);
> > >     if ((res =3D (void *) __get_free_pages(gfp_flags, pg)) !=3D NULL)=
 {
> > >             mark_pages(virt_to_page(res), pg);
> > > @@ -241,6 +242,7 @@ static void *snd_malloc_dev_pages(struct
> > >     snd_assert(dma !=3D NULL, return NULL);
> > >     pg =3D get_order(size);
> > >     gfp_flags =3D GFP_KERNEL
> > > +           | __GFP_COMP    /* compound page lets parts be mapped */
> > >             | __GFP_NORETRY /* don't trigger OOM-killer */
> > >             | __GFP_NOWARN; /* no stack trace print - this call is no=
n-critical */
> > >     res =3D dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);

Thanks, this did fix the problem for me.

         Miles


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
