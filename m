From: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH -next] ALSA: ps3: Remove set but not used variables
 'start_vaddr' and 'pcm_index'
Date: Wed, 17 Apr 2019 11:19:30 -0700
Message-ID: <1078ccec-2cc9-f16d-caca-32ac9c3cce4d@infradead.org>
References: <20190417145722.20448-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417145722.20448-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yue Haibing <yuehaibing@huawei.com>, perex@perex.cz, tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 4/17/19 7:57 AM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warnings:
> 
> sound/ppc/snd_ps3.c: In function 'snd_ps3_program_dma':
> sound/ppc/snd_ps3.c:236:8: warning: variable 'start_vaddr' set but not used [-Wunused-but-set-variable]
> sound/ppc/snd_ps3.c: In function 'snd_ps3_pcm_open':
> sound/ppc/snd_ps3.c:529:6: warning: variable 'pcm_index' set but not used [-Wunused-but-set-variable]
> 
> They are never used and can be removed.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/ppc/snd_ps3.c | 4 ----
>  1 file changed, 4 deletions(-)

Seems OK.  Thanks for submitting.

Acked-by: Geoff Levand <geoff@infradead.org>
