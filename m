From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ASoC: use DEFINE_SHOW_ATTRIBUTE() to
	decrease code duplication
Date: Fri, 9 Feb 2018 15:21:17 +0200
Message-ID: <CAHp75Vdm3O5xiemr-H_nF__g43pe_f-Gp6QsOoRW-DXAXrm+YQ@mail.gmail.com>
References: <CAErzpmuKgMyxascCdq3KuF1F1K4e2ciZq7FKsOha6WSBgg-WYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id F1A50266E55
 for <alsa-devel@alsa-project.org>; Fri,  9 Feb 2018 14:21:19 +0100 (CET)
Received: by mail-qt0-f196.google.com with SMTP id s39so10472004qth.7
 for <alsa-devel@alsa-project.org>; Fri, 09 Feb 2018 05:21:19 -0800 (PST)
In-Reply-To: <CAErzpmuKgMyxascCdq3KuF1F1K4e2ciZq7FKsOha6WSBgg-WYw@mail.gmail.com>
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

On Fri, Feb 9, 2018 at 8:58 AM, Donglin Peng <dolinux.peng@gmail.com> wrote:
> There is some duplicate code in soc-core.c,and the kernel provides

'core.c,and' -> 'core.c, and'

> +static int codec_list_show(struct seq_file *s, void *v)

No need to rename m -> s.

> +static int dai_list_show(struct seq_file *s, void *v)

Ditto.

> +static int platform_list_show(struct seq_file *s, void *v)

Ditto.

After addressing above,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
