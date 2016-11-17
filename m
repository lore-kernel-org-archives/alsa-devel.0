From: bojan prtvar <prtvar.b@gmail.com>
Subject: Re: [patch] ASoC: sh: dma-sh7760: fix a debug printf
Date: Thu, 17 Nov 2016 14:31:06 +0100
Message-ID: <CAOmT4fR2Y5BPdpM8KrtdVqTpg2ewGOVyzzBC_wij55NSzbOdfQ@mail.gmail.com>
References: <20161117110046.GC32143@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20161117110046.GC32143@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Manuel Lauss <mano@roarinelk.homelinux.net>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Nov 17, 2016 at 12:00 PM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:

> -       pr_debug("PCM data: addr 0x%08ulx len %d\n",
> +       pr_debug("PCM data: addr 0x%08lx len %d\n",
>                  (u32)runtime->dma_addr, runtime->dma_bytes);

While there, why not using %pad as suggested by
Documentation/printk-formats.txt?

Regards,
Bojan
