From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 3/5] sound: soc: codecs: wm_adsp: no need
 to check return value of debugfs_create functions
Date: Fri, 14 Jun 2019 11:24:39 +0100
Message-ID: <acbebcc1-810a-c16e-0413-84bb1c5417ca@opensource.cirrus.com>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
 <20190614094756.2965-3-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE755F896EA
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 12:24:42 +0200 (CEST)
In-Reply-To: <20190614094756.2965-3-gregkh@linuxfoundation.org>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 14/06/19 10:47, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: <patches@opensource.cirrus.com>
> Cc: <alsa-devel@alsa-project.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   sound/soc/codecs/wm_adsp.c | 37 +++++++------------------------------
>   1 file changed, 7 insertions(+), 30 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> index b26e6b825a90..8f301cb07745 100644
> --- a/sound/soc/codecs/wm_adsp.c
> +++ b/sound/soc/codecs/wm_adsp.c
> @@ -731,41 +731,18 @@ static void wm_adsp2_init_debugfs(struct wm_adsp *dsp,
>   	struct dentry *root = NULL;
>   	int i;
>   
> -	if (!component->debugfs_root) {
> -		adsp_err(dsp, "No codec debugfs root\n");
> -		goto err;
> -	}
> -
>   	root = debugfs_create_dir(dsp->name, component->debugfs_root);
>   
> -	if (!root)
> -		goto err;
> -
> -	if (!debugfs_create_bool("booted", 0444, root, &dsp->booted))
> -		goto err;
> +	debugfs_create_bool("booted", 0444, root, &dsp->booted);
> +	debugfs_create_bool("running", 0444, root, &dsp->running);
> +	debugfs_create_x32("fw_id", 0444, root, &dsp->fw_id);
> +	debugfs_create_x32("fw_version", 0444, root, &dsp->fw_id_version);
>   
> -	if (!debugfs_create_bool("running", 0444, root, &dsp->running))
> -		goto err;
> -
> -	if (!debugfs_create_x32("fw_id", 0444, root, &dsp->fw_id))
> -		goto err;
> -
> -	if (!debugfs_create_x32("fw_version", 0444, root, &dsp->fw_id_version))
> -		goto err;
> -
> -	for (i = 0; i < ARRAY_SIZE(wm_adsp_debugfs_fops); ++i) {
> -		if (!debugfs_create_file(wm_adsp_debugfs_fops[i].name,
> -					 0444, root, dsp,
> -					 &wm_adsp_debugfs_fops[i].fops))
> -			goto err;
> -	}
> +	for (i = 0; i < ARRAY_SIZE(wm_adsp_debugfs_fops); ++i)
> +		debugfs_create_file(wm_adsp_debugfs_fops[i].name, 0444, root,
> +				    dsp, &wm_adsp_debugfs_fops[i].fops);
>   
>   	dsp->debugfs_root = root;
> -	return;
> -
> -err:
> -	debugfs_remove_recursive(root);
> -	adsp_err(dsp, "Failed to create debugfs\n");
>   }
>   
>   static void wm_adsp2_cleanup_debugfs(struct wm_adsp *dsp)
> 

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
