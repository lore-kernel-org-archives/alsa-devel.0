From: jayakumar alsa <jayakumar.alsa@gmail.com>
Subject: Re: [PATCH 2.6.13.1 1/1] CS5535 AUDIO ALSA driver
Date: Tue, 20 Sep 2005 20:03:40 -0400
Message-ID: <47f5dce305092017031a2ba375@mail.gmail.com>
References: <200509190639.j8J6dIM4007948@localhost.localdomain>
	 <20050920152830.7ef6733b.akpm@osdl.org>
Reply-To: jayakumar.alsa@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050920152830.7ef6733b.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: perex@suse.cz, mj@ucw.cz, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 9/20/05, Andrew Morton <akpm@osdl.org> wrote:
> By convention we put the asm/ includes after the linux/ includes.

Will do. Thanks for the detailed review!

>=20
> > +
> > +static unsigned short snd_cs5535audio_codec_read(cs5535audio_t *cs5535=
au,
>=20
> typedefs are unpopular in-kernel.  We generally don't get too fussed if a
> driver maintainer really wants them there.  The main objection is that we
> now have two names for the same thing.  Plus they cannot be used when
> forward-declaring a structure.

I just used those typedefs in order to match the style in all the
other alsa drivers. For example:

% egrep typedef $lintree/sound/pci/*.c
als4000.c:typedef struct {
atiixp.c:typedef struct snd_atiixp atiixp_t;
atiixp.c:typedef struct snd_atiixp_dma atiixp_dma_t;
atiixp.c:typedef struct snd_atiixp_dma_ops atiixp_dma_ops_t;
atiixp.c:typedef struct atiixp_dma_desc {
azt3328.c:typedef struct _snd_azf3328 azf3328_t;
azt3328.c:typedef struct azf3328_mixer_reg {
bt87x.c:typedef struct snd_bt87x bt87x_t;
cmipci.c:typedef struct snd_stru_cmipci cmipci_t;
<snip>

I'm not sure what to do. I'd be happy to take them out. But I woudn't
mind leaving them in if that's what alsa convention is.

> This isn't right.  `timeout' will have a value of -1 if we timed out.
> (several instances).

How embarrassing. Will fix. :-)

> Ditto.  Plus we prefer to not put braces around a single statement like t=
his.

Will fix.

> Again.  Perhaps a helper function so this code (and its bug) don't get
> duplicated so much?

Will do.

>=20
> We normally put a space after commas.
>=20
> Unneeded typecast.

Will fix.

>=20
> > +             dma->index =3D (++(dma->index)) % dma->periods;
>=20
> Is no locking needed for dma->index?

Looks like I stopped using index after I found I don't need to track
the individual descriptors. I'll take it out.

>=20
> Just to save a tabstop.

Will do.

> > +     }
> > +     return IRQ_HANDLED;
> > +}
>=20
> Perhaps the default case should return IRQ_NONE.

In this case I think the code is correct as it is. I check that in the
top level irq status register if the irq was from the cs5535 audio. I
return NONE if it wasn't there. Then I proceed to read a bunch of
other registers, all with the assumption that the irq was from us. I
return HANDLED at that point since reading those other registers has
cleared any irq from us even if it was from an unexpected src.

> > +     cs5535au =3D kcalloc(1, sizeof(*cs5535au), GFP_KERNEL);
>=20
> We have kzalloc() now.

Yes, Takashi pointed that out too. But I did the patch against 13.1
which doesn't have kzalloc. I guess I'll redo the patch against -mm
and switch to kzalloc.

> Please consider reworking functions such as the above so as to have a
> single `reutrn' statement.  Or one `return' for success and just one for
> the error paths.  Reason: a) it's easier to chack that all resources are
> being freed on the error paths and b) It's easier to add new stuff which
> allocates new resources which need to be released on error paths.  Involv=
es
> goto spaghetti.

Will do.

>=20
> The handling of `dev' is racy ;)

Ok. Will look at that.

>=20
> > +     addr =3D (u32)substream->runtime->dma_addr;
>=20
> Nope, _snd_pcm_runtime.addr has type dma_addr_t, which is an opaque type,
> 64-bit on some platforms.  I expect this driver will blow up on those
> platforms.

The 5535 hw's dma descriptor is only 32 bit capable. I guess I should
look into informing the dma alloc that the buffers need to be in the
lower 32. Would it be okay to drop the upper then?

>From a practical standpoint, the 5535 is only used in x86-32
embeddeded systems so high mem probably won't occur. But you are
right, I'll go and try make it right.

> +#define cs_writel(reg, val)    outl(val, (int) cs5535au->port + reg)
> +#define cs_writeb(reg, val)    outb(val, (int) cs5535au->port + reg)
> +#define cs_readl(reg)          inl((unsigned short) (cs5535au->port + re=
g))
> +#define cs_readw(reg)          inw((unsigned short) (cs5535au->port + re=
g))
> +#define cs_readb(reg)          inb((unsigned short) (cs5535au->port + re=
g))
>=20
> erk.   subsystem-wide helper macros which reference local variables?

Ok. I'll change that.

Thanks,
jk


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
