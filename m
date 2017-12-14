From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [BUG] sound/soc/samsung: a possible sleep-in-atomic bugs in s3c_pcm_hw_params
Date: Thu, 14 Dec 2017 11:11:07 +0100
Message-ID: <CAJKOXPeNZDXFSC2NDMj4zERYEv58i+nqoA8D+GL827Sbmxxafg@mail.gmail.com>
References: <bb1c8c1d-4f99-7d47-818c-13e98cd024d5@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bb1c8c1d-4f99-7d47-818c-13e98cd024d5@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@163.com>
Cc: sbkim73@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 12, 2017 at 2:24 AM, Jia-Ju Bai <baijiaju1990@163.com> wrote:
> According to sound/soc/samsung/pcm.c, the kernel module may sleep under a
> spinlock.
> The function call path is:
> s3c_pcm_hw_params (acquire the spinlock)
>   clk_get_rate
>     clk_core_get_rate
>       clk_prepare_lock
>         mutex_lock --> may sleep
>
> I do not find a good way to fix it, so I only report.
> This possible bug is found by my static analysis tool (DSAC) and my code
> review.

Thanks for the report. Your finding looks correct, the code might
sleep under spinlock.

I do not see easy solution. Maybe the readl(regs + S3C_PCM_CLKCTL) and
clk_get_rate() could be moved before spinlock. The second path
modifying it - s3c_pcm_set_sysclk() - is not protected by it. The
spinlock is not effective around it.

Best regards,
Krzysztof
