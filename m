From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: Re: [PATCH v2 27/27] sound: ppc: remove unneeded memset after dma_alloc_coherent
Date: Fri, 28 Jun 2019 17:11:08 +0800
Message-ID: <CABXRUiT6jSP2xL9JyqngS9KBx_=fZ13x0UGGFPnQPrfh-_N5xQ@mail.gmail.com>
References: <20190628025055.16242-1-huangfq.daxian@gmail.com> <83108dee-72f7-e56f-95f6-26162c9a0ccc@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <83108dee-72f7-e56f-95f6-26162c9a0ccc@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Richard Fontana <rfontana@redhat.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Allison Randal <allison@lohutok.net>
List-Id: alsa-devel@alsa-project.org

The merge commit log tells (dma-mapping: zero memory returned from
dma_alloc_* and deprecating the dma_zalloc_coherent).
I used this commit just want to say that dma_alloc_coherent  has
zeroed the allocated memory.
Sorry for this mistake.

Maybe this commit 518a2f1925c3("dma-mapping: zero memory returned from
dma_alloc_*") is correct.

Christophe Leroy <christophe.leroy@c-s.fr> =E6=96=BC 2019=E5=B9=B46=E6=9C=
=8828=E6=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:59=E5=AF=AB=E9=81=93=
=EF=BC=9A

>
>
>
> Le 28/06/2019 =C3=A0 04:50, Fuqian Huang a =C3=A9crit :
> > In commit af7ddd8a627c
> > ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma=
-mapping"),
> > dma_alloc_coherent has already zeroed the memory.
> > So memset is not needed.
>
> You are refering to a merge commit, is that correct ?
>
> I can't see anything related in that commit, can you please pinpoint it ?
>
> As far as I can see, on powerpc the memory has always been zeroized
> (since 2005 at least).
>
> Christophe
>
> >
> > Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> > ---
> >   sound/ppc/pmac.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
> > index 1b11e53f6a62..1ab12f4f8631 100644
> > --- a/sound/ppc/pmac.c
> > +++ b/sound/ppc/pmac.c
> > @@ -56,7 +56,6 @@ static int snd_pmac_dbdma_alloc(struct snd_pmac *chip=
, struct pmac_dbdma *rec, i
> >       if (rec->space =3D=3D NULL)
> >               return -ENOMEM;
> >       rec->size =3D size;
> > -     memset(rec->space, 0, rsize);
> >       rec->cmds =3D (void __iomem *)DBDMA_ALIGN(rec->space);
> >       rec->addr =3D rec->dma_base + (unsigned long)((char *)rec->cmds -=
 (char *)rec->space);
> >
> >
