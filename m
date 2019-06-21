From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2] ASoC: core: Adapt for debugfs API change
Date: Fri, 21 Jun 2019 15:20:40 +0200
Message-ID: <20190621132040.GA10459@kroah.com>
References: <20190621113357.8264-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621113357.8264-1-broonie@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 21, 2019 at 12:33:56PM +0100, Mark Brown wrote:
> Back in ff9fb72bc07705c (debugfs: return error values, not NULL) the
> debugfs APIs were changed to return error pointers rather than NULL
> pointers on error, breaking the error checking in ASoC. Update the
> code to use IS_ERR() and log the codes that are returned as part of
> the error messages.
> 
> Fixes: ff9fb72bc07705c (debugfs: return error values, not NULL)
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  sound/soc/soc-core.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index c510da2d4af6..6d5c09493f4b 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -165,9 +165,10 @@ static void soc_init_component_debugfs(struct snd_soc_component *component)
>  				component->card->debugfs_card_root);
>  	}
>  
> -	if (!component->debugfs_root) {
> +	if (IS_ERR(component->debugfs_root)) {
>  		dev_warn(component->dev,
> -			"ASoC: Failed to create component debugfs directory\n");
> +			"ASoC: Failed to create component debugfs directory: %ld\n",
> +			PTR_ERR(component->debugfs_root));

Why warn on this?  You will _never_ see this message :)

>  		return;
>  	}
>  
> @@ -219,18 +220,21 @@ static void soc_init_card_debugfs(struct snd_soc_card *card)
>  
>  	card->debugfs_card_root = debugfs_create_dir(card->name,
>  						     snd_soc_debugfs_root);
> -	if (!card->debugfs_card_root) {
> +	if (IS_ERR(card->debugfs_card_root)) {
>  		dev_warn(card->dev,
> -			 "ASoC: Failed to create card debugfs directory\n");
> +			 "ASoC: Failed to create card debugfs directory: %ld\n",
> +			 PTR_ERR(card->debugfs_card_root));
> +		card->debugfs_card_root = NULL;

Same here.

And keep card->debugfs_card_root to be the error pointer, that way no
further files are created for that directory.

thanks,

greg k-h
