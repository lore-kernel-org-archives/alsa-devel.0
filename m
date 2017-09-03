From: Wang YanQing <udknight@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Fix resource leak issue in
 snd_hda_codec_build_controls and snd_hda_codec_parse_pcms
Date: Mon, 4 Sep 2017 00:10:53 +0800
Message-ID: <20170903161053.GA27449@udknight>
References: <20170903152731.GA27302@udknight>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170903152731.GA27302@udknight>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 03, 2017 at 11:27:31PM +0800, Wang YanQing wrote:
> When patch_ops.init, patch_ops.build_pcms and patch_ops.build_controls
> return failure, we need to free resource with patch_ops.free, or we will
> get resource leak.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>  sound/pci/hda/hda_codec.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index df6b57e..4e3e613 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -2973,8 +2973,11 @@ int snd_hda_codec_build_controls(struct hda_codec *codec)
>  		err = codec->patch_ops.init(codec);
>  	if (!err && codec->patch_ops.build_controls)
>  		err = codec->patch_ops.build_controls(codec);
> -	if (err < 0)
> +	if (err < 0) {
> +		if (codec->patch_ops.free)
> +			codec->patch_ops.free(codec);
>  		return err;
> +	}
>  
>  	/* we create chmaps here instead of build_pcms */
>  	err = add_std_chmaps(codec);
> @@ -3170,6 +3173,8 @@ int snd_hda_codec_parse_pcms(struct hda_codec *codec)
>  	if (err < 0) {
>  		codec_err(codec, "cannot build PCMs for #%d (error %d)\n",
>  			  codec->core.addr, err);
> +		if (codec->patch_ops.free)
> +			codec->patch_ops.free(codec);
>  		return err;
>  	}
>  
> -- 
> 1.8.5.6.2.g3d8a54e.dirty

I don't know whether this new patch is ok for you, but I think that
we could allocate resources in patch_ops.init, patch_ops.build_pcms
and patch_ops.build_controls separately, so I think it isn't flexible
and elegant to free all resources in all the error path cases in them
separately, so maybe it is better to use patch_ops.free as the unique
point to release all resource.

Thanks.
