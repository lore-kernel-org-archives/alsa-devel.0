From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: Re: [PATCH 30/30] sound/soc: Use kmemdup rather than duplicating its implementation
Date: Wed, 3 Jul 2019 22:58:43 +0800
Message-ID: <CABXRUiQH2c5knAxnegNc1J2uyqy3OVU=qEorcZkUtMoJhvb_8Q@mail.gmail.com>
References: <20190703131842.26082-1-huangfq.daxian@gmail.com> <547c68b0-f55f-ca1d-c5b3-f6a5f89d93a9@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <547c68b0-f55f-ca1d-c5b3-f6a5f89d93a9@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Ok, I will separate them into two patches in the v2 patch set. Also,
there is a typo in the v1(memset should be memcpy).

Richard Fitzgerald <rf@opensource.cirrus.com> =E6=96=BC 2019=E5=B9=B47=E6=
=9C=883=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:55=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On 03/07/19 14:18, Fuqian Huang wrote:
> > kmemdup is introduced to duplicate a region of memory in a neat way.
> > Rather than kmalloc/kzalloc + memset, which the programmer needs to
> > write the size twice (sometimes lead to mistakes), kmemdup improves
> > readability, leads to smaller code and also reduce the chances of mista=
kes.
> > Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.
> >
> > Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> > ---
> >   sound/soc/codecs/wm0010.c             | 4 +---
> >   sound/soc/intel/atom/sst/sst_loader.c | 3 +--
>
> Should be one patch per file as the drivers are not related to each
> other at all, and if one needed a revert you couldn't revert this
> patch because it would revert both drivers.
>
> But apart from that, for wm0010.c:
> Acked-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>
> >   2 files changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
> > index 727d6703c905..807826f30f58 100644
> > --- a/sound/soc/codecs/wm0010.c
> > +++ b/sound/soc/codecs/wm0010.c
> > @@ -515,7 +515,7 @@ static int wm0010_stage2_load(struct snd_soc_compon=
ent *component)
> >       dev_dbg(component->dev, "Downloading %zu byte stage 2 loader\n", =
fw->size);
> >
> >       /* Copy to local buffer first as vmalloc causes problems for dma =
*/
> > -     img =3D kzalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > +     img =3D kmemdup(&fw->data[0], fw->size, GFP_KERNEL | GFP_DMA);
> >       if (!img) {
> >               ret =3D -ENOMEM;
> >               goto abort2;
> > @@ -527,8 +527,6 @@ static int wm0010_stage2_load(struct snd_soc_compon=
ent *component)
> >               goto abort1;
> >       }
> >
> > -     memcpy(img, &fw->data[0], fw->size);
> > -
> >       spi_message_init(&m);
> >       memset(&t, 0, sizeof(t));
> >       t.rx_buf =3D out;
> > diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/at=
om/sst/sst_loader.c
> > index ce11c36848c4..cc95af35c060 100644
> > --- a/sound/soc/intel/atom/sst/sst_loader.c
> > +++ b/sound/soc/intel/atom/sst/sst_loader.c
> > @@ -288,14 +288,13 @@ static int sst_cache_and_parse_fw(struct intel_ss=
t_drv *sst,
> >   {
> >       int retval =3D 0;
> >
> > -     sst->fw_in_mem =3D kzalloc(fw->size, GFP_KERNEL);
> > +     sst->fw_in_mem =3D kmemdup(fw->data, fw->size, GFP_KERNEL);
> >       if (!sst->fw_in_mem) {
> >               retval =3D -ENOMEM;
> >               goto end_release;
> >       }
> >       dev_dbg(sst->dev, "copied fw to %p", sst->fw_in_mem);
> >       dev_dbg(sst->dev, "phys: %lx", (unsigned long)virt_to_phys(sst->f=
w_in_mem));
> > -     memcpy(sst->fw_in_mem, fw->data, fw->size);
> >       retval =3D sst_parse_fw_memcpy(sst, fw->size, &sst->memcpy_list);
> >       if (retval) {
> >               dev_err(sst->dev, "Failed to parse fw\n");
> >
>
