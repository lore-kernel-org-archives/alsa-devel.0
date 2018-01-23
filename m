From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ASoC: use seq_file to dump the contents
 of dai_list, platform_list and codec_list
Date: Tue, 23 Jan 2018 19:08:15 +0200
Message-ID: <CAHp75VcefO1L-E8ymHX7MibLiOXkRZ3+3FbkF_L+ywMV-i3Mvw@mail.gmail.com>
References: <20180118053126.22082-1-dolinux.peng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 10263267044
 for <alsa-devel@alsa-project.org>; Tue, 23 Jan 2018 18:08:17 +0100 (CET)
Received: by mail-qt0-f195.google.com with SMTP id s39so3118388qth.7
 for <alsa-devel@alsa-project.org>; Tue, 23 Jan 2018 09:08:17 -0800 (PST)
In-Reply-To: <20180118053126.22082-1-dolinux.peng@gmail.com>
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

On Thu, Jan 18, 2018 at 7:31 AM, Donglin Peng <dolinux.peng@gmail.com> wrote:
> Now the debugfs files dais/platforms/codecs have a size limit PAGE_SIZE and
> the user can not see the whole contents of dai_list/platform_list/codec_list
> when they are larger than this limit.
>
> This patch uses seq_file instead to make sure dais/platforms/codecs show the
> full contents of dai_list/platform_list/codec_list.

If it's not critical, I would suggest to wait till v4.16-rc1, where I
would like to push [1], and switch to DEFINE_SHOW_ATTRIBUTE() macro.


> +static int codec_list_seq_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, codec_list_seq_show, NULL);
>  }
>
>  static const struct file_operations codec_list_fops = {
> +       .open = codec_list_seq_open,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +       .release = single_release,
>  };

This will be just

DEFINE_SHOW_ATTRIBUTE(codec_list_seq);

> +static int dai_list_seq_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, dai_list_seq_show, NULL);
>  }
>
>  static const struct file_operations dai_list_fops = {
> +       .open = dai_list_seq_open,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +       .release = single_release,
>  };

Ditto.

> +static int platform_list_seq_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, platform_list_seq_show, NULL);
>  }
>
>  static const struct file_operations platform_list_fops = {
> +       .open = platform_list_seq_open,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +       .release = single_release,
>  };

Ditto.

[1]: https://patchwork.kernel.org/patch/10178813/

-- 
With Best Regards,
Andy Shevchenko
