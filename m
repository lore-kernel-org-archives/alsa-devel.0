From: Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH] ASoC: use DEFINE_SHOW_ATTRIBUTE() to
	decrease code duplication
Date: Fri, 9 Feb 2018 22:21:26 +0800
Message-ID: <CAErzpmuLvx-61EtXJ=p8dqZ3r-wLSEvmsLOcUz9jzzLzAAsxUA@mail.gmail.com>
References: <CAErzpmuKgMyxascCdq3KuF1F1K4e2ciZq7FKsOha6WSBgg-WYw@mail.gmail.com>
 <CAHp75Vdm3O5xiemr-H_nF__g43pe_f-Gp6QsOoRW-DXAXrm+YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 19894266E55
 for <alsa-devel@alsa-project.org>; Fri,  9 Feb 2018 15:21:48 +0100 (CET)
Received: by mail-qk0-f195.google.com with SMTP id n188so10136978qkn.11
 for <alsa-devel@alsa-project.org>; Fri, 09 Feb 2018 06:21:48 -0800 (PST)
In-Reply-To: <CAHp75Vdm3O5xiemr-H_nF__g43pe_f-Gp6QsOoRW-DXAXrm+YQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 9, 2018 at 9:21 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 9, 2018 at 8:58 AM, Donglin Peng <dolinux.peng@gmail.com> wrote:
>> There is some duplicate code in soc-core.c,and the kernel provides
>
> 'core.c,and' -> 'core.c, and'
>
>> +static int codec_list_show(struct seq_file *s, void *v)
>
> No need to rename m -> s.
>
>> +static int dai_list_show(struct seq_file *s, void *v)
>
> Ditto.
>
>> +static int platform_list_show(struct seq_file *s, void *v)
>
> Ditto.
>
> After addressing above,
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> --
> With Best Regards,
> Andy Shevchenko
Thanks for review, and I will send a patch v2.
