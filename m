From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ASoC: use DEFINE_SHOW_ATTRIBUTE() to
	decrease code duplication
Date: Fri, 9 Feb 2018 16:52:15 +0200
Message-ID: <CAHp75VfK=0-tzkHJj9i8Ne8WboD76xWFmn7AxUMqsaHXaf-bxw@mail.gmail.com>
References: <CAErzpmuKgMyxascCdq3KuF1F1K4e2ciZq7FKsOha6WSBgg-WYw@mail.gmail.com>
 <CAHp75Vdm3O5xiemr-H_nF__g43pe_f-Gp6QsOoRW-DXAXrm+YQ@mail.gmail.com>
 <CAErzpmuLvx-61EtXJ=p8dqZ3r-wLSEvmsLOcUz9jzzLzAAsxUA@mail.gmail.com>
 <CAErzpmuX+cTFseghapGdMy84Eg0SVe0niVrGdZhhpLP0uR_phQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F35D267813
 for <alsa-devel@alsa-project.org>; Fri,  9 Feb 2018 15:52:16 +0100 (CET)
Received: by mail-qt0-f195.google.com with SMTP id f18so10639229qth.11
 for <alsa-devel@alsa-project.org>; Fri, 09 Feb 2018 06:52:16 -0800 (PST)
In-Reply-To: <CAErzpmuX+cTFseghapGdMy84Eg0SVe0niVrGdZhhpLP0uR_phQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 9, 2018 at 4:43 PM, Donglin Peng <dolinux.peng@gmail.com> wrote:
> There is some duplicate code in soc-core.c, and the kernel provides
> DEFINE_SHOW_ATTRIBUTE() helper macro to decrease it in seq_file.h.
>

You missed my tag.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
> ---
> v2: [addressed comments from Andy]
>  * modify code change description
>  * do not rename m -> s
> ---
>  sound/soc/soc-core.c | 45 ++++++---------------------------------------
>  1 file changed, 6 insertions(+), 39 deletions(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 96c44f6576c9..f372f34d7702 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -349,7 +349,7 @@ static void soc_init_codec_debugfs(struct
> snd_soc_component *component)
>              "ASoC: Failed to create codec register debugfs file\n");
>  }
>
> -static int codec_list_seq_show(struct seq_file *m, void *v)
> +static int codec_list_show(struct seq_file *m, void *v)
>  {
>      struct snd_soc_codec *codec;
>
> @@ -362,20 +362,9 @@ static int codec_list_seq_show(struct seq_file *m, void *v)
>
>      return 0;
>  }
> +DEFINE_SHOW_ATTRIBUTE(codec_list);
>
> -static int codec_list_seq_open(struct inode *inode, struct file *file)
> -{
> -    return single_open(file, codec_list_seq_show, NULL);
> -}
> -
> -static const struct file_operations codec_list_fops = {
> -    .open = codec_list_seq_open,
> -    .read = seq_read,
> -    .llseek = seq_lseek,
> -    .release = single_release,
> -};
> -
> -static int dai_list_seq_show(struct seq_file *m, void *v)
> +static int dai_list_show(struct seq_file *m, void *v)
>  {
>      struct snd_soc_component *component;
>      struct snd_soc_dai *dai;
> @@ -390,20 +379,9 @@ static int dai_list_seq_show(struct seq_file *m, void *v)
>
>      return 0;
>  }
> +DEFINE_SHOW_ATTRIBUTE(dai_list);
>
> -static int dai_list_seq_open(struct inode *inode, struct file *file)
> -{
> -    return single_open(file, dai_list_seq_show, NULL);
> -}
> -
> -static const struct file_operations dai_list_fops = {
> -    .open = dai_list_seq_open,
> -    .read = seq_read,
> -    .llseek = seq_lseek,
> -    .release = single_release,
> -};
> -
> -static int platform_list_seq_show(struct seq_file *m, void *v)
> +static int platform_list_show(struct seq_file *m, void *v)
>  {
>      struct snd_soc_platform *platform;
>
> @@ -416,18 +394,7 @@ static int platform_list_seq_show(struct seq_file
> *m, void *v)
>
>      return 0;
>  }
> -
> -static int platform_list_seq_open(struct inode *inode, struct file *file)
> -{
> -    return single_open(file, platform_list_seq_show, NULL);
> -}
> -
> -static const struct file_operations platform_list_fops = {
> -    .open = platform_list_seq_open,
> -    .read = seq_read,
> -    .llseek = seq_lseek,
> -    .release = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(platform_list);
>
>  static void soc_init_card_debugfs(struct snd_soc_card *card)
>  {
> --
> 2.16.1



-- 
With Best Regards,
Andy Shevchenko
