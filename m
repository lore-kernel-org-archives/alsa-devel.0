From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Subject: Re: [PATCH] ASoC: sof: Fix warning when IPC flood test
 is not enabled
Date: Thu, 8 Aug 2019 15:35:39 -0700
Message-ID: <CAFQqKeXnC9fmwBna-BV+0j2L2XQM1BsO=gFT_JoM9-eM02ffFA@mail.gmail.com>
References: <20190808221850.25963-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4452CF800E3
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2019 00:35:51 +0200 (CEST)
Received: by mail-yb1-xb41.google.com with SMTP id e11so8364475ybq.9
 for <alsa-devel@alsa-project.org>; Thu, 08 Aug 2019 15:35:51 -0700 (PDT)
In-Reply-To: <20190808221850.25963-1-broonie@kernel.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 8, 2019 at 3:21 PM Mark Brown <broonie@kernel.org> wrote:

> dentry is only used when the flood test is done so move the declaration
> of the variable inside the ifdef for the flood test.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
>
Looks good, thanks, Mark.
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

> ---
>  sound/soc/sof/debug.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
> index 40940b2fe9d5..54cd431faab7 100644
> --- a/sound/soc/sof/debug.c
> +++ b/sound/soc/sof/debug.c
> @@ -221,7 +221,6 @@ static ssize_t sof_dfsentry_read(struct file *file,
> char __user *buffer,
>  {
>         struct snd_sof_dfsentry *dfse = file->private_data;
>         struct snd_sof_dev *sdev = dfse->sdev;
> -       struct dentry *dentry;
>         loff_t pos = *ppos;
>         size_t size_ret;
>         int skip = 0;
> @@ -229,6 +228,8 @@ static ssize_t sof_dfsentry_read(struct file *file,
> char __user *buffer,
>         u8 *buf;
>
>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST)
> +       struct dentry *dentry;
> +
>         dentry = file->f_path.dentry;
>         if ((!strcmp(dentry->d_name.name, "ipc_flood_count") ||
>              !strcmp(dentry->d_name.name, "ipc_flood_duration_ms")) &&
> --
> 2.20.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
