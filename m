From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH] cs46xx memory management fixes for
	cs46xx_dsp_spos_create() - make sure we free and don't do
	pointless work.
Date: Sat, 30 Oct 2010 14:06:07 +0200
Message-ID: <201010301406.12961.linux@rainbow-software.org>
References: <alpine.LNX.2.00.1010292242080.24561@swampdragon.chaosbits.net>
	<4CCB4851.7080701@hostmobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail1-out1.atlantis.sk [80.94.52.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 59A8C103872
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Oct 2010 14:06:29 +0200 (CEST)
In-Reply-To: <4CCB4851.7080701@hostmobility.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Benny =?iso-8859-1?q?Sj=F6strand?= <benny@hostmobility.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jesper Juhl <jj@chaosbits.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Saturday 30 October 2010 00:18:57 Benny Sj=F6strand wrote:
> Hello again!
>
> Just doing a reply-all.
> It's has been many years since I did anything to the cs46xx driver, so
> I'm wondering
> if there's anyone out there still using a cs46xx sound card?
> I think the changes look's correct, but I can't test it, I do not have a
> cs46xx hardware anymore.

Sure, there are many of these cards "out there". I just got a "new" Terrate=
c =

DMX Xfire 1024 (CS4624). I'll test the patch.

>
> /Benny
>
> Jesper Juhl wrote:
> > Hi,
> >
> > When reading through sound/pci/cs46xx/dsp_spos.c I noticed a couple of
> > things in cs46xx_dsp_spos_create().
> >
> > It seems to me that we don't always free the various memory buffers we
> > allocate and we also do some work (structure member assignment) early,
> > that is completely pointless if some of the memory allocations fail and
> > we end up just aborting the whole thing.
> >
> > I don't have hardware to test, so the patch below is compile tested onl=
y,
> > but it makes the following changes:
> >
> > - Make sure we always free all allocated memory on failures.
> > - Don't do pointless work assigning to structure members before we know
> >   all memory allocations, that may abort progress, have completed
> >   successfully.
> > - Remove some trailing whitespace.
> >
> > If it looks ok, please merge, otherwise I'd be interested in knowing
> > what's wrong so I can improve it.
> >
> >
> > Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> > ---
> >  dsp_spos.c |   33 +++++++++++----------------------
> >  1 file changed, 11 insertions(+), 22 deletions(-)
> >
> > diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
> > index 3e5ca8f..e377287 100644
> > --- a/sound/pci/cs46xx/dsp_spos.c
> > +++ b/sound/pci/cs46xx/dsp_spos.c
> > @@ -225,39 +225,25 @@ struct dsp_spos_instance *cs46xx_dsp_spos_create
> > (struct snd_cs46xx * chip) {
> >  	struct dsp_spos_instance * ins =3D kzalloc(sizeof(struct
> > dsp_spos_instance), GFP_KERNEL);
> >
> > -	if (ins =3D=3D NULL)
> > +	if (ins =3D=3D NULL)
> >  		return NULL;
> >
> >  	/* better to use vmalloc for this big table */
> > -	ins->symbol_table.nsymbols =3D 0;
> >  	ins->symbol_table.symbols =3D vmalloc(sizeof(struct dsp_symbol_entry)=
 *
> >  					    DSP_MAX_SYMBOLS);
> > -	ins->symbol_table.highest_frag_index =3D 0;
> > -
> > -	if (ins->symbol_table.symbols =3D=3D NULL) {
> > +	ins->code.data =3D kmalloc(DSP_CODE_BYTE_SIZE, GFP_KERNEL);
> > +	ins->modules =3D kmalloc(sizeof(struct dsp_module_desc) *
> > DSP_MAX_MODULES, GFP_KERNEL); +	if (!ins->symbol_table.symbols ||
> > !ins->code.data || !ins->modules) { cs46xx_dsp_spos_destroy(chip);
> >  		goto error;
> >  	}
> > -
> > +	ins->symbol_table.nsymbols =3D 0;
> > +	ins->symbol_table.highest_frag_index =3D 0;
> >  	ins->code.offset =3D 0;
> >  	ins->code.size =3D 0;
> > -	ins->code.data =3D kmalloc(DSP_CODE_BYTE_SIZE, GFP_KERNEL);
> > -
> > -	if (ins->code.data =3D=3D NULL) {
> > -		cs46xx_dsp_spos_destroy(chip);
> > -		goto error;
> > -	}
> > -
> >  	ins->nscb =3D 0;
> >  	ins->ntask =3D 0;
> > -
> >  	ins->nmodules =3D 0;
> > -	ins->modules =3D kmalloc(sizeof(struct dsp_module_desc) *
> > DSP_MAX_MODULES, GFP_KERNEL); -
> > -	if (ins->modules =3D=3D NULL) {
> > -		cs46xx_dsp_spos_destroy(chip);
> > -		goto error;
> > -	}
> >
> >  	/* default SPDIF input sample rate
> >  	   to 48000 khz */
> > @@ -271,8 +257,8 @@ struct dsp_spos_instance *cs46xx_dsp_spos_create
> > (struct snd_cs46xx * chip)
> >
> >  	/* set left and right validity bits and
> >  	   default channel status */
> > -	ins->spdif_csuv_default =3D
> > -		ins->spdif_csuv_stream =3D
> > +	ins->spdif_csuv_default =3D
> > +		ins->spdif_csuv_stream =3D
> >  	 /* byte 0 */  ((unsigned int)_wrap_all_bits( =

> > (SNDRV_PCM_DEFAULT_CON_SPDIF        & 0xff)) << 24) | /* byte 1 */ =

> > ((unsigned int)_wrap_all_bits( ((SNDRV_PCM_DEFAULT_CON_SPDIF >> 8) &
> > 0xff)) << 16) | /* byte 3 */   (unsigned int)_wrap_all_bits( =

> > (SNDRV_PCM_DEFAULT_CON_SPDIF >> 24) & 0xff) | @@ -281,6 +267,9 @@ struct
> > dsp_spos_instance *cs46xx_dsp_spos_create (struct snd_cs46xx * chip)
> > return ins;
> >
> >  error:
> > +	kfree(ins->modules);
> > +	kfree(ins->code.data);
> > +	vfree(ins->symbol_table.symbols);
> >  	kfree(ins);
> >  	return NULL;
> >  }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- =

Ondrej Zary
