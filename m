From: =?ISO-8859-1?Q?Benny_Sj=F6strand?= <benny@hostmobility.com>
Subject: Re: [PATCH] cs46xx memory management fixes for cs46xx_dsp_spos_create()
 - make sure we free and don't do pointless work.
Date: Sat, 30 Oct 2010 00:18:57 +0200
Message-ID: <4CCB4851.7080701@hostmobility.com>
References: <alpine.LNX.2.00.1010292242080.24561@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1010292242080.24561@swampdragon.chaosbits.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello again!

Just doing a reply-all.
It's has been many years since I did anything to the cs46xx driver, so 
I'm wondering
if there's anyone out there still using a cs46xx sound card?
I think the changes look's correct, but I can't test it, I do not have a 
cs46xx hardware anymore.

/Benny

Jesper Juhl wrote:
> Hi,
>
> When reading through sound/pci/cs46xx/dsp_spos.c I noticed a couple of 
> things in cs46xx_dsp_spos_create().
>
> It seems to me that we don't always free the various memory buffers we 
> allocate and we also do some work (structure member assignment) early, 
> that is completely pointless if some of the memory allocations fail and 
> we end up just aborting the whole thing.
>
> I don't have hardware to test, so the patch below is compile tested only, 
> but it makes the following changes:
>
> - Make sure we always free all allocated memory on failures.
> - Don't do pointless work assigning to structure members before we know 
>   all memory allocations, that may abort progress, have completed 
>   successfully.
> - Remove some trailing whitespace.
>
> If it looks ok, please merge, otherwise I'd be interested in knowing 
> what's wrong so I can improve it.
>
>
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  dsp_spos.c |   33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
>
> diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
> index 3e5ca8f..e377287 100644
> --- a/sound/pci/cs46xx/dsp_spos.c
> +++ b/sound/pci/cs46xx/dsp_spos.c
> @@ -225,39 +225,25 @@ struct dsp_spos_instance *cs46xx_dsp_spos_create (struct snd_cs46xx * chip)
>  {
>  	struct dsp_spos_instance * ins = kzalloc(sizeof(struct dsp_spos_instance), GFP_KERNEL);
>  
> -	if (ins == NULL) 
> +	if (ins == NULL)
>  		return NULL;
>  
>  	/* better to use vmalloc for this big table */
> -	ins->symbol_table.nsymbols = 0;
>  	ins->symbol_table.symbols = vmalloc(sizeof(struct dsp_symbol_entry) *
>  					    DSP_MAX_SYMBOLS);
> -	ins->symbol_table.highest_frag_index = 0;
> -
> -	if (ins->symbol_table.symbols == NULL) {
> +	ins->code.data = kmalloc(DSP_CODE_BYTE_SIZE, GFP_KERNEL);
> +	ins->modules = kmalloc(sizeof(struct dsp_module_desc) * DSP_MAX_MODULES, GFP_KERNEL);
> +	if (!ins->symbol_table.symbols || !ins->code.data || !ins->modules) {
>  		cs46xx_dsp_spos_destroy(chip);
>  		goto error;
>  	}
> -
> +	ins->symbol_table.nsymbols = 0;
> +	ins->symbol_table.highest_frag_index = 0;
>  	ins->code.offset = 0;
>  	ins->code.size = 0;
> -	ins->code.data = kmalloc(DSP_CODE_BYTE_SIZE, GFP_KERNEL);
> -
> -	if (ins->code.data == NULL) {
> -		cs46xx_dsp_spos_destroy(chip);
> -		goto error;
> -	}
> -
>  	ins->nscb = 0;
>  	ins->ntask = 0;
> -
>  	ins->nmodules = 0;
> -	ins->modules = kmalloc(sizeof(struct dsp_module_desc) * DSP_MAX_MODULES, GFP_KERNEL);
> -
> -	if (ins->modules == NULL) {
> -		cs46xx_dsp_spos_destroy(chip);
> -		goto error;
> -	}
>  
>  	/* default SPDIF input sample rate
>  	   to 48000 khz */
> @@ -271,8 +257,8 @@ struct dsp_spos_instance *cs46xx_dsp_spos_create (struct snd_cs46xx * chip)
>  
>  	/* set left and right validity bits and
>  	   default channel status */
> -	ins->spdif_csuv_default = 
> -		ins->spdif_csuv_stream =  
> +	ins->spdif_csuv_default =
> +		ins->spdif_csuv_stream =
>  	 /* byte 0 */  ((unsigned int)_wrap_all_bits(  (SNDRV_PCM_DEFAULT_CON_SPDIF        & 0xff)) << 24) |
>  	 /* byte 1 */  ((unsigned int)_wrap_all_bits( ((SNDRV_PCM_DEFAULT_CON_SPDIF >> 8) & 0xff)) << 16) |
>  	 /* byte 3 */   (unsigned int)_wrap_all_bits(  (SNDRV_PCM_DEFAULT_CON_SPDIF >> 24) & 0xff) |
> @@ -281,6 +267,9 @@ struct dsp_spos_instance *cs46xx_dsp_spos_create (struct snd_cs46xx * chip)
>  	return ins;
>  
>  error:
> +	kfree(ins->modules);
> +	kfree(ins->code.data);
> +	vfree(ins->symbol_table.symbols);
>  	kfree(ins);
>  	return NULL;
>  }
>
>
>   
